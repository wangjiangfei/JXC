$(function(){
	//设置默认查询时间
	$('#etime').datebox('setValue',genTodayStr());
	$('#stime').datebox('setValue',genLastMonthDayStr());
	
	//设置下拉框
	$('#customer').combobox({
		 mode:'remote',
		 url:'/customer/getComboboxList',
		 valueField:'id',
		 textField:'name'
	});
	
	$.ajax({
		url:'/saleListGoods/list',
		dataType:'json',
		type:'post',
		data:{'sTime':genLastMonthDayStr(),'eTime':genTodayStr()},
		success:function(result){
			var rows = result.rows;
			for(var i=0;i<rows.length;i++){
				$('#dg').datagrid('appendRow',{
					id:rows[i].id,
					customerName:rows[i].customer.name,
					number:rows[i].saleNumber,
					date:rows[i].saleDate,
					type:'销售单',
					amountPayable:rows[i].amountPayable,
					state:rows[i].state==1?'已付款':'未付款',
					user:rows[i].user.trueName,
					remarks:rows[i].remarks
				});
			}
		}
	});
	$.ajax({
		url:'/customerReturnListGoods/list',
		dataType:'json',
		type:'post',
		data:{'sTime':genLastMonthDayStr(),'eTime':genTodayStr()},
		success:function(result){
			var rows = result.rows;
			for(var i=0;i<rows.length;i++){
				$('#dg').datagrid('appendRow',{
					id:rows[i].id,
					customerName:rows[i].customer.name,
					number:rows[i].customerReturnNumber,
					date:rows[i].customerReturnDate,
					type:'退货单',
					amountPayable:rows[i].amountPayable,
					state:rows[i].state==1?'已退款':'未退款',
					user:rows[i].user.trueName,
					remarks:rows[i].remarks
				});
			}
		}
	});
	//为表格绑定单击事件
	$('#dg').datagrid({
		onClickRow:function(index,row){
			if(row.type=='销售单'){
				$('#dg2').datagrid({
					url:'/saleListGoods/goodsList',
					queryParams:{
						saleListId:row.id
					}
				});
			}else{
				$('#dg2').datagrid({
					url:'/customerReturnListGoods/goodsList',
					queryParams:{
						customerReturnListId:row.id
					}
				});
			}
		}
	});
});

//格式化金额
function amountPayableFmt(value,row){
	
	return '￥'+value;
}

//根据条件查询供应商统计信息
function search(){
	//每次查询时，先清列表
	$('#dg').datagrid('loadData',{rows:[]});
	$('#dg2').datagrid('loadData',{rows:[]});
	var customerId = $('#customer').combobox('getValue');
	var state = $('#cc').combobox('getValue');
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
		url:'/saleListGoods/list',
		dataType:'json',
		type:'post',
		data:{'sTime':sTime,'eTime':eTime,'state':state,'customerId':customerId},
		success:function(result){
			var rows = result.rows;
			for(var i=0;i<rows.length;i++){
				$('#dg').datagrid('appendRow',{
					id:rows[i].id,
					customerName:rows[i].customer.name,
					number:rows[i].saleNumber,
					date:rows[i].saleDate,
					type:'销售单',
					amountPayable:rows[i].amountPayable,
					state:rows[i].state==1?'已付款':'未付款',
					user:rows[i].user.trueName,
					remarks:rows[i].remarks
				});
			}
		}
	});
	$.ajax({
		url:'/customerReturnListGoods/list',
		dataType:'json',
		type:'post',
		data:{'sTime':sTime,'eTime':eTime,'state':state,'customerId':customerId},
		success:function(result){
			var rows = result.rows;
			for(var i=0;i<rows.length;i++){
				$('#dg').datagrid('appendRow',{
					id:rows[i].id,
					customerName:rows[i].customer.name,
					number:rows[i].customerReturnNumber,
					date:rows[i].customerReturnDate,
					type:'退货单',
					amountPayable:rows[i].amountPayable,
					state:rows[i].state==1?'已退款':'未退款',
					user:rows[i].user.trueName,
					remarks:rows[i].remarks
				});
			}
		}
	});
	//为表格绑定单击事件
	$('#dg').datagrid({
		onClickRow:function(index,row){
			if(row.type=='销售单'){
				$('#dg2').datagrid({
					url:'/saleListGoods/goodsList',
					queryParams:{
						saleListId:row.id
					}
				});
			}else{
				$('#dg2').datagrid({
					url:'/customerReturnListGoods/goodsList',
					queryParams:{
						customerReturnListId:row.id
					}
				});
			}
		}
	});
}

/**
 * 支付结算
 */
function settlement(){
	var selections = $('#dg').datagrid('getSelections');
	if(selections.length!=1){
		$.messager.alert({
			title:'系统提示',
			msg:'请选择一条要结算的记录',
			icon:'info', 
			top:$(window).height()/4
		});
		return;
	}
	
	if(selections[0].state=='已付款' || selections[0].state=='已退款'){
		$.messager.alert({
			title:'系统提示',
			msg:'该单据已结算，请选择未结算的单据',
			icon:'info', 
			top:$(window).height()/4
		});
		return;
	}
	
	$.messager.confirm({
		title:'系统提示',
		msg:'您确定要结算单据吗？',
		top:$(window).height()/4,
		fn:function(r){
			if(r){
				if(selections[0].type=='销售单'){
					$.ajax({
						url:'/saleListGoods/updateState',
						dataType:'json',
						type:'post',
						data:{'id':selections[0].id},
						success:function(result){
							if(result.resultCode=='001'){
								$.messager.alert({
									title:'系统提示',
									msg:result.resultContent,
									icon:'info', 
									top:$(window).height()/4
								});
								search();
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
				}else{
					$.ajax({
						url:'/customerReturnListGoods/updateState',
						dataType:'json',
						type:'post',
						data:{'id':selections[0].id},
						success:function(result){
							if(result.resultCode=='001'){
								$.messager.alert({
									title:'系统提示',
									msg:result.resultContent,
									icon:'info', 
									top:$(window).height()/4
								});
								search();
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
		}
	});	
}