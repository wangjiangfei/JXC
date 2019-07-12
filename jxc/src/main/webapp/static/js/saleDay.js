$(function(){
	
	//设置默认查询时间
	$('#etime').datebox('setValue',genTodayStr());
	$('#stime').datebox('setValue',genLastWeekDayStr());
	
	//默认加载近7天的报表数据
	$.ajax({
		url:'/saleListGoods/getSaleDataByDay',
		type:'post',
		dataType:'json',
		data:{'sTime':genLastWeekDayStr(),'eTime':genTodayStr()},
		success:function(result){
			var dateArray = [];
			var profitArray = [];
			var saleTotalCount = 0;
			var purchasingTotalCount = 0;
			var profitCount = 0;
			for(var i=0;i<result.length;i++){
				dateArray.push(result[i].date);
				profitArray.push(result[i].profit);
				$('#dg').datagrid('appendRow',{
					date:result[i].date,
					saleTotal:'￥'+result[i].saleTotal,
					purchasingTotal:'￥'+result[i].purchasingTotal,
					profit:'￥'+result[i].profit
				});
				saleTotalCount+=result[i].saleTotal;
				purchasingTotalCount+=result[i].purchasingTotal
				profitCount+=result[i].profit;
			}
			$('#dg').datagrid('appendRow',{
				date:'总计',
				saleTotal:'￥'+saleTotalCount,
				purchasingTotal:'￥'+purchasingTotalCount,
				profit:'￥'+profitCount
			});
			setEcharts(dateArray,profitArray);
		}
	});
});

/**
 * 柱状图设置
 * @param dateArray 时间数组
 * @param profitArray 利润数组
 */
function setEcharts(dateArray,profitArray){
	//初始化echarts实例
	var myChart = echarts.init(document.getElementById('main'));
	option = {
			title:{
				text: '按日统计分析',
				x: 'center'
			},
		    color: ['#3398DB'],
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {
		            type : 'shadow'
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : dateArray,
		            axisTick: {
		                alignWithLabel: true
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name : '单位（元）'
		        }
		    ],
		    series : [
		        {
		            name:'销售利润',
		            type:'bar',
		            barWidth: '50%',
		            data:profitArray
		        }
		    ]
		};
	
	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
}


function search(){
	$('#dg').datagrid('loadData',{rows:[]});
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
		url:'/saleListGoods/getSaleDataByDay',
		type:'post',
		dataType:'json',
		data:{'sTime':sTime,'eTime':eTime},
		success:function(result){
			var dateArray = [];
			var profitArray = [];
			var saleTotalCount = 0;
			var purchasingTotalCount = 0;
			var profitCount = 0;
			for(var i=0;i<result.length;i++){
				dateArray.push(result[i].date);
				profitArray.push(result[i].profit);
				$('#dg').datagrid('appendRow',{
					date:result[i].date,
					saleTotal:'￥'+result[i].saleTotal,
					purchasingTotal:'￥'+result[i].purchasingTotal,
					profit:'￥'+result[i].profit
				});
				saleTotalCount+=result[i].saleTotal;
				purchasingTotalCount+=result[i].purchasingTotal
				profitCount+=result[i].profit;
			}
			$('#dg').datagrid('appendRow',{
				date:'总计',
				saleTotal:'￥'+saleTotalCount,
				purchasingTotal:'￥'+purchasingTotalCount,
				profit:'￥'+profitCount
			});
			setEcharts(dateArray,profitArray);
		}
	});
}