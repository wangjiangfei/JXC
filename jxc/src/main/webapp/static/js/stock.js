/**
 * 格式价格
 */
function setPriceFormatter(value,row){
	
	
	return "￥"+value;
}

/**
 * 格式价格
 */
function setInventoryQuantityPriceFormatter(value,row){
	
	
	return "￥"+(row.purchasingPrice*row.inventoryQuantity);
}

/**
 * 搜索无库存商品
 */
function searchNoInventoryQuantityGoods(){
	$('#dg').datagrid('load',{
		nameOrCode:$('#s_nameOrCode').val(),
	});
}

/**
 * 搜索有库存商品
 */
function searchHasInventoryQuantityGoods(){
	$('#dg2').datagrid('load',{
		nameOrCode:$('#s_nameOrCode2').val(),
	});
}

var url;

/**
 * 打开商品库存窗口
 * @param type
 */
function openInventoryQuantityDlg(type){
	$('#inventoryQuantity').val('');
	$('#purchasingPrice').val('');
	var selections;
	var icon;
	if (type === 1) {
		selections = $('#dg').datagrid('getSelections');
		icon = 'add';
	} else {
		selections = $('#dg2').datagrid('getSelections');
		icon = 'update';
	}
	
	if (selections.length !== 1) {
		$.messager.alert({ 
			title:'系统提示',
			msg:'请选择一条记录',
			icon:'error',
			top:$(window).height()/4 
		});
		return;
	}
	
	$('#dlg').dialog({
		title:'库存商品期初建账',
		iconCls:icon,
		closed:false,
		top:$(window).height()/4,
		width: 450,
		height: 250,
		onClose:function(){
			$('#inventoryQuantity').val('');
			$('#purchasingPrice').val('');
		}
	});
	
	$('#fm').form('load',selections[0]);
	$('#price').val('￥'+selections[0].purchasingPrice);
	if (type === 2) {
		$('#fm2').form('load',selections[0]);
	}
	$('#inventoryQuantity').focus();// 设置光标
	url = '/goods/saveStock?goodsId='+selections[0].goodsId;
}

/**
 * 关闭商品库存窗口
 */
function closeDlg(){
	$('#inventoryQuantity').val('');
	$('#purchasingPrice').val('');
	$('#dlg').dialog('close');
}

/**
 * 保存库存信息
 */
function saveData(){
	$('#fm2').form('submit',{
		url: url,
		onSubmit:function(){
			if($('#inventoryQuantity').val()===null || $('#inventoryQuantity').val()===''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入库存',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			if($('#purchasingPrice').val()===null || $('#purchasingPrice').val()===''){
				$.messager.alert({
					title:'系统提示',
					msg:'请输入成本价',
					icon:'error', 
					top:$(window).height()/4 
				});
				
				return false;
			}
			return true;
		},
		success: function(result){
			var resultJson = eval('('+result+')');
			if(resultJson.code === 100){
				$.messager.alert({
					title:'系统提示',
					msg: '保存成功',
					icon:'info', 
					top:$(window).height()/4
				});
				$('#dlg').dialog('close');
				$('#dg').datagrid('reload');
				$('#dg2').datagrid('reload');
			}else {
				$.messager.alert({
					title:'系统提示',
					msg:resultJson.msg,
					icon:'error', 
					top:$(window).height()/4 
				});
			}
		}
	})
}

/**
 * 删除商品库存
 */
function deleteGoodsStock(){
	var selections = $('#dg2').datagrid('getSelections');
	if (selections.length !== 1) {
		$.messager.alert({ 
			title:'系统提示',
			msg:'请选择您要删除的一条记录',
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
					url:'/goods/deleteStock',
					dataType:'json',
					type:'post',
					data:{
						'goodsId':selections[0].goodsId
					},
					success:function(result) {
						if (result.code === 100) {
							$.messager.alert({
								title:'系统提示',
								msg: '删除成功',
								icon:'info', 
								top:$(window).height()/4 
							});
							$('#dg').datagrid('reload');
							$('#dg2').datagrid('reload');
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