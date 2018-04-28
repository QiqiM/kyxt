<%@ page language="java"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>

	<head>
		<base href="<%=basePath%>">
		<title>查询教师信息</title>
		<link rel="stylesheet" href="layui/css/layui.css" media="all">
	</head>

	<body>
		<form class="layui-form layui-form-pane">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">教师工号</label>
					<div class="layui-input-inline">
						<input id="empnum" name="empnum" autocomplete="off" lay-verify="empnum" class="layui-input" type="text">
					</div>
					<label class="layui-form-label">教师姓名</label>
					<div class="layui-input-inline">
						<input id="name" name="name" autocomplete="off" lay-verify="name" class="layui-input" type="text">
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">专业</label>
				<div class="layui-input-inline">
					<select name="majorid" id="majorid" autocomplete="off">
						<option value="" select="select"></option>
					</select>
				</div>

				<label class="layui-form-label">职称</label>
				<div class="layui-input-inline">
					<select name="titleid" id="titleid" autocomplete="off">
						<option value="" selected="selected"></option>
					</select>
				</div>
				<div class="layui-input-inline" style="width: 250px ">
					<button type="button" class="layui-btn layui-btn " id="demo1"><i class="layui-icon" style="font-size:15px;">&#xe615; 查询  </i></button>
					<button type="button" class="layui-btn layui-btn  layui-btn-danger" id="demo2"><i class="layui-icon" style="font-size:15px;">&#xe640; 批量删除</i></button>

				</div>
				<div class="layui-input-inline">
					<button type="reset" class="layui-btn layui-btn"><i class="layui-icon" style="font-size:15px;">&#x1002;重置</i></button>
				</div>

			</div>

		</form>

		<table id="demo" lay-filter="demo"></table>

		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
		</script>
		
		<script type="text/html" id="nameTpl">
  			<a href="teacherAdd.jsp" class="layui-table-link" target="content-show">{{ d.name }}</a>
		</script>
		<script type="text/html" id="sexTpl">
  			{{#  if(d.sex === '女'){ }}
    		<span style="color: #F581B1;">{{ d.sex }}</span>
 			 {{#  } else { }}
    		<span style="color: #00c0ff;">{{ d.sex }}</span>
  			{{#  } }}
		</script>

		<script src="layui/layui.js" charset="utf-8"></script>
		<script src="jquery/jquery-3.2.1.min.js"></script>
		<script>
			layui.use(['layer', 'form', 'table'], function() {
				var form = layui.form;
				var table = layui.table;
				var layer = layui.layer;
				
				
				//自定义验证规则
        	form.verify({
            //教师工号验证
            empnum: function(value){
                if(!(/^\d{0,6}$/.test(value))){
                	return '请输入1-6位由数字组成的教师工号';
                }
            },
            //教师姓名验证
            name: function(value){
            	if(!(/^[\u4E00-\u9FA5\uf900-\ufa2d·s]{0,20}$/.test(value))){
            		return '请输入正确的中文名';	
            	}
            }
        });
				
				//第一个表格实例
				var tableIns = table.render({
					elem: '#demo',
					skin: 'line' //行边框风格
						,
					cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
						,
					even: true //开启隔行背景
						,
					height: 500,
					url: 'QueryTeacher' //数据接口
						,
					page: true
						//开启分页
						,
					cols: [
						[ //表头
							{
								type: 'checkbox',
								title: '复选框'
							}, {
								type: 'numbers',
								title: '序号'
							},
							{
								field: 'empnum',
								title: '教师工号',
								sort: true
							}, {
								field: 'name',
								title: '教师姓名',
								templet: '#nameTpl'
							}, {
								field: 'sex',
								title: '性别',
								templet: '#sexTpl'
							},
							{
								field: 'majorname',
								title: '专业'
							}, {
								field: 'titlename',
								title: '职称'
							}, {
								field: 'birthday',
								title: '出生日期'
							}, {
								field: 'telephone',
								title: '电话号码'
							}, {
								fixed: 'right',
								align: 'center',
								toolbar: '#barDemo',
								title: '操作',
								minWidth: 150
							}
						]
					]
				});

				$("#demo1").click(function() {   // 点击事件执行查询操作

					tableIns.reload({
						where: {
							empnum: $("#empnum").val(),
							name: $("#name").val(),
							majorid: $("#majorid").val(),
							titleid: $("#titleid").val()
						},
						page: {
							curr: 1 //重新从第 1 页开始
						}
					});
				});
				
				table.on('tool(demo)',function(obj){
					var data = obj.data;  // 其中tool是代表toolbar事件，demo是这个table的lay-fliter,obj代表你所选的行
					
					if(obj.event === 'del'){
						layer.confirm("确认要删除吗，删除后不能恢复", {
								title: "删除确认"
							},
							function(index) {
								layer.close(index);  //关闭当前确认框
								$.ajax({
									url: "QueryTeacher",
									type: "post",
									dataType: 'json',
									data: {
										"empnum": data.empnum,
										"methodname": "deletesingle"
									},
									success: function(data) {
										if(data=="1") {

											layer.msg('删除成功', {
												icon: 6,
												time: 1000 //2秒关闭（如果不配置，默认是3秒）
											}, function() {
												$("#demo1").click();   //调用重载函数
											});
										} else {
											layer.alert("删除失败！");
										}
									}
								});
							});
					}else if(obj.event === 'edit'){
							//弹出框编辑
						var majorid,titleid;
						$.post("TitleAndMajor",
							{ "methodname":"findvalue",
							   "majorname":data.majorname,
							   "titlename":data.titlename
							},
							function(data){
								majorid = data.majorid;
								titleid = data.titleid;
							});
								
							
						layer.open({
							type: 2,
							title: '修改教师信息',
							shade: 0,
							area: ['700', '600'],
							maxmin: true, //最大化，最小化
							skin: 'layui-layer-rim', //边框
							shift: 1,
							content: 'teacherEdit.jsp',
							success: function(layero, index) {
								var body = layer.getChildFrame('body', index); // 获取子窗口body，操作子窗口，巧妙的地方在这里哦							
								body.contents().find("#id").val(data.empnum);
								body.contents().find("#empnum").val(data.empnum);
								body.contents().find("#name").val(data.name);
								//body.contents().find("#sex").val(data.sex);
								
								body.contents().find("#telephone").val(data.telephone);
								body.contents().find("#date1").val(data.birthday);
								
								 function d()
                				{
                					body.contents().find("input:radio[value='"+data.sex+"']").attr('checked','true'); //设置radio的值
                					body.contents().find("#majorid").val(majorid);
									body.contents().find("#titleid").val(titleid);
               						body.contents().find("#renderselect").click();
               
                				}
                				setTimeout(d,100);
							},
							end: function() {
								tableIns.reload({
									where: {
										empnum: $("#empnum").val(),
										name: $("#name").val(),
										majorid: $("#majorid").val(),
										titleid: $("#titleid").val(),
										
									}
								})

							}
						});				
					}				
				});
				
				
				//多行删除
				$("#demo2").click(function(){
					var checkStatus = table.checkStatus('demo');  
					var data = checkStatus.data;
					var length = data.length;
					if(length === 0) {
						layer.alert('请至少选择一条数据删除', {
							title: '删除提示',
							icon: 2
						}); //这时如果你也还想执行yes回调，可以放在第三个参数中
					} else {
						layer.confirm('是否批量删除' + length + '条数据,删除后不可恢复', {
							icon: 3,
							title: '删除提示'
						}, function(index) {

							var empnums = "";
							for(var i = 0; i < length; i++) {
								var empnum = data[i].empnum;
								empnums += empnum + ";";    //拼接选中的教师工号字符串
							}
							$.ajax({
								url: 'QueryTeacher',
								type: 'POST',
								dataType: 'json',
								data: {
									"empnums":empnums ,
									"methodname": "deletemulti"
								},
								success: function(data) {
									if(data=="1") {
										layer.msg("删除成功", {
											icon: 6,
											time: 1000 //1秒关闭（如果不配置，默认是3秒）
										}, function() {
											$("#demo1").click();

										});
									} else {
										layer.alert("删除失败！");
									}
								}
							});
							layer.close(index);  //关闭确认框
						});

					}
				});
				
				
				

				//异步获取教师职称和专业的下拉框
				$.get("TitleAndMajor",
					{"methodname":"tmlode"},
					function(data) {
						var i;
						for(i = 0; i < data.major.length; i++) {
							$("#majorid").append("<option value='" + data.major[i].id + "'>" + data.major[i].majorName + "</option>");
						}
						//form.render('select','aihao');
						for(i = 0; i < data.title.length; i++) {
							//alert(data.title[i].id);
							$("#titleid").append("<option value='" + data.title[i].id + "'>" + data.title[i].titleName + "</option>");
							//console.log(data.title[i].id);
						}
						form.render();

					});
			});
		</script>
	</body>

</html>