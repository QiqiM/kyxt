<%@ page language="java"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>

	<head>
		<base href="<%=basePath%>">
		<title>论文打分信息</title>
		<link rel="stylesheet" href="layui/css/layui.css" media="all">
	</head>

	<body>
		<form class="layui-form layui-form-pane">
			<div class="layui-form-item">
				<div class="layui-inline">
				    <br>
					
					<label class="layui-form-label">发表日期</label>
					<div class="layui-input-inline">
						<input name="time" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input" type="text">
					</div>
					<label class="layui-form-label">专业</label>
					<div class="layui-input-inline">
					<select name="majorid" id="majorid" autocomplete="off">
						<option value="" select="select"></option>
					</select>
					</div>
					
				<div class="layui-input-inline" style="width: 250px ">
					<button type="button" class="layui-btn " id="demo1"><i class="layui-icon" style="font-size:15px;">&#xe615; 查询  </i></button>
					<button type="reset" class="layui-btn layui-btn" id="reset"><i class="layui-icon" style="font-size:15px;">&#x1002;重置</i></button>

				</div>
					
				
				</div>
			</div>
		</form>

		<table id="demo" lay-filter="demo"></table>

		

		<script src="layui/layui.js" charset="utf-8"></script>
		<script src="jquery/jquery-3.2.1.min.js"></script>
		<script>
			layui.use(['layer', 'form','laydate', 'table'], function() {
				var form = layui.form;
				var table = layui.table;
				var layer = layui.layer;
				
				var laydate = layui.laydate;
			//日期渲染,日期验证
				date = new Date();
				laydate.render({
					elem: '#date',
					max: 'date',
					type: 'year',
					range: true
				});
			

				
				//第一个表格实例
				var tableIns = table.render({
					elem: '#demo',
					skin: 'line' //行边框风格
						,
					even: true //开启隔行背景
						,
					height: 500,
					url: 'CountScore' //数据接口
						,
					page: true
						//开启分页
						,
					cols: [
						[ //表头
							 {
								type: 'numbers',
								title: '序号'
							},{
								field: 'teacherid',
								title: '职工号'	
							
							},
							
							 {
								field: 'name',
								title: '教师姓名'	
							
							},
							{
								field: 'majorname',
								title: '专业'
		
							}, 
							{
								field: 'pubtime',
								title: '发表时间'
		
							}, {
								field: 'topnum',
								title: '国内特级'
							}, {
								field: 'topgrade',
								title: '记分',
								width: 90
		
							},
							{
								field: 'onenum',
								title: '国内一级'
							}, {
								field: 'onegrade',
								width: 90,
								title: '记分'
							}, {
								field: 'twonum',
								title: '国内二级'
							}, {
								field: 'twograde',
								width: 90,
								title: '记分'
								
							}, {
								field: 'lastgrade',
								width: 90,
								title: '总分',
								sort:true
								
							}
						]
					]
				});


				$("#demo1").click(function() {   // 点击事件执行查询操作					
					tableIns.reload({
						where: {
							major: $("#majorid").val(),
							pubtime: $("#date").val()
							
						},
						page: {
							curr: 1 //重新从第 1 页开始
						}
					});				
				});
				
				//异步获取教师职称和专业的下拉框
				$.get("TitleAndMajor",
					{"methodname":"tmlode"},
					function(data) {
						var i;
						for(i = 0; i < data.major.length; i++) {
							$("#majorid").append("<option value='" + data.major[i].id + "'>" + data.major[i].majorName + "</option>");
						}
						
						form.render();

					});
				
			
			});
		</script>
	</body>

</html>