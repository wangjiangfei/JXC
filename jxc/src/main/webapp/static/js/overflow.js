$(function(){
	//设置默认收货时间
	$('#overflowDate').datebox('setValue',genTodayStr());
	
	//设置时间组件可选的时间范围（不能小于当前日期）
	$('#overflowDate').datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var d = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return d<=date;
		}
	});
	
	//设置单号
	$('#overflowNumber').html(genOddNumbers('BY'));
	
	//绑定双击事件
	$('#dg2').datagrid({
		onDblClickRow:function(rowIndex,rowData){
			$('#chooseDlg').dialog({
				title:'选择商品',
				closed:false,
				top:$(window).height()/4,
				width: 500,
				height: 265,
				onClose:function(){
					$('#price').val('');
					$('#num').val('');
				}
			});
			$('#saveAndAddBtn').show();
			$('#saveBtn').show();
			$('#updateBtn').hide();
			$('#chooseFm').form('load',rowData);
			$('#lastPurchasingPrice').val('￥'+rowData.lastPurchasingPrice);
			$('#price').val(rowData.lastPurchasingPrice);
			$('#num').focus();
		}
	});
	
	$('#dg').datagrid({
		onDblClickRow:function(rowIndex,rowData){
			$('#chooseDlg').dialog({
				title:'修改商品',
				closed:false,
				top:$(window).height()/4,
				width: 500,
				height: 265,
				onClose:function(){
					$('#price').val('');
					$('#num').val('');
				}
			});
			$('#saveAndAddBtn').hide();
			$('#saveBtn').hide();
			$('#updateBtn').show();
			$('#chooseFm').form('load',rowData);
			$('#lastPurchasingPrice').val('￥'+rowData.lastPurchasingPrice);
			$('#price').val(rowData.price);
			$('#num').val(rowData.num);
			//将要修改的行号放于sessionStorage中
			sessionStorage.setItem('rowIndex',rowIndex);
		}
	});
	
	//为商品类别的添加和删除按钮单独绑定事件，防止按钮禁用后出现事件不可用的BUG
	$('#addButton').bind('click', openGoodsTypeAddDialog);
	$('#deleteButton').bind('click', deleteGoodsType);
});

/**
 * 打开商品报溢入库商品选择窗口
 */
function openOverflowListGoodsDialog(){
	$('#dlg').dialog({
		title:'商品报溢入库商品选择',
		closed:false,
		top:$(window).height()/6,
		left:$(window).width()/4,
		width: 900,
		height: 460,
		onClose:function(){
			$('#s_name').val('');
		}
	});
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
			$('#dg2').datagrid('load',{
				typeId:node.id
			});
		}
	});
}

/**
 * 格式价格
 */
function setPriceFormatter(value,row){
	
	
	return "￥"+value;
}

/**
* 打开新增商品类别窗口
*/
function openGoodsTypeAddDialog(){
	$('#typeDlg').dialog({
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
	$('#typeDlg').dialog('close');
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
				$('#typeDlg').dialog('close');
				$('#tree').tree('reload');
				$('#addButton').linkbutton('disable');
				$('#deleteButton').linkbutton('disable');
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
							$('#addButton').linkbutton('disable');
							$('#deleteButton').linkbutton('disable');
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
 * 搜索商品
 */
function searchGoods(){
	var selectNode = $('#tree').tree('getSelected');
	//如果是选了类别后的搜索，应该按照当前类别的商品来搜索，而不是在所有的商品中搜索
	if(selectNode!=null){
		$('#dg2').datagrid('load',{
			name:$('#s_name').val(),
			typeId:selectNode.id
		});
	}else{
		$('#dg2').datagrid('load',{
			name:$('#s_name').val(),
		});
	}
	
}

/**
 * 打开选择商品商品报溢设置窗口
 */
function openGoodsChooseDialog(){
	var selections = $('#dg2').datagrid('getSelections');
	if(selections.length!=1){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择一条数据',
			icon:'info', 
			top:$(window).height()/4
		});
		return;
	}
	
	$('#chooseDlg').dialog({
		title:'选择商品',
		closed:false,
		top:$(window).height()/4,
		width: 500,
		height: 265,
		onClose:function(){
			$('#price').val('');
			$('#num').val('');
		}
	});
	$('#saveAndAddBtn').show();
	$('#saveBtn').show();
	$('#updateBtn').hide();
	$('#chooseFm').form('load',selections[0]);
	$('#lastPurchasingPrice').val('￥'+selections[0].lastPurchasingPrice);
	$('#price').val(selections[0].lastPurchasingPrice);
	$('#num').focus();
}

/**
 * 关闭商品商品报溢设置窗口
 */
function closeGoodsChooseDlg(){
	$('#price').val('');
	$('#num').val('');
	$('#chooseDlg').dialog('close')
}

/**
 * 添加商品清单列表
 * @param type 按钮类型，1保存并继续新增 2保存并关闭
 */
function saveGoodsData(type){
	var num = $('#num').val();
	var price = $('#price').val();
	
	if(num==null || num==''){
		$.messager.alert({
			title:'系统提示',
			msg:'请输入库存',
			icon:'error', 
			top:$(window).height()/4
		});
		return;
	}
	if(price==null || price==''){
		$.messager.alert({
			title:'系统提示',
			msg:'请输入单价',
			icon:'error', 
			top:$(window).height()/4
		});
		return;
	}
	
	var selections = $('#dg2').datagrid('getSelections');
	var rows = $('#dg').datagrid('getRows');
	// 如果新增的商品，已经在商品清单列表里存在，那么则不再新增行记录，而是将数量和总金额进行累加
	var isExist = false;
	var existRow;
	for(var i=0;i<rows.length;i++){
		if(rows[i].code == selections[0].code){
			isExist = true;
			existRow = rows[i];
			break;
		}
	}
	
	if(isExist){
		$('#dg').datagrid('updateRow',{
			index:$('#dg').datagrid('getRowIndex',existRow),
			row:{
				goodsId:existRow.goodsId,
				goodsTypeId:existRow.goodsTypeId,
				code:existRow.code,
				name:existRow.name,
				model:existRow.model,
				unit:existRow.unit,
				lastPurchasingPrice:selections[0].lastPurchasingPrice,
				price:$('#price').val(),
				num:Number(existRow.num)+Number($('#num').val()),
				total:$('#num').val()*$('#price').val()+existRow.total
			}
		})
	}else{
		$('#dg').datagrid('appendRow',{
			goodsId:selections[0].id,
			goodsTypeId:selections[0].type.id,
			code:selections[0].code,
			name:selections[0].name,
			model:selections[0].model,
			unit:selections[0].unit,
			lastPurchasingPrice:selections[0].lastPurchasingPrice,
			price:$('#price').val(),
			num:$('#num').val(),
			total:$('#num').val()*$('#price').val()
		});
	}
	
	closeGoodsChooseDlg();
	
	if(type==2){
		$('#dlg').dialog('close');
	}
}

/**
 * 删除商品清单列表商品
 */
function deleteOverflowListGoods(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length!=1){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择一条要删除数据',
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
				//删除一行数据 通过index来删除
				$('#dg').datagrid('deleteRow',$('#dg').datagrid('getRowIndex',selections[0]));
			}
		}
	});
}

