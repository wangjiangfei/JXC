package com.wangjiangfei.service.impl;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.wangjiangfei.dao.MenuDao;
import com.wangjiangfei.entity.Log;
import com.wangjiangfei.entity.Menu;
import com.wangjiangfei.entity.Role;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/18 15:54
 * @description
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuDao menuDao;
    @Autowired
    private LogService logService;

    @Override
    public String loadMenu(HttpSession session) {
        // 获取登录中的角色
        Role currentRole = (Role) session.getAttribute("currentRole");

        return this.getAllMenu(-1,currentRole.getRoleId()).toString();// 根节点默认从-1开始
    }

    /**
     * 递归查询当前角色下的所有菜单
     * @return
     */
    public JsonArray getAllMenu(Integer parentId, Integer roleId){

        JsonArray array = this.getMenuByParentId(parentId, roleId);

        for(int i = 0;i < array.size();i++){

            JsonObject obj = (JsonObject) array.get(i);

            if(obj.get("state").getAsString().equals("open")){//如果是叶子节点，不再递归

                continue;

            }else{//如果是根节点，继续递归查询

                obj.add("children", this.getAllMenu(obj.get("id").getAsInt(),roleId));

            }

        }

        return array;
    }

    /**
     * 根据父菜单ID获取菜单
     * @return
     */
    public JsonArray getMenuByParentId(Integer parentId,Integer roleId){

        JsonArray array = new JsonArray();

        List<Menu> menus = menuDao.getMenuByParentId(parentId, roleId);

        //遍历菜单
        for(Menu menu : menus){

            JsonObject obj = new JsonObject();

            obj.addProperty("id", menu.getMenuId());// 菜单ID

            obj.addProperty("text", menu.getMenuName());// 菜单名称

            obj.addProperty("iconCls", menu.getMenuIcon());// 图标

            if(menu.getMenuState() == 1) {

                obj.addProperty("state", "closed"); // 根节点

            }else{

                obj.addProperty("state", "open");// 叶子节点
            }

            JsonObject attributes = new JsonObject(); //扩展属性

            attributes.addProperty("url", menu.getMenuUrl());

            obj.add("attributes", attributes);

            array.add(obj);

        }

        return array;
    }

    @Override
    public String loadCheckMenu(Integer roleId) {
        List<Menu> menuList = menuDao.getMenuByRoleId(roleId);

        List<Integer> menuIds = new ArrayList<>();

        for(Menu menu : menuList) {

            menuIds.add(menu.getMenuId());

        }

        logService.save(new Log(Log.SELECT_ACTION, "查询菜单信息"));

        return this.getCheckAllMenu(-1,menuIds).toString(); //根节点默认从-1开始
    }

    /**
     * 递归查询所有菜单
     * @return
     */
    public JsonArray getCheckAllMenu(Integer parentId,List<Integer> menuIds){

        JsonArray array = this.getCheckMenuByParentId(parentId, menuIds);

        for(int i=0;i<array.size();i++){

            JsonObject obj = (JsonObject) array.get(i);

            if(obj.get("state").getAsString().equals("open")){//如果是叶子节点，不再递归

                continue;

            }else{//如果是根节点，继续递归查询

                obj.add("children", this.getCheckAllMenu(obj.get("id").getAsInt(),menuIds));

            }

        }

        return array;
    }

    /**
     * 根据父菜单ID获取所有子菜单
     * @return
     */
    public JsonArray getCheckMenuByParentId(Integer parentId,List<Integer> menuIds){

        JsonArray array = new JsonArray();

        List<Menu> menuList = menuDao.getAllMenuByParentId(parentId);

        //遍历菜单
        for(Menu menu : menuList){

            JsonObject obj = new JsonObject();

            obj.addProperty("id", menu.getMenuId());//菜单ID

            obj.addProperty("text", menu.getMenuName());//菜单名称

            obj.addProperty("iconCls", menu.getMenuIcon());//图标

            if(menu.getMenuState() == 1){

                obj.addProperty("state", "closed"); //根节点

            }else{

                obj.addProperty("state", "open");//叶子节点
            }

            if(menuIds.contains(menu.getMenuId())){

                obj.addProperty("checked", true);

            }

            JsonObject attributes = new JsonObject(); //扩展属性

            attributes.addProperty("url", menu.getMenuUrl());

            obj.add("attributes", attributes);

            array.add(obj);


        }

        return array;
    }
}
