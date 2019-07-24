/**
 * 重置搜索栏
 */
function reset(){
	$('#cc').combobox('setValue','');
	$('#s_trueName').val('');
	$('#s_stime').datetimebox('setValue','');
	$('#s_etime').datetimebox('setValue','');
}

/**
 * 条件搜索日志
 */
function searchLog(){
	
	$('#dg').datagrid('load',{
		logType:$('#cc').combobox('getValue'),
		trueName:$('#s_trueName').val(),
		sTime:$('#s_stime').datetimebox('getValue'),
		eTime:$('#s_etime').datetimebox('getValue')
	});
}