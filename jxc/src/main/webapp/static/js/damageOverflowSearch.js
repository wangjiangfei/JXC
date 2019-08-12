$(function(){
	// 设置默认查询时间
	$('#etime').datebox('setValue',genTodayStr());
	$('#stime').datebox('setValue',genLastMonthDayStr());
	
	// 默认加载报损单查询
	$.ajax({
		url:'/damageListGoods/list',
		dataType:'json',
		type:'post',
		data:{
			'sTime':genLastMonthDayStr(),
			'eTime':genTodayStr()
		},
		success:function(result){
			var rows = result.rows;
			for(var i = 0;i < rows.length;i++){
				$('#dg').datagrid('appendRow',{
					id:rows[i].damageListId,
					number:rows[i].damageNumber,
					date:rows[i].damageDate,
					type:'报损单',
					user:rows[i].trueName,
					remarks:rows[i].remarks
				});
			}
			// 为报损报溢单表格绑定单击事件
			$('#dg').datagrid({
				onClickRow:function(index,row){
					$('#dg2').datagrid({
						url:'/damageListGoods/goodsList',
						queryParams:{
							damageListId:row.id
						}
					});
				}
			});
		}
	});
});

//格式化进货金额
function amountPayableFmt(value,row){
	
	return '￥'+value;
}

// 根据条件查询报损报溢单信息
function search(){
	// 每次查询时，先清空报损报溢单商品列表
	$('#dg').datagrid('loadData',{rows:[]});
	$('#dg2').datagrid('loadData',{rows:[]});
	var type = $('#cc').combobox('getValue');
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
	if(type==='1'){//如果为报损单查询
		$.ajax({
			url:'/damageListGoods/list',
			dataType:'json',
			type:'post',
			data:{
				'sTime':sTime,
				'eTime':eTime
			},
			success:function(result){
				var rows = result.rows;
				for(var i = 0;i < rows.length;i++){
					$('#dg').datagrid('appendRow',{
						id:rows[i].damageListId,
						number:rows[i].damageNumber,
						date:rows[i].damageDate,
						type:'报损单',
						user:rows[i].trueName,
						remarks:rows[i].remarks
					});
				}
				//为报损报溢单表格绑定单击事件
				$('#dg').datagrid({
					onClickRow:function(index,row){
						$('#dg2').datagrid({
							url:'/damageListGoods/goodsList',
							queryParams:{
								damageListId:row.id
							}
						});
					}
				});
			}
		});
	}else{// 如果为报溢单查询
		$.ajax({
			url:'/overflowListGoods/list',
			dataType:'json',
			type:'post',
			data:{
				'sTime':sTime,
				'eTime':eTime
			},
			success:function(result){
				var rows = result.rows;
				for(var i = 0;i < rows.length;i++){
					$('#dg').datagrid('appendRow',{
						id:rows[i].overflowListId,
						number:rows[i].overflowNumber,
						date:rows[i].overflowDate,
						type:'报溢单',
						user:rows[i].trueName,
						remarks:rows[i].remarks
					});
				}
				// 为报损报溢单表格绑定单击事件
				$('#dg').datagrid({
					onClickRow:function(index,row){
						$('#dg2').datagrid({
							url:'/overflowListGoods/goodsList',
							queryParams:{
								overflowListId:row.id
							}
						});
					}
				});
			}
		});
	}
}