/**
 * 打开选择商品商品报溢修改窗口
 */
function openGoodsChooseModifyDialog(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length!=1){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择一条要修改的数据',
			icon:'info', 
			top:$(window).height()/4
		});
		return;
	}
	
	$('#chooseDlg').dialog({
		title:'修改商品',
		closed:false,
		top:$(window).height()/4,
		width: 500,
		height: 265,
		onClose:function(){
			$('#price').val('');
			$('#num').val('');
		}
	});
	$('#saveAndAddBtn').hide();
	$('#saveBtn').hide();
	$('#updateBtn').show();
	$('#chooseFm').form('load',selections[0]);
	$('#lastPurchasingPrice').val('￥'+selections[0].lastPurchasingPrice);
	$('#price').val(selections[0].price);
	$('#num').val(selections[0].num);
	//将要修改的行号放于sessionStorage中
	sessionStorage.setItem('rowIndex',$('#dg').datagrid('getRowIndex',selections[0]));
}

/**
 * 修改商品选择清单
 */
function updateGoodsData(){
	var num = $('#num').val();
	var price = $('#price').val();
	
	if(num==null || num==''){
		$.messager.alert({
			title:'系统提示',
			msg:'请输入库存',
			icon:'error', 
			top:$(window).height()/4
		});
		return;
	}
	if(price==null || price==''){
		$.messager.alert({
			title:'系统提示',
			msg:'请输入单价',
			icon:'error', 
			top:$(window).height()/4
		});
		return;
	}
	$('#dg').datagrid('updateRow',{
		index:sessionStorage.getItem('rowIndex'),
		row:{
			price:$('#price').val(),
			num:$('#num').val(),
			total:$('#num').val()*$('#price').val()
		}
	})
	sessionStorage.removeItem('rowIndex');
	closeGoodsChooseDlg();
}

/**
 * 保存商品报溢清单
 */
function saveOverflowData(){
	$('#overflowListGoodsStr').val(JSON.stringify($("#dg").datagrid("getData").rows));
	var overflowNumber = $('#overflowNumber').text();
	$('#fm').form('submit',{
		url:'/overflowListGoods/save?overflowNumber='+overflowNumber,
		onSubmit:function(){
			
			if($('#dg').datagrid('getRows').length<1){
				$.messager.alert({
					title:'系统提示',
					msg:'请添加报溢商品',
					icon:'error', 
					top:$(window).height()/4
				});
				return false;
			}
			
			return true;
		},
		success:function(result){
			var resultObj = eval('('+result+')');
			if(resultObj.resultCode=='001'){
				$.messager.alert({
					title:'系统提示',
					msg:resultObj.resultContent,
					icon:'info', 
					top:$(window).height()/4,
					fn:function(){
						window.location.reload();
					}
				});
			}else{
				$.messager.alert({
					title:'系统提示',
					msg:resultObj.resultContent,
					icon:'error', 
					top:$(window).height()/4
				});
			}
		}
	});
}