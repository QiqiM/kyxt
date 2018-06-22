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
		<link rel="stylesheet" href="css/changepwd.css">

	</head>

	<body>
		<!-- 你的HTML代码 -->
		
		<div class="login">
			<h1>修改密码</h1>
			<span hidden="hidden" id='account1'><%=request.getSession().getAttribute("id")%></span>
			<form class="layui-form">
				<div class="layui-form-item">
					<input class="layui-input" id="account"  name="account" placeholder="用户名" lay-verify="required"  readonly="readonly" type="text" autocomplete="off">
				</div>
				<div class="layui-form-item">
					<input class="layui-input" id="oldpwd" name="oldpwd" placeholder="旧密码" lay-verify="required" type="password" autocomplete="off">
				</div>
				<div class="layui-form-item">
					<input class="layui-input" id="pwd1" name="pwd1" placeholder="新密码(请输入6-10位的数字字母组合)" lay-verify="required|pwd" type="password" autocomplete="off">
				</div>
				<div class="layui-form-item">
					<input class="layui-input" id="pwd2" name="pwd2" placeholder="确认密码(请输入6-10位的数字字母组合)" lay-verify="required|pwd" type="password" autocomplete="off">
				</div>
				
				<div class="layui-form-item">
					<div class="layui-input-block" style="text-align:center; width:100%;height:100%;margin:0px; ">
						<button class="layui-btn-normal layui-btn" lay-submit="" lay-filter="login">修改</button>
						<button  id='reset' class="layui-btn layui-btn-primary">重置</button>
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
			
			//表单验证
		$("#account").val($("#account1").text());
		//alert($("#account1").text());
		
		//重置按钮操作
		$("#reset").click(function(){	
			$("#account").val($("#account1").text());
			$("#oldpwd").val("");
			$("#pwd1").val("");
			$("#pwd2").val("");
		})	
		
		form.verify({  
    
        	pwd :function(value){
        	 	if(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,10}$/.test(value)){
        	 
        	 	}else{
        	 		return '请输入6-10位的数字字母组合';
        	 	}
        }

  		});
			
			//监听提交
			form.on('submit(login)', function(data) {

				$.ajax({
					type: "POST",
					url: "ChangePwd",
					data: JSON.stringify(data.field),
					dataType: "json",
					success: function(data) {
						if(data == "1") {
							layer.msg("旧密码错误", {icon: 4,time: 2000 });
						} else if(data == '2'  ){
							layer.msg("密码修改成功", {icon: 6,time: 2000 });	
							setInterval(function(){$("#reset").click()},2000);
						}else if(data == '3'  ){
							layer.msg("密码修改失败", {icon: 2,time: 2000 });	
						}else if(data == '4'  ){
							layer.msg("两次输入密码不一致", {icon: 5,time: 2000 });	
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