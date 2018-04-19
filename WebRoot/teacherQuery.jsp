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
  <body >
  <form class="layui-form layui-form-pane">
     <div class="layui-form-item"> 
         <div class="layui-inline">
           <label class="layui-form-label">教师工号</label>
              <div class="layui-input-inline">
                 <input id="empnum" name="empnum"   autocomplete="off" class="layui-input" type="text">
              </div>
           <label class="layui-form-label">教师姓名</label>
        	 <div class="layui-input-inline">
                <input id="name" name="name"  autocomplete="off" class="layui-input" type="text">
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
      <div class="layui-input-inline">
      <button class="layui-btn" lay-submit="" lay-filter="demo1">立即查询</button>
      <button type="reset"  class="layui-btn layui-btn-primary">重置</button>
    </div>
     
  </div>
 
</form>
 
<table id="demo" lay-filter="test"></table>
      
                       
<script src="layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="jquery/jquery-3.2.1.min.js"></script> 
<script>
layui.use(['layer','form','table'], function(){
  var form = layui.form;
  var table = layui.table;
  var layer = layui.layer;
  
  //第一个实例
  var tableIns = table.render({
    elem: '#demo'
    ,skin: 'line' //行边框风格
    ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
   ,even: true //开启隔行背景
    ,height: 500
    ,url: 'QueryTeacher' //数据接口
    ,page:true
       //开启分页
    ,cols: [[ //表头
      {field: 'empnum', title: '教师工号',sort:true}
      ,{field: 'name', title: '教师姓名'}
      ,{field: 'sex', title: '性别'}
      ,{field: 'majorname', title: '专业'} 
      ,{field: 'titlename', title: '职称'}
      ,{field: 'birthday', title: '生日'}
      ,{field: 'telephone', title: '电话号码'}
    ]]
  });
  
  form.on('submit(demo1)', function(data){

	tableIns.reload({
  		where:{
  			empnum:$("#empnum").val(),
  			name:$("#name").val(),
  			majorid:$("#majorid").val(),
  			titleid:$("#titleid").val()
  		},
  		page: {
    			curr: 1 //重新从第 1 页开始
  			}
  	});
  	
  	
  	
  	
  	
  	
  	
  		return false;
  });
 
 
 	  //异步获取教师职称和专业的下拉框
  	    $.get("TitleAndMajor",
		function(data){
		var i;
		for (i=0;i<data.major.length;i++){
			
			$("#majorid").append("<option value='"+data.major[i].id+"'>"+data.major[i].majorName+"</option>");
			
		}	
		//form.render('select','aihao');
		for (i=0;i<data.title.length;i++){
			//alert(data.title[i].id);
			$("#titleid").append("<option value='"+data.title[i].id+"'>"+data.title[i].titleName+"</option>");
			
			//console.log(data.title[i].id);
			}
			form.render();
			
		});	
  
});
</script>
 </body>
</html>

