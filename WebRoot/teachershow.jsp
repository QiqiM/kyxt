<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<title>电信学院科研管理系统</title>
		<link rel="stylesheet" href="layui/css/layui.css">
		<link rel="stylesheet" href="css/teachershow.css">

	</head>

	<body>
		<!-- 你的HTML代码 -->
		
		<div id="out-box">
			<span><span id="greet"></span>好，</span>
			<span><%=request.getSession().getAttribute("username")%>老师 ！ &nbsp;&nbsp;&nbsp;</span>
			<span id="time"></span>
			<hr>
			<a href="paper/TQueryPaper.jsp"><span class="show">你有科研论文<span id="all"></span>篇</span></a> <br>
			<span class="show">审核通过<span id = "pass"></span>篇</span><br>
			<span class="show">未审核<span id="noaudit"></span>篇</span><br>
			<span class="show">未通过<span id= "nopass"></span>篇</span><br>
			<hr>
			<p>请你对未审核通过的论文资料进行修改，以便及早通过！</p>
			
		
		</div>

	</body>

	<script src="jquery/jquery-3.2.1.min.js"></script>
	<script src="layui/layui.js" media="all"></script>
	<script>

  //创建一个日期对象

  function show(){

  var d=new Date();

  //获取年份

  //var nian=d.getYear();//2016  //16

  var nian=d.getFullYear();//2016

  //获取月

  var yue=d.getMonth()+1;//6   july 7月   0-11

  //获取星期几

  var xq=d.getDay();//5    0-6    0:星期天
  var week=new Array("日","一","二","三","四","五","六");
  var xq1 = week[xq];

  //获取几号

  var dd=d.getDate();//1    1-31

  //获取小时

  var h=d.getHours();// 16下午4点     24小时制
  if(h < 6){$("#greet").text("凌晨")}
else if (h < 9){$("#greet").text("早上")}
else if (h < 12){$("#greet").text("上午")}
else if (h < 14){$("#greet").text("中午")}
else if (h < 17){$("#greet").text("下午")}
else if (h < 19){$("#greet").text("傍晚")}
else if (h < 22){$("#greet").text("晚上")}
else {$("#greet").text("夜里")} 
  //获取分钟

  var m=d.getMinutes();//31分
  if(m<10)
  {
  	m = '0' + m;
  }
  //获取描述

  var s=d.getSeconds();//50秒
  if(s<10)
  {
  	s = '0' + s;
  }

  document.getElementById("time").innerHTML = nian + "年"+ yue + "月" +dd+"日    "+"星期"+xq1+"    "+h+":"+m+":"+s; 

  }

  setInterval("show()",1000);

  </script>

	<script>
		//一般直接写在一个js文件中
		//Demo
	
		
		layui.use(['form', 'layer'], function() {
			var form = layui.form;
			var layer = layui.layer;
			
			$.post("TeacherShow",
				function(data){
					//for ( var i = 0; i < data.length; i++) {
                	//	alert(data[i]);
            		//}
            		$("#all").text(data[0]); 
            		$("#pass").text(data[1]);    
            		$("#noaudit").text(data[3]);    
            		$("#nopass").text(data[2]);       
				
				}
			
			);
	
			
		
		});
	</script>
	</body>

</html>