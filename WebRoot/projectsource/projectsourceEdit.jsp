<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">

		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link rel="stylesheet" href="./layui/css/layui.css" media="all">

	</head>

	<body>

		<form class="layui-form layui-form-pane">
			<input id="oldid" name="oldid" value="" hidden="hidden">
			<hr>
			<div class="layui-form-item">
				<label class="layui-form-label">来源编号</label>
				<div class="layui-input-block">
					<input name="id" id="id" lay-verify="id|requerid" autocomplete="off" class="layui-input" type="text">
				</div>
				<br>
				<label class="layui-form-label">项目名称</label>
				<div class="layui-input-block">
					<input name="sourcename" id="sourcename" lay-verify="required" autocomplete="off" class="layui-input" type="text">
				</div>
			</div>

			<br>

			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
					<button type="button" class="layui-btn" id="cancle">取消</button>
				</div>
			</div>

		</form>

		<script src="./jquery/jquery-3.2.1.min.js"></script>
		<script src="./layui/layui.js" charset="utf-8"></script>

		<script>
			layui.use(['form', 'layer'], function() {

				var form = layui.form,
					layer = layui.layer;

			
				form.verify({
					id: function(value, item) { //value：表单的值、item：表单的DOM对象
						if(!/^\d{4}$/.test(value)) {
							return '请输入4位数字';
						}

					}

				});
				               //监听提交
        form.on('submit(demo1)', function(data){
          	$.post("SourceEdit",
          		JSON.stringify(data.field),
          		function(data){
          			if(data == "1")
          			{
          				layer.msg("学科门类编号已存在", {
									icon: 2,
									time: 2000 //2秒关闭（如果不配置，默认是3秒）
								});
          			}else if(data == "2"){
          				layer.msg("修改成功", {
									icon: 6,
									time: 2000 //2秒关闭（如果不配置，默认是3秒）
								}, function() {
									var index = parent.layer.getFrameIndex(window.name);
									parent.layer.close(index);
								});
          			}else{
          				layer.msg("修改失败", {
									icon: 2,
									time: 2000 //2秒关闭（如果不配置，默认是3秒）
								});
          			}
          		});
          	
          	     
            
          return false;
        });

				$("#cancle").click(function() {
					layer.confirm('是否取消添加', {
						icon: 3,
						title: '添加提示'
					}, function() {

						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
					});
				});

			});
		</script>

	</body>

</html>