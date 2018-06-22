<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  	<head>
    <base href="<%=basePath%>">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>教师界面</title>
	<link rel="stylesheet" href="css/init.css">
	<link rel="stylesheet" href="layui/css/layui.css">
  	</head>
 
  	<body>  	
  	<jsp:include page="top.jsp"/>
  	<div style="width:100%; height: 700px;background-color: #B0CFEB">
  		 <div class="layui-layout layui-layout-admin">
  			<div class="layui-header">
    			<div class="layui-logo">Admin后台</div>
    			<!-- 头部区域（可配合layui已有的水平导航） -->
    				<ul class="layui-nav layui-layout-left">
      					<li class="layui-nav-item"><a href="">教师管理</a></li>
      					<li class="layui-nav-item"><a href="">论文管理</a></li>
      					<li class="layui-nav-item"><a href="">用户</a></li>
      					</li>
    				</ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
           	余涛涛
        </a>
        <dl class="layui-nav-child">
          <dd><a href="">基本资料</a></dd>
          <dd><a href="">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="">退出</a></li>
    </ul>
  </div>
  
 
</div>

  
  	</div>

  	<jsp:include page="foot.jsp"/>
  	
 
 
  
  <script src="jquery/jquery-3.2.1.min.js"></script>
  <script src="layui/layui.js"></script>
  <script type="text/javascript">
  	layui.use('element', function(){
    var element = layui.element;
  
	});
  </script>
  
  	</body>
</html>
