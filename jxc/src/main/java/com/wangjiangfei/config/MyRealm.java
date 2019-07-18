package com.wangjiangfei.config;

import com.wangjiangfei.dao.MenuDao;
import com.wangjiangfei.dao.RoleDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.entity.Menu;
import com.wangjiangfei.entity.Role;
import com.wangjiangfei.entity.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/14 13:55
 * @description 自定义Realm
 */
public class MyRealm extends AuthorizingRealm{
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private MenuDao menuDao;

	/**
	 * 角色授权
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		
		//获取当前登录的用户名
		String userName = (String) SecurityUtils.getSubject().getPrincipal();
		
		//根据用户名查询用户信息
		User user = userDao.findUserByName(userName);
		
		SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		
		//查询当前登录用户所拥有的角色
		List<Role> roleList = roleDao.getRoleByUserId(user.getUserId());
		
		//添加角色权限
		for(Role role : roleList){
			
			simpleAuthorizationInfo.addRole(role.getRoleName());
			
			//查询当前角色所拥有的菜单
			List<Menu> menuList = menuDao.getMenuByRoleId(role.getRoleId());
			
			//添加菜单权限
			for(Menu menu : menuList){
				
				simpleAuthorizationInfo.addStringPermission(menu.getMenuName());
				
			}
			
		}

		return simpleAuthorizationInfo;
	}

	/**
	 * 身份认证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		//获取当前用户输入的用户名
		String userName = (String) token.getPrincipal();
		
		User user = userDao.findUserByName(userName);
		
		if(user!=null){
			
			AuthenticationInfo auth = new SimpleAuthenticationInfo(user.getUserName(), user.getPassword(), getName());
			
			return auth;
			
		}else{
			
			return null;
			
		}
		
	}

}
