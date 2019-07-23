/**
 * 格式化角色设置样式
 */
function setRoleFormatter(value,row,index){
	
	//将当前这行的角色列表和用户ID都绑定至方法中
	return "<a href=\"javascript:openRoleSetDialog('"+row.roles+"',"+row.userId+")\">" +
				"<img style='margin-top:4px' src='../static/images/setRole.png'/>" +
			"</a>";
}

/**
 * 根据用户名模糊查询用户信息
 */
function searchUser(){
	
	$('#dg').datagrid('load',{
		userName:$('#s_userName').val()
	});
}

var url;

/**
 * 打开新增用户窗口
 */
function openUserAddDialog(){
	$('#dlg').dialog({
		title: '添加用户',
		iconCls: 'add',
		closed: false,
		top: $(window).height()/4,
		width: 450,
		height: 350,
		onClose:function(){
			$('#userName').val('');
			$('#password').val('');
			$('#repassword').val('');
			$('#remarks').val('');
		}
	});
	$('#userName').removeAttr('readonly');
	$('#userName').removeClass('readonly');
	url="/user/save";
}

/**
 * 打开修改用户窗口
 */
function openUserModifyDialog(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length<1){
		$.messager.alert({ 
			title:'系统提示',
			msg:'请选择一条您要修改的记录',
			icon:'error', 
			top:$(window).height()/4 
		});
		return;
	}
	//加载数据至表单
	$('#fm').form('load',selections[0]);
	$('#repassword').val(selections[0].password);
	//设置窗口相关属性，并打开
	$('#dlg').dialog({
		title:'修改用户',
		iconCls:'update',
		closed:false,
		top:$(window).height()/4,
		width: 450,
		height: 350,
		onClose:function(){
			$('#userName').val('');
			$('#trueName').val('');
			$('#password').val('');
			$('#repassword').val('');
			$('#remarks').val('');
		}
	});
	//用户名设置不可编辑
	$('#userName').attr('readonly','readonly');
	//为不可编辑添加样式
	$('#userName').addClass('readonly');
	
	url="/user/save?userId="+selections[0].userId;
}

/**
 * 关闭窗口
 */
function closeDlg(){
	$('#userName').val('');
	$('#trueName').val('');
	$('#password').val('');
	$('#repassword').val('');
	$('#remarks').val('');
	$('#dlg').dialog('close');
}

$(function(){
	//数据表格加载完毕后，绑定双击打开修改窗口事件
	$('#dg').datagrid({
		onDblClickRow:function(index,row){
			//加载数据至表单
			$('#fm').form('load',row);
			$('#repassword').val(row.password);
			$('#dlg').dialog({
				title:'修改用户',
				iconCls:'update',
				closed:false,
				top:$(window).height()/4,
				width: 450,
				height: 350,
				onClose:function(){
					$('#userName').val('');
					$('#trueName').val('');
					$('#password').val('');
					$('#repassword').val('');
					$('#remarks').val('');
				}
			});
			//用户名设置不可编辑
			$('#userName').attr('readonly','readonly');
			//为不可编辑添加样式
			$('#userName').addClass('readonly');
			
			url="/user/save?userId="+row.userId;
		}
	})
});

/**
 * 保存用户信息
 */
function saveData(){
	$('#fm').form('submit',{
		url: url,
		onSubmit:function() {
			if($('#userName').val() === null || $('#userName').val() === ''){
				$.messager.alert({
					title: '系统提示',
					msg: '请输入用户名',
					icon: 'error',
					top: $(window).height()/4
				});
				
				return false;
			}
			if($('#trueName').val() === null || $('#trueName').val() === ''){
				$.messager.alert({
					title: '系统提示',
					msg: '请输入真实姓名',
					icon: 'error',
					top: $(window).height()/4
				});
				
				return false;
			}
			if($('#password').val() === null || $('#password').val() === ''){
				$.messager.alert({
					title: '系统提示',
					msg: '请输入密码',
					icon: 'error',
					top: $(window).height()/4
				});
				
				return false;
			}
			if($('#password').val() !== $('#repassword').val()){
				$.messager.alert({
					title: '系统提示',
					msg: '两次密码输入不一致',
					icon: 'error',
					top: $(window).height()/4
				});
				
				return false;
			}
			
			return true;
		},
		success: function(result) {
			var resultJson = eval('('+result+')');
			console.log(result)
			if(resultJson.code === 100) {
				$.messager.alert({
					title: '系统提示',
					msg: '保存成功',
					icon: 'info',
					top:$(window).height()/4
				});
				$('#dlg').dialog('close');
				$('#dg').datagrid('reload');
			}else{
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
 * 删除用户信息
 */
function deleteUser(){
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
		fn:function(r){
			if(r){
				$.ajax({
					url:'/user/delete',
					dataType:'json',
					type:'post',
					data:{
						'userId': selections[0].userId
					},
					success:function(result){
						if(result.code === 100){
							$.messager.alert({
								title:'系统提示',
								msg: '删除成功',
								icon:'info', 
								top:$(window).height()/4 
							});
							$('#dg').datagrid('reload');
						}else{
							$.messager.alert({
								title:'系统提示',
								msg:result.msg,
								icon:'error', 
								top:$(window).height()/4 
							});
						}
					}
				});
			}
		}
	})
}

/**
 *  打开角色设置窗口
 */
function openRoleSetDialog(roles,userId){
	//打开窗口
	$('#dlg2').dialog({
		title: '设置角色',
		iconCls: 'set',
		closed: false,
		top: $(window).height()/4,
		left: $(window).width()/2.7,
		width: 450,
		height: 350
	});
	// 清空所有勾选
	$('#dg2').datagrid('uncheckAll');
	// 窗口打开后，把当前用户有的角色默认勾选上
	var rolesArr=roles.split(",");
	var allRows=$("#dg2").datagrid("getRows");
	for(var i = 0;i < allRows.length;i++){
		for(var n = 0;n < rolesArr.length; n++){
			if(allRows[i].roleName === rolesArr[n]){
				$("#dg2").datagrid("checkRow", i);
			}
		}
	}
	// 将所选的这条记录的用户ID存在sessionStorage中
	sessionStorage.setItem("userId", userId);
}

/**
 * 关闭设置角色窗口
 */
function closeRoleSetDialog(){
	$('#dlg2').dialog('close');
}

/**
 * 设置角色
 */
function setRole() {
	//获取用户ID
	var userId = sessionStorage.getItem("userId");
	var selections = $('#dg2').datagrid('getSelections');
	if(selections.length < 1) {
		$.messager.alert({
			title: '系统提示',
			msg: '请选择要设置的角色',
			icon: 'info',
			top: $(window).height()/4
		});
		
		return;
	}
	
	var rolesArray = [];
	for(var i = 0;i < selections.length;i++){
		rolesArray.push(selections[i].roleId);
	}
	var roles = rolesArray.join(',');
	
	$.ajax({
		url:'/user/setRole',
		type:'post',
		dataType:'json',
		data:{
			'userId':userId,
			'roles':roles
		},
		success:function(result){
			if(result.code === 100){
				$.messager.alert({
					title:'系统提示',
					msg: '保存成功',
					icon:'info', 
					top:$(window).height()/4 
				});
				$('#dlg2').dialog('close');
				$('#dg').datagrid('reload');
			}else{
				$.messager.alert({
					title:'系统提示',
					msg:result.msg,
					icon:'error', 
					top:$(window).height()/4 
				});
			}
		}
	});
	
	//清除sessionStorage
	sessionStorage.removeItem("userId");
}