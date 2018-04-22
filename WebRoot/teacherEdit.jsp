<%--
  Created by IntelliJ IDEA.
  User: yuyaoyao
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
	<input id="id" name="id" value="1" hidden="hidden">
	<div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label	">教师工号</label>
            <div class="layui-input-block">
                <input name="empnum" lay-verify="required" id="empnum"  placeholder="请输入" autocomplete="off" class="layui-input" type="text">
            </div>
        </div>
    </div>
    
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">教师姓名</label>
            <div class="layui-input-block">
                <input name="name" id="name" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input" type="text">
            </div>
        </div>
    </div>
    <!-- 
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">初始密码</label>
            <div class="layui-input-block">
                <input name="password" lay-verify="required" value="123456" readonly="readonly" placeholder="请输入" autocomplete="off" class="layui-input" type="text">
            </div>
        </div>
    </div>   
    -->


    <div class="layui-form-item" pane="">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input name="sex" value="男" title="男" checked="" type="radio">
            <input name="sex" value="女" title="女" type="radio">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">电话号码</label>
            <div class="layui-input-block">
                <input name="telephone" id="telephone"  lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input" type="text">
            </div>
        </div>
    </div>



    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">出生日期</label>
            <div class="layui-input-block">
                <input name="birthday"  id="date1" autocomplete="off" class="layui-input" type="text">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">专业</label>
            <div class="layui-input-block">
                <select name="majorid" id="majorid" lay-filter="aihao" id="majorid">
                
                </select>
            </div>
        </div>
                
        <div class="layui-form-item">
            <label class="layui-form-label">教师职称</label>
            <div class="layui-input-block">
                <select name="titleid" id="titleid" lay-filter="aihao1" id="titleid">
                  
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
				form.render('radio');
				form.render("select");
			}); 

        //日期
        
        laydate.render({
            elem: '#date1'
        });

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,content: function(value){
                layedit.sync(editIndex);
            }
        });

        //监听指定开关
        form.on('switch(switchTest)', function(data){
            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
        });

               //监听提交
        form.on('submit(demo1)', function(data){
          	$.post("EditTeacher",
          		JSON.stringify(data.field),
          		function(data){
          			if(data == "1")
          			{
          				layer.msg("教师号重复", {
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
					layer.confirm('是否取消修改', {
						icon: 3,
						title: '修改提示'
					}, function() {

						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);

					});
				});
        
        
        //验证教师工号是否存在
        $("#empnum").blur(function(){
          		$.post("IdVerify",
          			{"id":$("#empnum").val()},
          			function(data){
          				if(data=="1"){
          					layer.msg('该教师已添加!',{
                					icon:2, //图标
                					time:2000,  //2秒关闭(如果不配置,默认是3秒)
                					anim: 5   //动画特效
                					});
          				}
          			});
          		
          		
          });
          
    //动态获取教师职称和专业的下拉框


    $.get("TitleAndMajor",
    	{"methodname":"tmlode"},
		function(data){
		var i;
		for (i=0;i<data.major.length;i++){			
			$("#majorid").append("<option value='"+data.major[i].id+"'>"+data.major[i].majorName+"</option>");			
		}	
		for (i=0;i<data.title.length;i++){
			$("#titleid").append("<option value='"+data.title[i].id+"'>"+data.title[i].titleName+"</option>");
			}
			form.render('select');			
		});	
    	
    
    
    
    });
       
</script>

</body>
</html>


