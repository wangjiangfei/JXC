/**
 * 根据时间戳生成单号
 */
function genOddNumbers(type){
	
	return type + new Date().getTime();
}


function genTodayStr(){
	var date = new Date();
	
	return date.getFullYear()+"-"+formatZero(date.getMonth()+1)+"-"+formatZero(date.getDate());
}

function genLastYearStr(){
	var date = new Date();
	date.setFullYear(date.getFullYear()-1);
	return date.getFullYear()+"-"+formatZero(date.getMonth()+1)+"-"+formatZero(date.getDate());
}

function genLastMonthDayStr(){
	var date = new Date();

	return date.getFullYear()+"-"+formatZero(date.getMonth())+"-"+formatZero(date.getDate());
}

function genLastWeekDayStr(){
	var date = new Date();
	date.setDate(date.getDate()-6);
	return date.getFullYear()+"-"+formatZero(date.getMonth()+1)+"-"+formatZero(date.getDate());
}

function formatZero(n){
	if (n < 10) {
		return "0" + n;
	} else {
		return n;
	}
}