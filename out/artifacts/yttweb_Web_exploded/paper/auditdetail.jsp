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
			<input id="paperid" name="paperid" value="" hidden="hidden">
			<hr>
			<div class="layui-form-item">
				<label class="layui-form-label">审核时间</label>
					<div class="layui-input-block">
						<input name="time" id="date" lay-verify="datetime|required" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input" type="text">
					</div>
				<br>
				<label class="layui-form-label">审核状态</label>
				<div class="layui-input-block">
					<select name="auditflag" id="auditflag" lay-filter="istrans" lay-verify="required">
							<option value="">请选择</option>
							<option value="未审核">未审核</option>
							<option value="审核通过">审核通过</option>
							<option value="未通过">未通过</option>

						</select>
				</div>
				<br>
				<label class="layui-form-label">审核意见</label>
				<div class="layui-input-block">
					<input name="views" id="views"  autocomplete="off" class="layui-input" type="text">
				</div>
			</div>

			<br>

			<div id="renderselect"></div>
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
			layui.use(['form', 'layer','laydate'], function() {

				var form = layui.form,
					laydate = layui.laydate,
					layer = layui.layer;
	
				$("#renderselect").click(function() {
					form.render("select");
				});
				
				//日期渲染,日期验证
				date = new Date();
				laydate.render({
					elem: '#date',
					max: 'date',
					min:0,
					istime: true,
					type: 'datetime',
					format:"yyyy-MM-dd HH:mm:ss"	
				});
				

				//监听提交
				form.on('submit(demo1)', function(data) {
					$.post("AuditDeal",
						JSON.stringify(data.field),
						function(res) {
							 if(res == "1") {
								layer.msg("审核成功", {
									icon: 6,
									time: 2000 //2秒关闭（如果不配置，默认是3秒）
								}, function() {
									var index = parent.layer.getFrameIndex(window.name);
									parent.layer.close(index);
								});
							} else {
								layer.msg("审核失败", {
									icon: 2,
									time: 2000 //2秒关闭（如果不配置，默认是3秒）
								});
							}
						});

					return false;
				});

				$("#cancle").click(function() {
					layer.confirm('是否取消审核', {
						icon: 3,
						title: '审核提示'
					}, function() {

						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
					});
				});

		
			});
		</script>

	</body>

</html>