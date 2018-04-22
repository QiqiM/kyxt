<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<title>电信学院科研管理系统</title>
		<link rel="stylesheet" href="layui/css/layui.css">
		<link rel="stylesheet" href="css/login.css">

	</head>

	<body>
		<!-- 你的HTML代码 -->
		<div class="qiqiu1 qiqiu">
			<img src="images/login/q2.png" />
			<div class="text">love</div>
		</div>
		<div class="qiqiu2 qiqiu">
			<img src="images/login/q3.png" />
			<div class="text">love</div>
		</div>
		<div class="qiqiu3 qiqiu">
			<img src="images/login/q4.png" />
			<div class="text">love</div>
		</div>
		<div class="qiqiu4 qiqiu">
			<img src="images/login/q5.png" />
			<div class="text">love</div>
		</div>
		<div class="qiqiu5 qiqiu">
			<img src="images/login/q6.png" />
			<div class="text">love</div>
		</div>
		<div class="login">
			<h1>Login</h1>
			<form class="layui-form">
				<div class="layui-form-item">
					<input class="layui-input" name="username" placeholder="用户名" lay-verify="required" type="text" autocomplete="off">
				</div>
				<div class="layui-form-item">
					<input class="layui-input" name="password" placeholder="密码" lay-verify="required" type="password" autocomplete="off">
				</div>
				<div class="layui-form-item">
					<select name="access" id="access" lay-verify="required">
						<option value="1">管理员</option>
						<option value="2">教师</option>
					</select>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block" style="text-align:center; width:100%;height:100%;margin:0px; ">
						<button class="layui-btn" lay-submit="" lay-filter="login">登录</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>

			</form>
		</div>

	</body>

	<script src="jquery/jquery-3.2.1.min.js"></script>
	<script src="layui/layui.js" media="all"></script>

	<script>
		//一般直接写在一个js文件中
		//Demo
		layui.use(['form', 'layer'], function() {
			var form = layui.form;
			var layer = layui.layer;

			//监听提交
			form.on('submit(login)', function(data) {

				$.ajax({
					type: "POST",
					url: "LoginServlet",
					data: JSON.stringify(data.field),
					dataType: "json",
					success: function(data) {
						if(data.success == "true") {
							if(data.msg == 1) {
								window.location.href = "adminMain.jsp";
							} else if(data.msg == 2) {
								window.location.href = "main.jsp";
							}
						} else {
							layer.alert(data.msg, {
								title: 'Error'
							});
						}
					},
					error: function(jqXHR) {
						layer.alert("发生错误：" + jqXHR.status, {
							title: 'Error'
						});
					}
				});
				return false;
			});
		});
	</script>
	</body>

</html>