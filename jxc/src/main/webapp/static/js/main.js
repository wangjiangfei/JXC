$(document).ready(function() {

	window.setInterval("showTime()", 1);
	// 加载用户信息
	$.ajax({
		url: 'user/loadUserInfo',
		type: 'get',
		datType: 'json',
		success: function(result) {
			$("#userInfo").html('欢迎您：'+result.userName+'&nbsp;[&nbsp;'+result.roleName+'&nbsp;]');
		}
	});
	
	//加载首页
	$('#tabs').tabs('add',{
		title:'首页',
		closable: false,
		iconCls: 'icon-home',
		content: '<iframe scrolling="auto" height="99%" width="99.7%" src="common/stockSearch.html"></iframe>'
	});
	
	// 加载菜单
	$('#tree').tree({
		url: 'menu/loadMenu',
		lines: true,
		onLoadSuccess: function(){
			//展开所有节点
			$('#tree').tree('expandAll');
		},
		onClick: function(node) {
			openTabs(node);
		}
	});
	
	// 监听右键事件，创建右键菜单
    $('#tabs').tabs({
        onContextMenu:function(e, title,index){
            e.preventDefault();
            if(index > 0) {
                $('#menu').menu('show', {// 打开菜单
                    left: e.pageX,
                    top: e.pageY
                }).data("tabTitle", title);// 将标签页名称绑定属性
            }
        }
    });
	
	 // 菜单click
    $('#menu').menu({
        onClick : function (item) {
        	//传入当前选中的目标对象，以及当前菜单的name属性
            closeTab(this,item.name);
        }
    });
    
    // 根据用户的选择来关闭标签
    function closeTab(menu, type) {
        var allTabs = $("#tabs").tabs('tabs');
        var allTabtitle = [];
        $.each(allTabs, function (i, n) {
            var opt = $(n).panel('options');
            if (opt.closable)
                allTabtitle.push(opt.title);
        });
        var curTabTitle = $(menu).data('tabTitle');
        var curTabIndex = $('#tabs').tabs('getTabIndex', $('#tabs').tabs('getTab', curTabTitle));
        switch (type) {
       		case 1: // 刷新当前标签页
	            var panel = $('#tabs').tabs('getTab', curTabTitle).panel('refresh');
	            break;
            case 2: // 关闭当前标签页
                $("#tabs").tabs("close", curTabIndex);
                break;
            case 3: // 关闭全部标签页
                for (var i = 0; i < allTabtitle.length; i++) {
                    $('#tabs').tabs('close', allTabtitle[i]);
                }
                break;
            case 4: // 关闭其他标签页
                for (var i = 0; i < allTabtitle.length; i++) {
                    if (curTabTitle !== allTabtitle[i])
                        $('#tabs').tabs('close', allTabtitle[i]);
                }
                $('#tabs').tabs('select', curTabTitle);
                break;
            case 5: // 关闭右侧标签页
                for (var i = curTabIndex; i < allTabtitle.length; i++) {
                    $('#tabs').tabs('close', allTabtitle[i]);
                }
                $('#tabs').tabs('select', curTabTitle);
                break;
            case 6: // 关闭左侧标签页
                for (var i = 0; i < curTabIndex - 1; i++) {
                    $('#tabs').tabs('close', allTabtitle[i]);
                }
                $('#tabs').tabs('select', curTabTitle);
                break;

        }

    }
	 
});

// 显示当前时间
function showTime(){
	var date = new Date();
	this.year = date.getFullYear();
	this.month = date.getMonth() + 1;
	this.date = date.getDate();
	this.day = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六")[date.getDay()];
	this.hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
	this.minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
	this.second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
	
	$("#clock").html("现在是:" + this.year + "年" + this.month + "月" + this.date + "日 " + this.hour + ":" + this.minute + ":" + this.second + " " + this.day);
}

// 打开标签页
function openTabs(node){
	// 如果为修改密码，则打开修改密码的Dialog
	if(node.id === 6040){
		$('#updatePasswordDlg').dialog({
			title: '修改密码',
			iconCls: 'update',
			closed: false,
			top: $(window).height()/4,
			width: 350,
			height: 160,
			onClose: function() {
				$('#newPassword').val('');
				$('#reNewPassword').val('');
			}
		});
	}else if(node.id === 6050){// 如果为安全退出，则直接退出系统
		$.messager.confirm({
			title: '系统提示',
			msg: '您确定要退出系统吗？',
			fn: function(r) {
				if (r) {
					window.location.href='/user/logOut';
				}
			}
		})
	} else if (node.attributes.url === '' || node.attributes.url === null) {

	}else if($('#tabs').tabs('exists',node.text)){//如果标签页已存在，则选中
		$('#tabs').tabs('select',node.text)
	}else{
		$('#tabs').tabs('add',{// 添加新的标签页
			title: node.text,
			closable: true,
			iconCls: node.iconCls,
			content:'<iframe scrolling="auto" height="99%" width="99.5%" src="'+node.attributes.url+'"></iframe>'
		});
	}
}

/**
 * 关闭修改密码窗口
 */
function closeUpdatePassowrdDlg(){
	$('#newPassword').val('');
	$('#reNewPassword').val('');
	$('#updatePasswordDlg').dialog('close');
}

/**
 * 修改密码
 */
function saveNewPassword(){
	$('#updatePassowrdFm').form('submit',{
		url: '/user/updatePassword',
		onSubmit: function() {
			if($('#newPassword').val() !== $('#reNewPassword').val()){
				$.messager.alert({
					title: '系统提示',
					msg: '两次密码输入不一致',
					icon: 'error',
					top: $(window).height()/4
				});
				
				return false;
			}
			return true;
		},
		success: function(result) {
			var resultJson = eval('('+result+')');
			if(resultJson.code === 100){
				$.messager.alert({
					title: '系统提示',
					msg: '修改成功',
					icon: 'info',
					top: $(window).height()/4
				});
				$('#updatePasswordDlg').dialog('close');
			}else{
				$.messager.alert({
					title: '系统提示',
					msg: resultJson.msg,
					icon: 'error',
					top: $(window).height()/4
				});
			}
		}
	});
}