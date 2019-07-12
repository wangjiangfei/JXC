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
	
	//按默认查询条件进行首次查询
	$('#dg').datagrid({
		url:'/saleListGoods/list',
		queryParams:{
			sTime:genLastMonthDayStr(),
			eTime:genTodayStr()
		}
	});
	
	//为销售单表格绑定单击事件
	$('#dg').datagrid({
		onClickRow:function(index,row){
			$('#dg2').datagrid({
				url:'/saleListGoods/goodsList',
				queryParams:{
					saleListId:row.id
				}
			});
		}
	});
});

//格式化销售金额
function amountPayableFmt(value,row){
	
	return '￥'+value;
}

//格式化客户
function customerFmt(value,row){
	
	return row.customer.name;
}

//格式化操作员
function userFmt(value,row){
	
	return row.user.trueName;
}

//格式化付款状态
function stateFmt(value,row){
	
	return value=='1'?'已付':'未付';
}

//重置搜索条件
function reset(){
	$('#s_saleNumber').val('');
	$('#customer').combobox('setValue','');
	$('#cc').combobox('setValue','');
	$('#etime').datebox('setValue',genTodayStr());
	$('#stime').datebox('setValue',genLastMonthDayStr());
}

//根据条件查询销售单信息
function search(){
	//每次查询时，先清空销售单商品列表
	$('#dg2').datagrid('loadData',{rows:[]});
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
	$('#dg').datagrid({
		url:'/saleListGoods/list',
		queryParams:{
			saleNumber:$('#s_saleNumber').val(),
			customerId:$('#customer').combobox('getValue'),
			state:$('#cc').combobox('getValue'),
			sTime:sTime,
			eTime:eTime
		}
	});
}

/**
 * 删除销售单
 */
function deleteSaleList(){
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
		msg:'<font color=red>删除销售单据将无法恢复，您确定要删除吗？</font>',
		top:$(window).height()/4,
		fn:function(r){
			if(r){
				$.ajax({
					url:'/saleListGoods/delete',
					dataType:'json',
					type:'post',
					data:{'saleListId':selections[0].id},
					success:function(result){
						if(result.resultCode==001){
							$.messager.alert({
								title:'系统提示',
								msg:result.resultContent,
								icon:'info', 
								top:$(window).height()/4 
							});
							$('#dg').datagrid('reload');
							$('#dg2').datagrid('reload');
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