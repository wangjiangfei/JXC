$(document).ready(function() {
	//加载商品类别
	$('#tree').tree({
		url:'/goodsType/loadGoodsType',
		lines:true,
		onLoadSuccess:function(){
			//展开所有节点
			$('#tree').tree('expandAll');
		},
		onClick:function(node){
			if(node.attributes.state==0){
				$('#deleteButton').linkbutton('enable');
			}else{
				$('#deleteButton').linkbutton('disable');
			}
			$('#addButton').linkbutton('enable');
			$('#dg').datagrid('load',{
				typeId:node.id
			});
		}
	});
});

/**
 * 打开新增商品类别窗口
 */
function openGoodsTypeAddDialog(){
	$('#dlg').dialog({
		title:'添加商品类别',
		iconCls:'add',
		closed:false,
		top:$(window).height()/4,
		width: 350,
		height: 125,
		onClose:function(){
			$('#name').val('');
		}
	});
}

/**
 * 关闭新增商品类别窗口
 */
function closeDlg(){
	$('#name').val('');
	$('#dlg').dialog('close');
}

/**
 * 添加商品类别
 */
function saveData(){
	var name = $('#name').val();
	if(name==null || name==''){
		$.messager.alert({
			title:'系统提示',
			msg:'请输入商品类别名称',
			icon:'error', 
			top:$(window).height()/4
		});
		return;
	}
	var selectNode = $('#tree').tree('getSelected');
	$.ajax({
		url:'/goodsType/save',
		type:'post',
		dataType:'json',
		data:{'name':name,'pId':selectNode.id},
		success:function(result){
			if(result.resultCode=='001'){
				$.messager.alert({
					title:'系统提示',
					msg:result.resultContent,
					icon:'info', 
					top:$(window).height()/4
				});
				$('#dlg').dialog('close');
				$('#tree').tree('reload');
				$('#deleteButton').linkbutton('disable');
				$('#addButton').linkbutton('disable');
			}
		},
		error:function(){
			$.messager.alert({
				title:'系统提示',
				msg:'新增商品类别失败，请重试',
				icon:'error', 
				top:$(window).height()/4
			});
		}
	});
}

/**
 * 删除商品类别
 */
