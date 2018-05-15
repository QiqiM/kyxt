<%@ page language="java"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>

	<head>
		<base href="<%=basePath%>">
		<title>查询论文信息</title>
		<link rel="stylesheet" href="layui/css/layui.css" media="all">
	</head>

	<body>
		<form class="layui-form layui-form-pane">
			<div class="layui-form-item">
				<div class="layui-inline">
				    <br>
					<label class="layui-form-label">论文题目</label>
					<div class="layui-input-inline">
						<input name="title" id="title" autocomplete="off" class="layui-input" type="text">
					</div>
					<label class="layui-form-label">发表日期</label>
					<div class="layui-input-inline">
						<input name="time" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input" type="text">
					</div>
					<label class="layui-form-label">第一作者</label>
					<div class="layui-input-inline">
						<input name="firstauthor" id="firstauthor" autocomplete="off" class="layui-input" type="text">
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
				    <label class="layui-form-label">审核状态</label>
					<div class="layui-input-inline">
						<select name="auditflag" id="auditflag" lay-filter="istrans">
							<option value="">请选择</option>
							<option value="未审核">未审核</option>
							<option value="审核通过">审核通过</option>
							<option value="未通过">未通过</option>

						</select>
					</div>
					<label class="layui-form-label">学科门类</label>
					<div class="layui-input-inline">
						<select name="subtypeid" id="subtypeid" lay-filter="subtypeid" lay-verify="required">
							<option value="">请选择学科门类</option>

						</select>
					</div>
					<label class="layui-form-label">教师工号</label>
					<div class="layui-input-inline">
						<input name="teacherid" id="teacherid" autocomplete="off" class="layui-input" type="text">
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
				
				<div class="layui-input-inline" style="width: 250px ">
					<button type="button" class="layui-btn " id="demo1"><i class="layui-icon" style="font-size:15px;">&#xe615; 查询  </i></button>
					<button type="reset" class="layui-btn layui-btn" id="reset"><i class="layui-icon" style="font-size:15px;">&#x1002;重置</i></button>

				</div>
			</div>
		</form>

		<table id="demo" lay-filter="demo"></table>

		<script type="text/html" id="barDemo">
			{{# if(d.auditflag != "审核通过"){ }}
				<a class="layui-btn layui-btn-xs" lay-event="edit">审核</a>
				
			{{# }  }}
		</script>
		
		<script type="text/html" id="titleTpl">
  			<a href="paper/paperinfo.jsp?paperid={{ d.paperid }}" class="layui-table-link" target="content-show">{{ d.title }}</a>
		</script>
		<script type="text/html" id="auditTpl">
  			{{#  if(d.auditflag === '未审核'){ }}
    		<span style="color: #E9C342;">{{ d.auditflag }}</span>
 			 {{#  } else if(d.auditflag === '审核通过'){ }}
    		<span style="color: #00EC00;">{{ d.auditflag }}</span>
			 {{#  } else{ }}
			<span style="color: #E7262C;">{{ d.auditflag }}</span>
  			{{#  } }}
		</script>

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
					range: true
				});
			
				
					
				//自定义验证规则
        	form.verify({
        
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
					url: 'AdminAudit' //数据接口
						,
					page: true
						//开启分页
						,
					cols: [
						[ //表头
							 {
								type: 'numbers',
								title: '序号'
							},
							
							 {
								field: 'title',
								title: '论文题目',
								templet: '#titleTpl'
							
							},
							{
								field: 'majorname',
								title: '所属专业',
		
							}, 
							{
								field: 'firstauthor',
								title: '第一作者',
		
							}, {
								field: 'teacherid',
								title: '教师工号',
							
							},
							
							{
								field: 'pubtime',
								title: '发表时间',
							}, {
								field: 'subpartname',
								title: '学科门类',
		
							},
							{
								field: 'firstsubname',
								title: '一级学科'
							}, {
								field: 'journalname',
								title: '发表刊物'
							}, {
								field: 'pubpartname',
								title: '刊物类型'
							}, {
								field: 'auditflag',
								title: '审核状态',
								sort:true,
								templet: '#auditTpl'
							}, {
								fixed: 'right',
								align: 'center',
								toolbar: '#barDemo',
								title: '操作',
								minWidth: 70
							}
						]
					]
				});

				$("#demo1").click(function() {   // 点击事件执行查询操作	
					//alert($("#majorid").find("option:selected").text());			
					tableIns.reload({
						where: {
							title: $("#title").val(),
							pubtime: $("#date").val(),
							firstauthor: $("#firstauthor").val(),
							subtypeid: $("#subtypeid").val(),
							teacherid:$("#teacherid").val(),
							majorname:$("#majorid").find("option:selected").text(),
							auditflag:$("#auditflag").val()	
						},
						page: {
							curr: 1 //重新从第 1 页开始
						}
					});				
				});
				
				table.on('tool(demo)',function(obj){
					var data = obj.data;  // 其中tool是代表toolbar事件，demo是这个table的lay-fliter,obj代表你所选的行
					
					if(obj.event === 'edit'){
							//弹出框编辑
	
						layer.open({
							type: 2,
							title: '审核论文',
							shade: 0,
							area: ['400', '300'],
							maxmin: true, //最大化，最小化
							//skin: 'layui-layer-rim', //边框
							shift: 1,
							content: 'paper/auditdetail.jsp',
							success: function(layero, index) {
								var body = layer.getChildFrame('body', index); // 获取子窗口body，操作子窗口，巧妙的地方在这里哦		
								body.contents().find("#paperid").val(data.paperid);				
								//alert(data.paperid);		
								 function a()
                				{				
									body.contents().find("#auditflag").val(data.auditflag);
									body.contents().find("#renderselect").click();
                				}
                				setTimeout(a,500);
                				
							},
							end: function() {
								tableIns.reload({
									where: {
										title: $("#title").val(),
										pubtime: $("#date").val(),
										firstauthor: $("#firstauthor").val(),
										subtypeid: $("#subtypeid").val(),
										teacherid:$("#teacherid").val(),
										majorname:$("#majorid").find("option:selected").text(),
										auditflag:$("#auditflag").val()	
										
									}
								})

							}
						});				
					}				
				});

	
				//异步加载学科分类下拉框
				$.get("SubPart", {
						"methodname": "lode"
					},
					function(data) {
						var i;
						for(i = 0; i < data.item.length; i++) {
							$("#subtypeid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
						}
						form.render();
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