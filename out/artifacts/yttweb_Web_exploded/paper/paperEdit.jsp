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
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>

<body>
<form class="layui-form layui-form-pane" method="post" action="teacherAdd">
	<input id="id" name="id" value="" hidden="hidden">
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
				<label class="layui-form-label">第一作者</label>
					<div class="layui-input-inline">
						<input name="firstauthor" id="firstauthor" autocomplete="off" class="layui-input" type="text">
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
			
			<div class="layui-form-item">
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
			
			
        
		<!--用来刷新下拉框，显示传过来的值-->
		<div id="renderselect"></div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">修改</button>
                <button type="button" class="layui-btn" id="cancle">取消</button>
            </div>
        </div>

</form>
<script src="jquery/jquery-3.2.1.min.js"></script>  
<script src="layui/layui.js" charset="utf-8"></script>

<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;
            
            $("#renderselect").click(function() {					
				form.render("select");
			}); 

        //日期
       	date=new Date();
        laydate.render({
            elem: '#date',
            max:'date'
        });

        //自定义验证规则
        form.verify({
          
            //教师姓名验证
            name: function(value){
            	if(!(/^[\u4E00-\u9FA5\uf900-\ufa2d·s]{2,20}$/.test(value))){
            		return '请输入正确的中文名';	
            	}
            }

        });

               //监听提交
        form.on('submit(demo1)', function(data){
          	$.post("PaperEdit",
          		JSON.stringify(data.field),
          		function(data){
          			if(data == "1")
          			{
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
					layer.confirm('是否取消修改', {
						icon: 3,
						title: '修改提示'
					}, function() {

						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);

					});
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
				
				
					$.get("FirstSub", {
								"subtypeid": 1,
								"methodname": "lode",

							},
							function(data) {
								var i;
								for(i = 0; i < data.item.length; i++) {
									$("#firstsubid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
								}
								form.render();
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
				
					$.get("Journal", {
								"pubpartid": 1,
								"methodname": "lode"
							},
							function(data) {
								var i;
								for(i = 0; i < data.item.length; i++) {
									$("#journalid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
								}
								form.render();
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


