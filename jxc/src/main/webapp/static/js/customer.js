/**
 * 根据客户名模糊查询客户信息
 */
function searchCustomer(){
	
	$('#dg').datagrid('load',{
        customerName:$('#s_name').val()
	});
}

var url;

/**
 * 打开新增客户窗口
 */
function openCustomerAddDialog(){
	$('#dlg').dialog({
		title:'添加客户',
		iconCls:'add',
		closed:false,
		top:$(window).height()/4,
		width: 500,
		height: 350,
		onClose:function(){
			$('#name').val('');
			$('#contacts').val('');
			$('#phoneNumber').val('');
			$('#address').val('');
			$('#remarks').val('');
		}
	});

	url="/customer/save";
}

/**
 * 打开修改客户窗口
 */
function openCustomerModifyDialog(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length < 1) {
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
	//设置窗口相关属性，并打开
	$('#dlg').dialog({
		title:'修改客户',
		iconCls:'update',
		closed:false,
		top:$(window).height()/4,
		width: 500,
		height: 350,
		onClose:function(){
			$('#name').val('');
			$('#contacts').val('');
			$('#phoneNumber').val('');
			$('#address').val('');
			$('#remarks').val('');
		}
	});
	
	url="/customer/save?customerId="+selections[0].customerId;
}

/**
 * 关闭窗口
 */
function closeDlg(){
	$('#name').val('');
	$('#contacts').val('');
	$('#phoneNumber').val('');
	$('#address').val('');
	$('#remarks').val('');
	$('#dlg').dialog('close');
}

$(function(){
	//数据表格加载完毕后，绑定双击打开修改窗口事件
	$('#dg').datagrid({
		onDblClickRow:function(index,row){
			//加载数据至表单
			$('#fm').form('load',row);
			$('#dlg').dialog({
				title:'修改客户',
				iconCls:'update',
				closed:false,
				top:$(window).height()/4,
				width: 500,
				height: 350,
				onClose:function(){
					$('#name').val('');
					$('#contacts').val('');
					$('#phoneNumber').val('');
					$('#address').val('');
					$('#remarks').val('');
				}
			});
			
			url="/customer/save?customerId="+row.customerId;
		}
	})
});

/**
 * 保存客户信息
 */
function saveData(){
	$('#fm').form('submit',{
		url:url,
		onSubmit:function(){
			if($('#name').val()===null || $('#name').val()===''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入客户名称',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#contacts').val()===null || $('#contacts').val()===''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入联系人',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#phoneNumber').val()===null || $('#phoneNumber').val()===''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入联系电话',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#address').val()===null|| $('#address').val()===''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入客户地址',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			
			return true;
		},
		success:function(result){
			var resultJson = eval('('+result+')');
			if(resultJson.code===100){
				$.messager.alert({
					title:'系统提示',
					msg: '保存成功',
					icon:'info', 
					top:$(window).height()/4
				});
				$('#dlg').dialog('close');
				$('#dg').datagrid('reload');
			}else{
				$.messager.alert({
					title:'系统提示',
					msg:resultJson.resultContent,
					icon:'error', 
					top:$(window).height()/4 
				});
			}
		}
	})
}

/**
 * 删除用户信息
 */
function deleteCustomer(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length<1){
		$.messager.alert({ 
			title:'系统提示',
			msg:'请选择您要删除的记录',
			icon:'error', 
			top:$(window).height()/4 
		});
		return;
	}
	$.messager.confirm({
		title:'系统提示',
		msg:'您确定要删除这'+selections.length+'条记录吗？',
		top:$(window).height()/4,
		fn:function(r){
			if(r){
				var idsAr = [];
				for(var i=0;i<selections.length;i++){
					idsAr.push(selections[i].customerId);
				}
				var ids = idsAr.join(",");
				$.ajax({
					url:'/customer/delete',
					dataType:'json',
					type:'post',
					data:{
						'ids':ids
					},
					success:function(result){
						if(result.code===100){
							$.messager.alert({
								title:'系统提示',
								msg:'删除成功',
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