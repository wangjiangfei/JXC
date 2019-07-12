$(function(){
	//设置默认查询时间
	$('#etime').datebox('setValue',genTodayStr());
	$('#stime').datebox('setValue',genLastMonthDayStr());
	
	$.ajax({
		url:'/purchaseListGoods/count',
		dataType:'json',
		type:'post',
		data:{'sTime':genLastMonthDayStr(),'eTime':genTodayStr()},
		success:function(result){
			for(var i=0;i<result.length;i++){
				$('#dg').datagrid('appendRow',{
					number:result[i].number,
					type:'进货',
					date:result[i].date,
					supplierName:result[i].supplierName,
					code:result[i].code,
					name:result[i].name,
					model:result[i].model,
					goodsType:result[i].goodsType,
					unit:result[i].unit,
					price:'￥'+result[i].price,
					num:result[i].num,
					total:'￥'+result[i].total
				});
			}
		}
	});
	$.ajax({
		url:'/returnListGoods/count',
		dataType:'json',
		type:'post',
		data:{'sTime':genLastMonthDayStr(),'eTime':genTodayStr()},
		success:function(result){
			for(var i=0;i<result.length;i++){
				$('#dg').datagrid('appendRow',{
					number:result[i].number,
					type:'退货',
					date:result[i].date,
					supplierName:result[i].supplierName,
					code:result[i].code,
					name:result[i].name,
					model:result[i].model,
					goodsType:result[i].goodsType,
					unit:result[i].unit,
					price:'￥'+result[i].price,
					num:result[i].num,
					total:'￥'+result[i].total
				});
			}
		}
	});
});

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
		}
	});
	$('#dlg').dialog({
		title:'选择商品类别',
		iconCls:'add',
		closed:false,
		top:58,
		left:530,
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
}

//查询采购统计
function search(){
	$('#dg').datagrid('loadData',{rows:[]});
	var codeOrName = $('#s_codeOrName').val();
	var goodsTypeId = $('#s_typeId').val();
	var sTime = $('#stime').datebox('getValue');
	var eTime = $('#etime').datebox('getValue');
	if(new Date(Date.parse(sTime)) > new Date(Date.parse(eTime))){
		$.messager.alert({
			title:'系统提示',
			msg:'开始日期不能大于结束日期',
			icon:'error', 
			top:$(window).height()/4
		});
		return;
	}
	$.ajax({
		url:'/purchaseListGoods/count',
		dataType:'json',
		type:'post',
		data:{'sTime':sTime,'eTime':eTime,'goodsTypeId':goodsTypeId,'codeOrName':codeOrName},
		success:function(result){
			for(var i=0;i<result.length;i++){
				$('#dg').datagrid('appendRow',{
					number:result[i].number,
					type:'进货',
					date:result[i].date,
					supplierName:result[i].supplierName,
					code:result[i].code,
					name:result[i].name,
					model:result[i].model,
					goodsType:result[i].goodsType,
					unit:result[i].unit,
					price:'￥'+result[i].price,
					num:result[i].num,
					total:'￥'+result[i].total
				});
			}
		}
	});
	$.ajax({
		url:'/returnListGoods/count',
		dataType:'json',
		type:'post',
		data:{'sTime':sTime,'eTime':eTime,'goodsTypeId':goodsTypeId,'codeOrName':codeOrName},
		success:function(result){
			for(var i=0;i<result.length;i++){
				$('#dg').datagrid('appendRow',{
					number:result[i].number,
					type:'退货',
					date:result[i].date,
					supplierName:result[i].supplierName,
					code:result[i].code,
					name:result[i].name,
					model:result[i].model,
					goodsType:result[i].goodsType,
					unit:result[i].unit,
					price:'￥'+result[i].price,
					num:result[i].num,
					total:'￥'+result[i].total
				});
			}
		}
	});
}