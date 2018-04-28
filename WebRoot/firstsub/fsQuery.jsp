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
			<form class="layui-form layui-form-pane">
				<div class="layui-form-item">
					<hr>
					<div class="layui-inline">

						<label class="layui-form-label" style="width: 120px ">一级学科编号</label>
						<div class="layui-input-inline">
							<input id="id" name="id" autocomplete="off" class="layui-input" type="text">
						</div>

						<label class="layui-form-label">一级学科</label>
						<div class="layui-input-inline">
							<input id="firstsubname" name="firstsubname" autocomplete="off" class="layui-input" type="text">
						</div>		
					</div>
				</div>
				
				
				<div class="layui-form-item">
				   	<div class="layui-inline">
				   		<label class="layui-form-label">学科分类</label>
						<div class="layui-input-inline">
							<select name="partid" id="partid" autocomplete="off">
								<option value="" select="select"></option>
							</select>
						</div>
						<div class="layui-input-inline" style="width: 220px ">
							<button type="button" class="layui-btn" id="demo1"><i class="layui-icon" style="font-size:15px;">&#xe615; 查询  </i></button>
							<!--  <button type="button" class="layui-btn layui-btn-danger" id="demo2"><i class="layui-icon" style="font-size:15px;">&#xe640; 批量删除</i></button>-->
							<button type="button" class="layui-btn layui-btn" id="add"><i class="layui-icon" style="font-size:15px;">&#xe654;添加</i></button>
						</div>
				   	
				   	</div>
				 </div>
			</form>
		</div>
		<div style="text-align: center;">
			<div class="layui-inline">
				<table id="demo" lay-filter="demo"></table>
			</div>
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
					cellMinWidth: 20 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
						,
					even: true //开启隔行背景
						,
					width: 700,
					height: 500,
					url: 'FsQuery',
					page: true //开启分页
						,
					cols: [
						[ //表头

							 {
								type: 'numbers',
								title: '序号'
							}, {
								field: 'id',
								title: '一级学科编号',
								sort: true
							}, {
								field: 'name',
								title: '一级学科',
								minWidth: 150
							},{
								field: 'forname',
								title: '学科门类',
								minWidth: 150	
							},
							
							 {
								fixed: 'right',
								align: 'center',
								toolbar: '#barDemo',
								title: '操作',
								minWidth: 150
							}
						]
					]

				});

				//监听工具条
				table.on('tool(demo)', function(obj) {
					var data = obj.data;
					if(obj.event === 'del') {
						layer.confirm("确认要删除吗，删除后不能恢复", {
								title: "删除确认"
							},
							function(index) {
								layer.close(index);
								$.ajax({
									url: "MajorQuery",
									type: "POST",
									dataType: 'json',
									data: {
										"id": data.id,
										"methodname": "deletesingle"
									},
									success: function(data) {
										if(data.success == "true") {
											layer.msg('删除成功', {
												icon: 6,
												time: 1000 //2秒关闭（如果不配置，默认是3秒）
											}, function() {
												$("#demo1").click();
											});
										} else {
											layer.alert(data.msg);
										}
									}
								});
							});
					} else if(obj.event === 'edit') {
						var id;
						$.post("SubPart",
							{ "methodname":"findvalue",
							   "subpartname":data.forname
							},
							function(datas){
								id = datas.id;
							});
						layer.open({
							type: 2,
							title: '修改一级学科信息',
							shade: 0,
							fixed: false,
							area: ['400', 300],
							maxmin: true, //最大化，最小化
							content: 'firstsub/fsEdit.jsp',
							success: function(layero, index) {
									var body = layer.getChildFrame('body', index); //巧妙的地方在这里哦
									body.contents().find("#oldid").val(data.id);
									body.contents().find("#id").val(data.id);
									body.contents().find("#firstsubname").val(data.name);
									function d()
                					{               					
									body.contents().find("#partid").val(id);
               						body.contents().find("#renderselect").click();
                					}
                					setTimeout(d,500);
								},
							end: function() {
								tableIns.reload({
									where: {
										id: $("#id").val(),
										firstsubname: $("#firstsubname").val(),
										partid:$("#partid").val()
									}
								})

							}
						});
					}
				});
				
				
				//添加按钮
				$("#add").click(function(){
						layer.open({
							type: 2,
							title: '添加一级学科信息',
							shade: 0,
							fixed: false,
							area: ['450', 400],
							maxmin: true, //最大化，最小化
							content: 'firstsub/fsAdd.jsp',
							end: function() {
								tableIns.reload({
									where: {
										id: $("#id").val(),
										firstsubname: $("#firstsubname").val(),
										partid:$("#partid").val()
									}
								})
							}
						});
				
				
				
				});
				
				//查询按钮
				$("#demo1").click(function() { 
					tableIns.reload({
						where: {
							id: $("#id").val(),
							firstsubname: $("#firstsubname").val(),
							partid:$("#partid").val()
						},
						page: {
							curr: 1 //重新从第 1 页开始
						}
					});
				});
				
				//异步加载学科分类下拉框
				$.get("SubPart",
					{"methodname":"lode"},
					function(data) {
						var i;
						for(i = 0; i < data.item.length; i++) {
							$("#partid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
						}
						
						form.render();

					});
				
				

			});
		</script>
	</body>

</html>