/**
 * 格式化菜单设置样式
 */
function setMenuFormatter(value,row,index){
	
	return "<a href=\"javascript:openMenuSetDialog("+row.roleId+")\">" +
				"<img style='margin-top:4px' src='../static/images/setRole.png'/>" +
			"</a>";
}

/**
 * 根据角色名模糊查询用户信息
 */
function searchRole() {
	
	$('#dg').datagrid('load',{
		roleName:$('#s_roleName').val()
	});
}

var url;

/**
 * 打开新增角色窗口
 */
function openRoleAddDialog(){
	$('#dlg').dialog({
		title: '添加角色',
		iconCls: 'add',
		closed: false,
		top: $(window).height()/4,
		width: 450,
		height: 250,
		onClose: function() {
			$('#name').val('');
			$('#remarks').val('');
		}
	});

	url="/role/save";
}

/**
 * 打开修改角色窗口
 */
function openRoleModifyDialog() {
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length < 1) {
		$.messager.alert({ 
			title: '系统提示',
			msg: '请选择一条您要修改的记录',
			icon: 'error',
			top: $(window).height()/4
		});
		return;
	}
	//加载数据至表单
	$('#fm').form('load',selections[0]);
	//设置窗口相关属性，并打开
	$('#dlg').dialog({
		title: '修改角色',
		iconCls:  'update',
		closed: false,
		top: $(window).height()/4,
		width: 450,
		height: 250,
		onClose: function() {
			$('#name').val('');
			$('#remarks').val('');
		}
	});
	
	url="/role/save?roleId=" + selections[0].roleId;
}

/**
 * 关闭窗口
 */
function closeDlg(){
	$('#name').val('');
	$('#remarks').val('');
	$('#dlg').dialog('close');
}

$(function(){
	// 数据表格加载完毕后，绑定双击打开修改窗口事件
	$('#dg').datagrid({
		onDblClickRow: function(index, row) {
			// 加载数据至表单
			$('#fm').form('load', row);
			$('#dlg').dialog({
				title: '修改角色',
				iconCls: 'update',
				closed: false,
				top:$(window).height()/4,
				width: 450,
				height: 250,
				onClose: function() {
					$('#name').val('');
					$('#remarks').val('');
				}
			});
			
			url="/role/save?roleId=" + row.roleId;
		}
	})
});

/**
 * 保存角色信息
 */
function saveData() {
	$('#fm').form('submit', {
		url: url,
		onSubmit: function(){
			if($('#name').val() === null || $('#name').val() === ''){
				$.messager.alert({
					title: '系统提示',
					msg: '请输入角色名',
					icon: 'error',
					top: $(window).height()/4
				});
				
				return false;
			}
			
			return true;
		},
		success: function(result) {
			var resultJson = eval('('+result+')');
			if(resultJson.code === 100) {
				$.messager.alert({
					title: '系统提示',
					msg: '添加成功',
					icon: 'info',
					top: $(window).height()/4
				});
				$('#dlg').dialog('close');
				$('#dg').datagrid('reload');
			} else {
				$.messager.alert({
					title: '系统提示',
					msg: resultJson.msg,
					icon: 'error',
					top: $(window).height()/4
				});
			}
		}
	})
}

/**
 * 删除角色信息
 */
function deleteRole(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length < 1) {
		$.messager.alert({ 
			title:'系统提示',
			msg:'请选择一条您要删除的记录',
			icon:'error', 
			top:$(window).height()/4 
		});
		return;
	}
	$.messager.confirm({
		title:'系统提示',
		msg:'您确定要删除这条记录吗？',
		top:$(window).height()/4,
		fn:function(r) {
			if(r) {
				$.ajax({
					url:'/role/delete',
					dataType:'json',
					type:'post',
					data: {
						'roleId':selections[0].roleId
					},
					success: function(result){
						if(result.code === 100){
							$.messager.alert({
								title: '系统提示',
								msg: '删除成功',
								icon:'info', 
								top:$(window).height()/4 
							});
							$('#dg').datagrid('reload');
						}else{
							$.messager.alert({
								title: '系统提示',
								msg: result.msg,
								icon: 'error',
								top: $(window).height()/4
							});
						}
					}
				});
			}
		}
	})
}

