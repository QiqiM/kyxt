<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<base href="<%=basePath%>">

		<title>Echarts</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link rel="stylesheet" href="./layui/css/layui.css" media="all">
		<script type="text/javascript" src="http://echarts.baidu.com/build/dist/echarts.js"></script>
		<script src="./jquery/jquery-3.2.1.min.js"></script>
		<script src="layui/layui.js" charset="utf-8"></script>

		
	</head>

	<body>
	<div id="a1">
		             	<select name="" id="select1">
		             		<option value="">--请选择--</option>
					      <option value="第一个">第一个</option>
					     <option value="第2个">第2个</option>
					     <option value="第3个">第3个</option>
					     <option value="第4个">第4个</option>
				         </select>
		             </div>
		          <div id="a2" >
		           </div>
		           <button id="aaa">显示</button>
 
  
    		
		
<script language="JavaScript">  
   $(function(){
			$("#select1").change(function(){
				setx($(this).val());
				$("#select1").find("option:selected").hide().fadeOut(1000);
			})
			function setx(data){
				var a="<span>"+data+"</span>";
				$("#a2").append(a);
			}
			
			
			
			
		})
   
   
</script> 
		

		
	</body>

</html>