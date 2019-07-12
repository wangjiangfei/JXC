/**
 * 格式价格
 */
function setPriceFormatter(value,row){
	
	
	return "￥"+value;
}

/**
 * 格式类别
 */
function setTypeFormatter(value,row){
	
	
	return row.type.name;
}
