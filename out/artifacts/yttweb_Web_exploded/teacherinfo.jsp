<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>

	<head>
		<base href="<%=basePath%>">

		<link rel="stylesheet" href="./layui/css/layui.css" media="all">
	</head>

	<body>
		<span hidden="hidden" id='tid'><%=request.getSession().getAttribute("id") %></span>
		<div style="text-align: center;">
			<div class="layui-inline">
				<br>
				<table id="demo" lay-filter="demo" class="layui-table">
					  <colgroup>
    				<col width="150">
    				<col width="200">
    				<col width="150">
    				<col width="200">
  					</colgroup>
  					<tbody>
					<tr>
						<td>姓名</td>
						<td id="name"></td>
						<td>职称</td>
						<td id="title"></td>
						
					</tr>
					<tr>
						<td>出生时间</td>
						<td id="birthday"></td>
						<td>教师工号</td>
						<td id="empnum"></td>
						
					</tr>
					<tr>
						<td>性别</td>
						<td id="sex"></td>
						<td>电话号码</td>
						<td id="tele"></td>
						
					</tr>
					<tr>
						<td>专业</td>
						<td id="major" colspan="3"></td>
						
						
					</tr>
					</tbody>
				
				</table>
			</div>
		</div>

		<script src="./layui/layui.js" charset="utf-8"></script>

		<script src="./jquery/jquery-3.2.1.min.js"></script>
	
		<script>
			layui.use(['layer', 'form', 'table'], function() {
				var form = layui.form;
				var table = layui.table;
				var layer = layui.layer;
				//alert($("#tid").text());
				$.get('TeacherInfo',
				  {"tid":$("#tid").text()},
				  function(res){
				  		//alert(res.data[0].empnum);
				  		$("#name").text(res.data[0].name);
				  		$("#title").text(res.data[0].titlename);
				  		$("#birthday").text(res.data[0].birthday);
				  		$("#sex").text(res.data[0].sex);
				  		$("#empnum").text(res.data[0].empnum);
				  		$("#major").text(res.data[0].majorname);
				  		$("#tele").text(res.data[0].telephone);
				  
				  }
				
				
				
				);
				
				
				
				
				


			});
		</script>
	</body>

</html>