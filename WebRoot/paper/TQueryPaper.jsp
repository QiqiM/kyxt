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
				<label class="layui-form-label">学科门类</label>
				<div class="layui-input-inline">
					<select name="subtypeid" id="subtypeid" lay-filter="subtypeid" lay-verify="required">
						<option value="">请选择学科门类</option>

					</select>
				</div>
				<label class="layui-form-label">一级学科</label>
				<div class="layui-input-inline">
					<select name="firstsubid" id="firstsubid" lay-filter="firstsubid" lay-verify="required">
						<option value="">请先选择学科门类</option>
					</select>
				</div>
				<label class="layui-form-label">刊物类型</label>
				<div class="layui-input-inline">
					<select name="pubtypeid" id="pubtypeid" lay-filter="pubtypeid" lay-verify="required">
						<option value="">请选择刊物类型</option>

					</select>
				</div>

			</div>
				
			<div class="layui-form-item">
				<label class="layui-form-label">项目来源</label>
				<div class="layui-input-inline">
					<select name="prosourceid" id="prosourceid" lay-filter="prosourceid">
						<option value="">请选择项目来源</option>

					</select>
				</div>
				<label class="layui-form-label">发表范围</label>
				<div class="layui-input-inline">
					<select name="pubarea" id="pubarea" lay-filter="pubarea">
						<option value="">请选择</option>
						<option value="国外学术期刊">国外学术期刊</option>
						<option value="国内外公开发行">国内外公开发行</option>
						<option value="国内公开发行">国内公开发行</option>
						<option value="港澳台刊物">港澳台刊物</option>
					</select>
				</div>
				<label class="layui-form-label">刊物/论文集</label>
				<div class="layui-input-inline">
					<select name="journalid" id="journalid" lay-filter="journalid" lay-verify="required">
						<option value="">请先选择刊物类型</option>

					</select>
				</div>			
			</div>		
				<div class="layui-form-item">
				<label class="layui-form-label">期刊版面</label>
				<div class="layui-input-inline">
					<select name="layout" id="layout" lay-filter="layout">
						<option value="">请选择</option>
						<option value="正刊">正刊</option>
						<option value="年刊">年刊</option>
						<option value="增刊">增刊</option>
						<option value="专刊">专刊</option>
					</select>
				</div>
				<label class="layui-form-label">审核状态</label>
				<div class="layui-input-inline">
					<select name="auditflag" id="auditflag" lay-filter="istrans">
						<option value="">请选择</option>
						<option value="未审核">未审核</option>
						<option value="审核通过">审核通过</option>
						<option value="未通过">未通过</option>

					</select>
				</div>
				<div class="layui-input-inline" style="width: 250px ">
					<button type="button" class="layui-btn " id="demo1"><i class="layui-icon" style="font-size:15px;">&#xe615; 查询  </i></button>
					<button type="button" class="layui-btn layui-btn-danger" id="demo2"><i class="layui-icon" style="font-size:15px;">&#xe640; 批量删除</i></button>

				</div>
				<div class="layui-input-inline">
					<button type="reset" class="layui-btn layui-btn" id="reset"><i class="layui-icon" style="font-size:15px;">&#x1002;重置</i></button>
				</div>
			</div>
		</form>

		<table id="demo" lay-filter="demo"></table>

		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
		</script>
		
		<script type="text/html" id="titleTpl">
  			<a href="teacherAdd.jsp" class="layui-table-link" target="content-show">{{ d.title }}</a>
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
					url: 'PaperQueryT' //数据接口
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
								minWidth: 150
							}
						]
					]
				});

				$("#demo1").click(function() {   // 点击事件执行查询操作					
					tableIns.reload({
						where: {
							title: $("#title").val(),
							pubtime: $("#date").val(),
							firstauthor: $("#firstauthor").val(),
							subtypeid: $("#subtypeid").val(),
							firstsubid: $("#firstsubid").val(),
							pubtypeid:$("#pubtypeid").val(),
							prosourceid:$("#prosourceid").val(),
							pubarea:$("#pubarea").val(),
							journalid:$("#journalid").val(),
							layout:$("#layout").val(),
							auditflag:$("#auditflag").val()	
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
	
						layer.open({
							type: 2,
							title: '修改教师信息',
							shade: 0,
							area: ['700', '600'],
							maxmin: true, //最大化，最小化
							//skin: 'layui-layer-rim', //边框
							shift: 1,
							content: 'paper/paperEdit.jsp',
							success: function(layero, index) {
								var body = layer.getChildFrame('body', index); // 获取子窗口body，操作子窗口，巧妙的地方在这里哦		
								body.contents().find("#id").val(data.paperid);				
								body.contents().find("#title").val(data.title);
								body.contents().find("#firstauthor").val(data.firstauthor);
								body.contents().find("#date").val(data.pubtime);
								
								 function a()
                				{
                					body.contents().find("#subtypeid").val(data.subtypeid);
                					body.contents().find("#pubtypeid").val(data.pubtypeid);
               						body.contents().find("#firstsubid").val(data.firstsubid);
									body.contents().find("#prosourceid").val(data.prosourceid);
									body.contents().find("#pubarea").val(data.pubarea);
									body.contents().find("#journalid").val(data.journalid);
									body.contents().find("#layout").val(data.layout);
									body.contents().find("#istrans").val(data.istrans);
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
										firstsubid: $("#firstsubid").val(),
										pubtypeid:$("#pubtypeid").val(),
										prosourceid:$("#prosourceid").val(),
										pubarea:$("#pubarea").val(),
										journalid:$("#journalid").val(),
										layout:$("#layout").val(),
										auditflag:$("#auditflag").val()	
										
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
				
				
				//监听学科门类级联下拉框
				form.on('select(subtypeid)', function(data) {
					if(data.value == "") {} else {
						$("#firstsubid").find("option").remove();
						$("#firstsubid").append("<option value=''>请选择一级学科</option>");

						//异步加载一级学科下拉框
						$.get("FirstSub", {
								"subtypeid": data.value,
								"methodname": "lode",

							},
							function(data) {
								var i;
								for(i = 0; i < data.item.length; i++) {
									$("#firstsubid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
								}
								form.render();
							});
					}
				});

				//监听期刊/论文集类型
				form.on('select(pubtypeid)', function(data) {
					if(data.value == "") {} else {
						$("#journalid").find("option").remove();
						$("#journalid").append("<option value=''>请选择期刊/论文集</option>");

						//异步加载期刊下拉框
						$.get("Journal", {
								"pubpartid": data.value,
								"methodname": "lode"
							},
							function(data) {
								var i;
								for(i = 0; i < data.item.length; i++) {
									$("#journalid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
								}
								form.render();
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

				//异步加载期刊等级分类下拉框
				$.get("PubPart", {
						"methodname": "lode"
					},
					function(data) {
						var i;
						for(i = 0; i < data.item.length; i++) {
							$("#pubtypeid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
						}
						form.render();
					});

				//异步加载项目来源下拉框
				$.get("ProSource", {
						"methodname": "lode"
					},
					function(data) {
						var i;
						for(i = 0; i < data.item.length; i++) {
							$("#prosourceid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
						}
						form.render();
					});
				

				//reset按钮重置级联下拉框状态
				$("#reset").click(function() {
					$("#firstsubid").find("option").remove();
					$("#firstsubid").append("<option value=''>请先选择学科门类</option>");
					$("#journalid").find("option").remove();
					$("#journalid").append("<option value=''>请先选择期刊分类</option>");
				});
			});
		</script>
	</body>

</html>