/**
 *  打开菜单设置窗口
 */
function openMenuSetDialog(roleId){
	//打开窗口
	$('#dlg2').dialog({
		title: '设置菜单',
		iconCls: 'set',
		closed: false,
		top: $(window).height()/6,
		left: $(window).width()/2.7,
		width: 300,
		height: 500
	});
	// 设置开关
	var flag = true;
	// 加载菜单树
	$('#menuTree').tree({
		url: '/menu/loadCheckMenu?roleId='+roleId,
		lines:  true,
		checkbox: true,
		cascadeCheck: false,
		onLoadSuccess: function() {
			// 展开所有节点
			$('#menuTree').tree('expandAll');
		},
		onCheck: function(node,checked){
			// easy-ui的onCheck事件操作中，如果设置节点check也会触发这个事件
			// 这里设置一个开关来控制触发，当进入事件后，先把开关关闭，防止设置的check的节点也来触发这个事件
			// 当所有节点处理完毕后，再打开开关，等待下一次的触发
			if (flag) {
				flag = false;
				checkParentMenu(node);
				checkChildrenMenu(node);
				flag = true;
			}
		}
	});
	// 将所选的这条记录的用户ID存在sessionStorage中
	sessionStorage.setItem("roleId", roleId);
}

/**
 * 级联勾选父类菜单
 */
function checkParentMenu(node){
	var parentNode = $('#menuTree').tree('getParent',node.target);
	if(!parentNode){
		return;
	}else{
		checkParentMenu(parentNode);
		$('#menuTree').tree('check',parentNode.target);
	}
}

/**
 * 级联勾选或取消勾选子类菜单
 * @param node
 */
function checkChildrenMenu(node){
	var childrenNode = $('#menuTree').tree('getChildren',node.target);
	if(!childrenNode || childrenNode.length<1){
		return;
	}else{
		if(node.checked){//如果父菜单是选中状态，需要把所有子菜单也勾选
			for(var i=0;i<childrenNode.length;i++){
				$('#menuTree').tree('check',childrenNode[i].target);
			}
		}else{//如果父菜单是未选中状态，需要把所有子菜单也取消勾选
			for(var i=0;i<childrenNode.length;i++){
				$('#menuTree').tree('uncheck',childrenNode[i].target);
			}
		}
	}
}

/**
 *  关闭设置菜单权限窗口
 */
function closeMenuSetDialog(){
	$('#dlg2').dialog('close');
}

/**
 * 设置菜单权限
 */
function setMenu(){
	//获取角色ID
	var roleId = sessionStorage.getItem("roleId");
	var checkeds = $('#menuTree').tree('getChecked');
	if(checkeds.length < 1) {
		$.messager.alert({
			title:'系统提示',
			msg:'请选择要设置的菜单权限',
			icon:'info', 
			top:$(window).height()/4 
		});
		
		return;
	}
	
	var menusArray = [];
	for(var i=0;i<checkeds.length;i++){
		menusArray.push(checkeds[i].id);
	}
	var menus = menusArray.join(',');
	
	$.ajax({
		url: '/role/setMenu',
		type: 'post',
		dataType: 'json',
		data: {
			'roleId':roleId,
			'menus':menus
		},
		success:function(result){
			if(result.code === 100){
				$.messager.alert({
					title: '系统提示',
					msg: '设置成功',
					icon: 'info',
					top: $(window).height()/4
				});
				$('#dlg2').dialog('close');
				$('#dg').datagrid('reload');
			}else{
				$.messager.alert({
					title: '系统提示',
					msg: result.msg,
					icon: 'error',
					top: $(window).height()/4
				});
			}
		}
	});
	
	//清除sessionStorage
	sessionStorage.removeItem("roleId");
}