function deleteGoodsType(){
	$.messager.confirm({
		title:'系统提示',
		msg:'您确定要删除这条记录吗？',
		top:$(window).height()/4,
		fn:function(r){
			if(r){
				$.ajax({
					url:'/goodsType/delete',
					dataType:'json',
					type:'post',
					data:{'id':$('#tree').tree('getSelected').id},
					success:function(result){
						if(result.resultCode==001){
							$.messager.alert({
								title:'系统提示',
								msg:result.resultContent,
								icon:'info', 
								top:$(window).height()/4 
							});
							$('#tree').tree('reload');
						}else{
							$.messager.alert({
								title:'系统提示',
								msg:result.resultContent,
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
 * 格式化商品类别ID
 */
function setGoodsIdFormatter(value,row){
	
	return row.type.id;
}

/**
 * 格式化商品名称
 */
function setGoodsNameFormatter(value,row){

	return row.type.name;
}

/**
 * 格式价格
 */
function setPriceFormatter(value,row){
	
	
	return "￥"+value;
}

/**
 * 搜索商品
 */
function searchGoods(){
	var selectNode = $('#tree').tree('getSelected');
	//如果是选了类别后的搜索，应该按照当前类别的商品来搜索，而不是在所有的商品中搜索
	if(selectNode!=null){
		$('#dg').datagrid('load',{
			name:$('#s_name').val(),
			typeId:selectNode.id
		});
	}else{
		$('#dg').datagrid('load',{
			name:$('#s_name').val(),
		});
	}
	
}

var url;

/**
 * 打开新增商品窗口
 */
function openGoodsAddDialog(){
	$('#dlg2').dialog({
		title:'添加商品',
		iconCls:'add',
		closed:false,
		top:$(window).height()/4,
		width: 450,
		height: 420,
		onClose:function(){
			$('#goodsName').val('');
			$('#typeName').val('');
			$('#typeId').val('');
			$('#code').val('');
			$('#model').val('');
			$('#unit').val('');
			$('#purchasingPrice').val('');
			$('#sellingPrice').val('');
			$('#minNum').val('');
			$('#producer').val('');
			$('#remarks').val('');
			closeUnitAddDlg();
			closeUnitDlg();
			closeGoodsTypeTreeDlg();
		}
	});
	
	var selectNode = $('#tree').tree('getSelected');
	if(selectNode!=null && selectNode.id!=1){
		$('#typeId').val(selectNode.id);
		$('#typeName').val(selectNode.text);
	}
	
	//生成商品编码
	$.ajax({
		url:'/goods/getCode',
		dataType:'json',
		type:'post',
		success:function(result){
			$('#code').val(result.resultContent);
		}
	});
	$('#saveAndAdd').show();
	url="/goods/save";
}

/**
 * 添加商品信息
 */
function saveGoodsData(type){
	$('#fm2').form('submit',{
		url:url,
		onSubmit:function(){
			if($('#typeName').val()==null || $('#typeName').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请选择商品类别',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#goodsName').val()==null || $('#goodsName').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输商品名称',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#model').val()==null || $('#model').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入商品型号',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#unit').val()==null || $('#unit').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请选择商品单位',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#purchasingPrice').val()==null || $('#purchasingPrice').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入采购价格',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#sellingPrice').val()==null || $('#sellingPrice').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入销售价格',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#minNum').val()==null || $('#minNum').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入库存下限',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#producer').val()==null || $('#producer').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入生产厂商',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
		
			return true;
		},
		success:function(result){
			var resultJson = eval('('+result+')');
			if(resultJson.resultCode==001){
				$.messager.alert({
					title:'系统提示',
					msg:resultJson.resultContent,
					icon:'info', 
					top:$(window).height()/4
				});
				$('#goodsName').val('');
				$('#typeName').val('');
				$('#typeId').val('');
				$('#code').val('');
				$('#model').val('');
				$('#unit').val('');
				$('#purchasingPrice').val('');
				$('#sellingPrice').val('');
				$('#minNum').val('');
				$('#producer').val('');
				$('#remarks').val('');
				if(type==1){
					var node=$("#tree").tree("getSelected");
					if(node!=null && node.id!=1){
						$("#typeId").val(node.id);
						$("#typeName").val(node.text);
					}else{
						$("#typeId").val("");
						$("#typeName").val("");
					}
					//生成商品编码
					$.ajax({
						url:'/goods/getCode',
						dataType:'json',
						type:'post',
						success:function(result){
							$('#code').val(result.resultContent);
						}
					});
				}else{
					$('#dlg2').dialog('close');
				}
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
 * 打开商品修改窗口
 */
function openGoodsModifyDialog(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length!=1){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择一条要修改的记录',
			icon:'info', 
			top:$(window).height()/4 
		});
		return;
	}
	$('#fm2').form('load',selections[0]);
	$('#typeId').val(selections[0].type.id);
	$('#typeName').val(selections[0].type.name);
	$('#dlg2').dialog({
		title:'修改商品',
		iconCls:'update',
		closed:false,
		top:$(window).height()/4,
		width: 450,
		height: 420,
		onClose:function(){
			$('#goodsName').val('');
			$('#typeName').val('');
			$('#typeId').val('');
			$('#code').val('');
			$('#model').val('');
			$('#unit').val('');
			$('#purchasingPrice').val('');
			$('#sellingPrice').val('');
			$('#minNum').val('');
			$('#producer').val('');
			$('#remarks').val('');
			closeUnitAddDlg();
			closeUnitDlg();
			closeGoodsTypeTreeDlg();
		}
	});
	$('#saveAndAdd').hide();
	
	url="/goods/save?id="+selections[0].id;
}

/**
 * 删除商品
 */
function deleteGoods(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length!=1){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择一条要删除的记录',
			icon:'info', 
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
					url:'/goods/delete',
					dataType:'json',
					type:'post',
					data:{'goodsId':selections[0].id},
					success:function(result){
						if(result.resultCode==001){
							$.messager.alert({
								title:'系统提示',
								msg:result.resultContent,
								icon:'info', 
								top:$(window).height()/4 
							});
							$('#dg').datagrid('reload');
						}else{
							$.messager.alert({
								title:'系统提示',
								msg:result.resultContent,
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
 * 关闭商品新增或修改窗口
 */
function closeGoodsDlg(){
	$('#goodsName').val('');
	$('#typeName').val('');
	$('#typeId').val('');
	$('#code').val('');
	$('#model').val('');
	$('#unit').val('');
	$('#purchasingPrice').val('');
	$('#sellingPrice').val('');
	$('#minNum').val('');
	$('#producer').val('');
	$('#remarks').val('');
	$('#dlg2').dialog('close');
	closeUnitAddDlg();
	closeUnitDlg();
	closeGoodsTypeTreeDlg();
	
}

/**
 * 打开商品类别选择树
 */
function openGoodsTypeTreeDlg(){
	$('#tree2').tree({
		url:'/goodsType/loadGoodsType',
		lines:true,
		onLoadSuccess:function(){
			//展开所有节点
			$('#tree2').tree('expandAll');
		},
		onDblClick:function(node){
			if(node.id==1){
				$.messager.alert({
					title:'系统提示',
					msg:'请选择子分类',
					icon:'error', 
					top:$(window).height()/4
				});
				
				return;
			}
			$('#typeName').val(node.text);
			$('#typeId').val(node.id);
			$('#dlg3').dialog('close')
		}
	});
	$('#dlg3').dialog({
		title:'选择商品类别',
		iconCls:'add',
		closed:false,
		top:$(window).height()/4,
		width: 200,
		height: 400
	});
}

/**
 * 关闭商品类别选择
 */
function closeGoodsTypeTreeDlg(){
	$('#dlg3').dialog('close');
}

/**
 * 选择商品类别
 */
function chooseGoodsType(){
	var selectNode = $('#tree2').tree('getSelected');
	if(selectNode==null){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择商品类别',
			icon:'error', 
			top:$(window).height()/4
		});
		
		return;
	}
	if(selectNode.id==1){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择子分类',
			icon:'error', 
			top:$(window).height()/4
		});
		
		return;
	}
	
	$('#typeName').val(selectNode.text);
	$('#typeId').val(selectNode.id);
	$('#dlg3').dialog('close');
}

/**
 * 打开单位选择窗口
 */
function openUnitDlg(){
	$('#dlg4').dialog({
		title:'选择单位',
		iconCls:'add',
		closed:false,
		top:$(window).height()/4,
		left:$(window).width()/2.5,
		width: 200,
		height: 400,
		onClose:function(){
			closeUnitAddDlg();
		}
	});
	$('#unitDg').datagrid({
		onDblClickCell:function(rowIndex,field,value){
			$('#unit').val(value);
			$('#dlg4').dialog('close');
		}
	});
}

/**
 * 选择单位
 */
function chooseUnit(){
	var selectTions = $('#unitDg').datagrid('getSelections');
	if(selectTions.length<1){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择单位',
			icon:'error', 
			top:$(window).height()/4
		});
		
		return;
	}
	
	$('#unit').val(selectTions[0].name);
	$('#dlg4').dialog('close');

}

/**
 * 关闭单位选择窗口
 */
function closeUnitDlg(){
	$('#dlg4').dialog('close');
	closeUnitAddDlg();
}

/**
 * 删除单位
 */
function deleteUnit(){
	var selections = $('#unitDg').datagrid('getSelections');
	if(selections.length<1){
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
					url:'/unit/delete',
					dataType:'json',
					type:'post',
					data:{'unitId':selections[0].id},
					success:function(result){
						if(result.resultCode==001){
							$.messager.alert({
								title:'系统提示',
								msg:result.resultContent,
								icon:'info', 
								top:$(window).height()/4 
							});
							$('#unitDg').datagrid('reload');
						}else{
							$.messager.alert({
								title:'系统提示',
								msg:result.resultContent,
								icon:'error', 
								top:$(window).height()/4 
							});
						}
					}
				});
			}
		}
	});
}

/**
 * 打开单位添加窗口
 */
function openUnitAddDialog(){
	$('#dlg5').dialog({
		title:'添加单位',
		iconCls:'add',
		closed:false,
		top:$(window).height()/3,
		width: 350,
		height: 125,
		onClose:function(){
			$('#unitName').val('');
		}
	});
}

/**
 * 关闭单位添加窗口
 */
function closeUnitAddDlg(){
	$('#unitName').val('');
	$('#dlg5').dialog('close');
}

/**
 * 添加单位
 */
function saveUnitData(){
	$('#fm3').form('submit',{
		url:'/unit/save',
		onSubmit:function(){
			if($('#unitName').val()==null || $('#unitName').val()==''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入单位',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
		
			return true;
		},
		success:function(result){
			var resultJson = eval('('+result+')');
			if(resultJson.resultCode==001){
				$.messager.alert({
					title:'系统提示',
					msg:resultJson.resultContent,
					icon:'info', 
					top:$(window).height()/4
				});
				$('#dlg5').dialog('close');
				$('#unitDg').datagrid('reload');
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