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

		
	<form class="layui-form"  enctype="text/plain">
    <div class="layui-form-item">
        <label class="layui-form-label" >名称</label>
        <div class="layui-input-block">
            <input name="name" lay-verify="name" autocomplete="off" placeholder="请输入标题" class="layui-input" type="text"/>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">照片</label>
        <div class="layui-input-block">
            <button type="button" class="layui-btn" id="upload1">上传图片</button>
            <input type="hidden" id="img_url" name="img" value=""/>
            <div class="layui-upload-list">
                <img class="layui-upload-img" width="100px" height="80px" id="demo1"/>
                <p id="demoText"></p>
            </div>
        </div>
    </div>

    <div class="layui-form-item" style="text-align: center;">
        <button type="submit" class="layui-btn" onclick="update" >保存</button>
        <button class="layui-btn" lay-submit=""  lay-filter="*" >立即提交</button>
    </div>
</form>
		<script src="./jquery/jquery-3.2.1.min.js"></script>
		<script src="./layui/layui.js" charset="utf-8"></script>

		<script>
		layui.use('upload', function(){
        var upload = layui.upload
            , $ = layui.jquery;
        var uploadInst = upload.render({
            elem: '#upload1' //绑定元素
            ,url: 'UploadTest' //上传接口
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
                //上传成功
                alert("上传成功"+res.src);
                document.getElementById("img_url").value = res.src;

            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });
    });
	
		</script>

	</body>

</html>