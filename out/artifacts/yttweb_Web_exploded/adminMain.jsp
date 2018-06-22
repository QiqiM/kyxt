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
    <title>管理员界面</title>
	<link rel="stylesheet" href="css/init.css">
	<link rel="stylesheet" href="layui/css/layui.css">
  	</head>
 
  	<body>  	 
  	<jsp:include page="top.jsp"/>
  	<div style="width:100%; height: 750px;background-color: #B0CFEB">
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="200" height=750px valign="top" style="background-color:#393D49">
					<iframe height="100%" width="100%" border="0" frameborder="0" src="adminLeft.html"></iframe>
				</td>
				<td valign="top" height="750px" style="background-color:#FFFFFF">
					<iframe height="100%" id="content-show" name="content-show" width="100%" border="0" frameborder="0" src="adminshow.jsp"></iframe>
				</td>
			</tr>
		</table>

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
