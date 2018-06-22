<%--
  Created by IntelliJ IDEA.
  User: yutaotao
  Date: 2018/4/10
  Time: 20:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>

	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<title>layui</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link rel="stylesheet" href="layui/css/layui.css" media="all">

	</head>

	<body>
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px;">
			<legend>请输入论文信息</legend>
		</fieldset>

		<form class="layui-form" action="">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">论文题目</label>
					<div class="layui-input-inline">
						<input name="title" lay-verify="required" autocomplete="off" class="layui-input" type="text">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">发表日期</label>
					<div class="layui-input-inline">
						<input name="pubtime" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input" type="text">
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">第一作者</label>
					<div class="layui-input-inline">
						<input name="firstauthor" lay-verify="required" autocomplete="off" class="layui-input" type="text">
					</div>
					<div class="layui-form-mid layui-word-aux">若第一作者为研究生，请输入形如'张三(学)'的格式</div>
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
				
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">刊物类型</label>
				<div class="layui-input-inline">
					<select name="pubtypeid" id="pubtypeid" lay-filter="pubtypeid" lay-verify="required">
						<option value="">请选择刊物类型</option>

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
				<label class="layui-form-label">译文</label>
				<div class="layui-input-inline">
					<select name="istrans" id="istrans" lay-filter="istrans">
						<option value="">请选择</option>
						<option value="是">是</option>
						<option value="否">否</option>

					</select>
				</div>
			</div>
			<button type="button" class="layui-btn" id="upload1" style="margin-left: 38px;margin-bottom: 20px"><i class="layui-icon"></i>选择文件</button>
			<button type="button" class="layui-btn" id="loadAction" style="margin-left: 38px;margin-bottom: 20px">上传</button>
			<input type="hidden" id="fileurl" name="fileurl" value="" />
			<div class="layui-upload-list">
				<p id="demoText"></p>
			</div>

			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
					<button type="reset" class="layui-btn layui-btn-primary" id='reset'>重置</button>
				</div>
			</div>
		</form>

		<script src="./jquery/jquery-3.2.1.min.js"></script>
		<script src="./layui/layui.js" charset="utf-8"></script>
		<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
		<script>
			layui.use(['form', 'layedit', 'laydate', 'upload'], function() {
				var form = layui.form,
					layer = layui.layer,
					layedit = layui.layedit,
					laydate = layui.laydate,
					upload = layui.upload;

				//日期渲染,日期验证
				date = new Date();
				laydate.render({
					elem: '#date',
					max: 'date'
				});

				//上传文件
				var uploadInst = upload.render({
					elem: '#upload1' //绑定元素
						,
					url: 'PaperUpLoad' //上传接口
						,
					accept: 'file',
					bindAction: '#loadAction' //指向一个按钮触发上传
						,
					auto: false //选择文件后不自动上传
						,
					before: function(obj) {
						//预读本地文件示例，不支持ie8
						obj.preview(function(index, file, result) {
							// $('#demo1').attr('src', result); //图片链接（base64）
						});
					},
					done: function(res) {
						//如果上传失败
						if(res.code > 0) {
							return layer.msg('上传失败');
						}
						//上传成功
						layer.alert("上传成功  ----- " + res.src);
						document.getElementById("fileurl").value = res.src;

					},
					error: function() {
						//演示失败状态，并实现重传
						var demoText = $('#demoText');
						demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
						demoText.find('.demo-reload').on('click', function() {
							uploadInst.upload();
						});
					}
				});

				//自定义验证规则
				form.verify({
					//教师姓名验证
					name: function(value) {
						if(!(/^[\u4E00-\u9FA5\uf900-\ufa2d·s]{2,20}$/.test(value))) {
							return '请输入正确的中文名';
						}
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

				//reset按钮重置级联下拉框状态
				$("#reset").click(function() {
					$("#firstsubid").find("option").remove();
					$("#firstsubid").append("<option value=''>请先选择学科门类</option>");
					$("#journalid").find("option").remove();
					$("#journalid").append("<option value=''>请先选择期刊分类</option>");
				});

				//监听提交
				form.on('submit(demo1)', function(data) {
					
					$.post("PaperAdd",
						JSON.stringify(data.field),
						function(data) {
							if(data == "1"){
								layer.msg('添加成功', {icon: 6});
							}
							else{
								layer.msg('添加失败', {icon: 2});
							}

						});
						setTimeout(function () {
                           window.location.reload() ;
                        }, 1000);

					return false;
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

			});
		</script>

	</body>

</html>