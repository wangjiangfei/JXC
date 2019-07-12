$(function(){
	convertDatebox('etime');
	convertDatebox('stime');
	
	//设置默认查询时间
	$('#etime').datebox('setValue',genTodayStr().substring(0, 7));
	$('#stime').datebox('setValue',genLastYearStr().substring(0, 7));
	
	//默认加载近1年的报表数据
	$.ajax({
		url:'/saleListGoods/getSaleDataByMonth',
		type:'post',
		dataType:'json',
		data:{'sTime':genLastYearStr().substring(0, 7),'eTime':genTodayStr().substring(0, 7)},
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
 * 格式化easyui时间空间，使之只显示年月
 * @param domId
 */
function convertDatebox(domId) {
    $("#" + domId).datebox({
    	currentText:"本月", //格式化按钮文本
        onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
            span.trigger('click'); //触发click事件弹出月份层
            if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
                tds = p.find('div.calendar-menu-month-inner td');
                tds.click(function (e) {
                    e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
                    var year = /\d{4}/.exec(span.html())[0]//得到年份
                    , month = parseInt($(this).attr('abbr'), 10); //月份
                    $("#" + domId).datebox('hidePanel')//隐藏日期对象
                    .datebox('setValue', year + '-' + month); //设置日期的值
                });
            }, 0)
        },
        parser: function (s) {//配置parser，返回选择的日期
        	if (!s) return new Date();
            var ss = (s.split('-'));
            var y = parseInt(ss[0],10);
            var m = parseInt(ss[1],10);            
            if (!isNaN(y) && !isNaN(m)){
                return new Date(y,m-1);
            } else {
                return new Date();
            } 
        },
        formatter: function (d) {//配置formatter，只返回年月
              var y = d.getFullYear();
              var m = d.getMonth()+1;
              var d = d.getDate();
              return y+'-'+(m<10?('0'+m):m);
        }
    });
    var p = $("#" + domId).datebox('panel'), //日期选择对象
        tds = false, //日期选择对象中月份
        span = p.find('span.calendar-text'); //显示月份层的触发控件
}

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
				text: '按月统计分析',
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
	$('#dg').datagrid('loadData',{rows:[]});
	$.ajax({
		url:'/saleListGoods/getSaleDataByMonth',
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