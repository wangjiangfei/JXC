/**
 * 格式化商品类别名称
 */
function setGoodsTypeNameFormatter(value,row){

	return row.type.name;
}

/**
 * 格式价格
 */
function setPriceFormatter(value,row){
	
	
	return "￥"+value;
}

/**
 * 格式库存总值
 */
function setInventoryTotalPrice(value,row){
	
	
	return "￥"+(row.inventoryQuantity * row.sellingPrice);
}

/**
 * 打开商品类别选择树
 */
function openGoodsTypeTreeDlg(){
	$('#tree').tree({
		url:'/goodsType/loadGoodsType',
		lines:true,
		onLoadSuccess:function(){
			//展开所有节点
			$('#tree').tree('expandAll');
		},
		onDblClick:function(node){
			if(node.id==1){
				$('#s_typeName').val('');
				$('#s_typeId').val('');
			}else{
				$('#s_typeName').val(node.text);
				$('#s_typeId').val(node.id);
			}
			$('#dlg').dialog('close');
			searchStock();
		}
	});
	$('#dlg').dialog({
		title:'选择商品类别',
		iconCls:'add',
		closed:false,
		top:52,
		left:95,
		width: 200,
		height: 400
	});
}

/**
 * 关闭商品类别选择
 */
function closeGoodsTypeTreeDlg(){
	$('#dlg').dialog('close');
}

/**
 * 选择商品类别
 */
function chooseGoodsType(){
	var selectNode = $('#tree').tree('getSelected');
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
		$('#s_typeName').val('');
		$('#s_typeId').val('');
	}else{
		$('#s_typeName').val(selectNode.text);
		$('#s_typeId').val(selectNode.id);
	}
	
	$('#dlg').dialog('close');
	searchStock();
}

/**
 * 按条件搜索当前库存信息
 */
function searchStock(){
	$('#dg').datagrid('load',{
		codeOrName:$('#s_codeOrName').val(),
		typeId:$('#s_typeId').val()
	});
}