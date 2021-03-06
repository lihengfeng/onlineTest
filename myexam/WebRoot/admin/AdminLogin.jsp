<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线系统后台登录</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/checkCode.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		// 点击注册按钮，如果用户名、密码为空则提示用户名与密码不能为空。 判断用户输入的两次密码是否一致，不一致的话，提示密码输入不一致。 如果以上条件都没问题则注册成功。
		$("#btnReg").click(function() {
			if ($("#Adminno").val() == "") {
				alert("管理员账号不能为空");
			} else if ($("#Adminpwd").val() == "") {
				alert("密码不能为空");
			}else if ($("#submitcode").val() != $("#code2").val()) {
				alert("验证码输入有误或未输入，请重新输入验证码");
			} else if ($("#Adminno").val() != "") {
				$.post("${pageContext.request.contextPath}/Admins/selectAll", {
					"adminno" : $("#Adminno").val(),
					"adminpwd" : $("#Adminpwd").val(),
				}, function(data,status) {
					//跳转登录页面
					if (data) {
						location.href = "main.jsp";
					} else {
					alert("用户名或密码不正确");
						location.href = "AdminLogin.jsp";
						
					}
				});

			}
		});

		//提示用户名不能为空
		$("#Adminno").blur(function() {
			if ($(this).val() == "") {
				//alert("用户名不能为空");
			}
		});
		//提示密码不能为空
		$("#Adminpwd").blur(function() {
			if ($(this).val() == "") {
				alert("密码不能为空");
			}
		});

	});

</script>
<!--验证码区的样式  -->
<style type="text/css">
#code2 {
	font-family: Arial;
	font-style: italic;
	font-weight: bold;
	border: 0;
	letter-spacing: 2px;
	color: blue;
}
</style>
</head>
<body>
<div id="header" class="wrap">
<div id="logo"><img src="${pageContext.request.contextPath}/images/logo.gif" /></div>
</div>
<div id="childNav">

	<div class="wrap">
		<ul class="clearfix">
		
		</ul>
	</div>
</div>

<div id="register" class="wrap">
	<div class="shadow">
		<em class="corner lb"></em>
		<em class="corner rt"></em>
		<div class="box">
			<h1 style="background:#1874CD">管理员登陆</h1>
			<form id="loginForm" >
				<table style="margin-left: 50px">
					<tr>
						<td class="field">用户名：</td>
						<td><input class="text" type="text"  id="Adminno"  /><span></span></td>
					</tr>
					<tr>
						<td class="field">登录密码：</td>
						<td><input class="text" type="password"   id="Adminpwd" /><span></span></td>
					</tr>
					<tr>
						<td class="field">验证码：</td>
						<td><input type="text" id="submitcode" style="width: 60px;margin-right: 10px;">
						<input  class="text" style="width: 60px;margin-right: 10px;background-color:#fc7e31"
									type="text"  name="code2" id="code2">
						</td>
					</tr>
					<tr>
						<td>
							<input type="hidden" name="user.status" value="2"/>
						</td>
						<td><label class="ui-green" style="margin-left: 50px"><input type="button" id="btnReg" value="立即登录" style="background:#1874CD"/></label>&nbsp;&nbsp;<font id="error"  color="red">${error }</font></td>
					</tr>
				</table>
				<a href="AdminLogin.jsp" style="margin-left: 200px">管理员登入</a>
				<a href="../student/login.jsp" style="margin-left: 100px">学生登入</a>
			</form>
		</div>
	</div>
	<div class="clear"></div>
</div>
<div id="footer">
	Copyright &copy; 2017 CHL All Rights Reserved.
</div>
</body>
</html>