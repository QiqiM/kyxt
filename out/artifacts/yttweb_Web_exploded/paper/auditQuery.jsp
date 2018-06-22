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
	<div style="text-align: center;">
		<span hidden="hidden" id='paperid'></span>
			<div class="layui-inline">
				<table id="demo" lay-filter="demo"></table>
			</div>
		</div>
		<div style="text-align: center;">
			
			<button type="button" class="layui-btn layui-btn-normal" id="goback">返回</button>
					
		</div>
		

		<script src="./layui/layui.js" charset="utf-8"></script>

		<script src="./jquery/jquery-3.2.1.min.js"></script>
		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
		</script>
		<script>
			layui.use(['layer', 'form', 'table'], function() {
				var form = layui.form;
				var table = layui.table;
				var layer = layui.layer;

				//第一个实例
				var tableIns = table.render({
					elem: '#demo',
					method: 'POST',
					skin: 'row' //行边框风格
					
						,
					even: true //开启隔行背景
						,
					width: 940,
					height: 250,
					url: 'AuditQuery',
					page: false //开启分页
						,
						where:{
							'id':$("#paperid").val()
						},
					cols: [
						[ //表头

							 {
								type: 'numbers',
								title: '序号'
							}, {
								field: 'time',
								title: '审核时间',
								sort: true,
								minWidth: 180
							}, {
								field: 'auditor',
								title: '审核人'
								
							},{
								field: 'auditorid',
								title: '审核人编号'

							},{
								field: 'status',
								title: '审核状态'

							},{
								field: 'views',
								title: '审核意见'
							}
							
						]
					]

				});
				
				 $("#goback").click(function() {
					var index = parent.layer.getFrameIndex(window.name);
					parent.layer.close(index);

				});
				
	
		});
				
				

				
		</script>
	</body>

</html>