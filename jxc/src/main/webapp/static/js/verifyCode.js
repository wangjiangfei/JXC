// 点击换一张验证码
function changeImg() {
	var imgSrc = $("#imgObj");   
    var src = imgSrc.attr("src");   
    imgSrc.attr("src",chgUrl());
}

// 时间戳
// 为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
function chgUrl() {
	var timestamp = (new Date()).valueOf();
	return '/drawImage?timestamp=' + timestamp;
}
