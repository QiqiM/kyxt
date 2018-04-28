<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>

#top{
	width: 100%;
	height: 111px;
	background-repeat: no-repeat;
	background-position: center;
	background-color: #1d60a4;
	position: relative;
}
#user{
  color: #fcff40;
  text-align: center;
  width: 160px;
  height: 25px;
  margin-top: 65px;
  position: absolute;
}

#loginout{
	color:#fcff40;
}



</style>
  <body>
  <%
  String str = request.getSession().getAttribute("access").toString();
  String access,name; 
  if(str.equals("1")){
	access = "Admin";
  }else{
  	access = "Teacher";
  }%>
    <div id="top">
      <div id="user">
      	<p id="qx" hidden="hidden"><%=access%></p>
      	<span><%=access %> : <%=request.getSession().getAttribute("username") %>&nbsp;&nbsp;</span>
      	<a id="loginout" href='loginout.jsp' target="_parent">退出</a>
      </div>
    </div>
    
    <script src="jquery/jquery-3.2.1.min.js"></script>  
    <script>
    	$(function(){
    		if(($("#qx").text())=="Teacher"){
    			$("#top").css('background-image','url(images/top_05.jpg)');
    		}else{
    			$("#top").css('background-image','url(images/top_04.jpg)');
    		}
    	
    	
    	});
    
    </script>  
  </body>
  
