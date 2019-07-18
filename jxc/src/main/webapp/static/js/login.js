/**
 * 页面加载完毕后执行
 */
$(document).ready(function() {
	  // 粒子背景特效
	  $('body').particleground({
	    dotColor: '#5cbdaa',
	    lineColor: '#5cbdaa'
	  });
	  
	  // 绑定登录按钮事件
	  $('#loginBtn').click(login);
	  
	  // 绑定登录回车事件
	  $('body').keydown(function(event){
		  if(event.keyCode === 13){
			  login();
		  }
	  });
	  
	  // 这里的代码用于解决当系统Session超时iframe的内嵌窗口不能正常的跳回到登录页面，而是将登录页直接嵌套在了iframe里
	  // 所以我们需要找到该iframe的父窗口来进行加载
	  if(window.parent !== window){// window.parent:如果不存在父窗口，那么该值默认为当前窗口对象
		  window.parent.location.reload(true);
	  }
});

/**
 * 提交登录
 */
function login() {
	$.ajax({
		  url:'user/login',
		  type:'post',
		  data: JSON.stringify({
              userName: $('#userName').val(),
              password: $('#password').val(),
              imageCode: $('#imageCode').val()
          }),
		  dataType: 'json',
		  contentType: 'application/json',
		  success: function(result) {
			  if(result.code === 100){
				  // 如果当前用户只有一个角色，则无需选择，直接跳转进主页
				  if(result.info.length === 1){
					  $.ajax({
						url:'role/saveRole',
						type:'post',
						data: JSON.stringify({
							'roleId':result.info[0].roleId
						}),
						dataType:'json',
					  	contentType: 'application/json',
						success: function(result){
							if(result.code === 100){
								window.location.href='main.html';
							}
						}
					  });
				  } else { // 如果当前用户不止一个角色，则需要选择
					  var roleInput = ''
					  for(var i = 0;i < result.info.length;i++){
						  if(i === 0){
							  roleInput = roleInput+'<input name="role" type="radio" value="'+result.info[i].roleId+'" checked=true />'+result.info[i].roleName+'&nbsp;&nbsp;';
						  } else {
							  roleInput = roleInput+'<input name="role" type="radio" value="'+result.info[i].roleId+'" />'+result.info[i].roleName+'&nbsp;&nbsp;';
						  }
					  }
					  modelRole(roleInput);
				  }
			  }else{
				  modelMsg(result.msg);
			  }
		  }
	  });
}

/**
 * model消息窗口
 * @param msg 具体内容
 */
function modelMsg(msg) {
	 $('.buttonCls input').click(closeModel);
	 $('#light h4').html('系统提示');
	 $('#light .msg').html(msg);
	 $('#light').show();
	 $('#fade').show();
}

/**
 * 关闭model窗口
 */
function closeModel() {
	 $('#light').hide();
	 $('#fade').hide();
}

/**
 * model角色选择窗口
 * @param msg 可选择的角色
 */
function modelRole(msg) {
	$('.buttonCls input').click(saveRole);
	$('#light h4').html('请选择登录角色');
	$('#light .msg').html(msg);
	$('#light').show();
	$('#fade').show();
}

/**
 * 保存选中的角色
 */
function saveRole(){
	var roleId = $('.msg input[name=role]:checked').val();
	$.ajax({
		url: 'role/saveRole',
		type: 'post',
		data: JSON.stringify({
			'roleId': roleId
		}),
		dataType:'json',
        contentType: 'application/json',
		success: function(result) {
			if(result.code === 100){
				window.location.href='main.html';
			}
		}
	});
}