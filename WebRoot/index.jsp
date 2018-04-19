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
  	<title>电信学院科研管理系统</title>
  	<link rel="stylesheet" href="layui/css/layui.css">
  	<link rel="stylesheet" href="css/index.css">
  	<link rel="stylesheet" href="css/init.css">
</head>
<body>
<!-- 你的HTML代码 -->

<div id="bg"> 
	<div id="syname">
		<h1><font face="arial" size="29px">电信学院科研管理系统</font></h1>
	</div>
	<div id="layout">
		<div id="inner-box">
			<form class="layui-form box"  method="post" action="LoginServlet">
  			<div class="layui-form-item">
    			<label class="layui-form-label fcolor">账号</label>
    			<div class="layui-input-block">
      			<input type="text" name="username" id="username" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			<div class="layui-form-item">
    			<label class="layui-form-label fcolor">密码</label>
    			<div class="layui-input-block">
      				<input type="password" name="password" id="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			<div class="layui-form-item">
    			<label class="layui-form-label fcolor" >身份</label>
    			<div class="layui-input-block">
      			<select name="access" id="access"  lay-verify="required">
        			<option value="1">管理员</option>
        			<option value="2">教师</option>
      			</select>
    			</div>
  			</div>
  			<div class="layui-form-item">
    			<div class="layui-input-block">
    				<p id="error"></p>
    				<label id="error1"></label>
      				<button class="layui-btn" lay-submit="" lay-filter="login">登录</button>
      				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
    			</div>
  			</div>
		</form>	
		</div>

	</div>
</div>


<!-- 导入layui和jquery的js文件 ,js文件放在html代码后引入，优化性能-->
<script src="jquery/jquery-3.2.1.min.js"></script>
<script src="layui/layui.js"  media="all"></script>

<script>
//一般直接写在一个js文件中
//Demo
layui.use(['form','layer'], function(){
  	var form = layui.form;
  	var	layer = layui.layer;
  	
  	//监听提交
 	form.on('submit(login)',function(data){	
 		
 			$.ajax({type:"POST",
 				url:"LoginServlet",
 				data:JSON.stringify(data.field),
 				dataType:"json",
 				success:function(data){
 					if(data.success=="true")
 					{
 						if(data.msg==1){
 							window.location.href = "adminMain.jsp";
 						}else if(data.msg==2){
 							window.location.href = "main.jsp";
 						}	
 					}else{
 						layer.alert(data.msg, {title: 'Error'});
 					}
 				},
 				error:function(jqXHR){
 					layer.alert("发生错误：" + jqXHR.status, {title: 'Error'});
 				}			
 			});	
 		return false;
  	});
});
</script> 
</body>
</html>
