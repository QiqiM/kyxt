<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<style>
body{
	font-family: Arial, Helvetica, sans-serif ,"微软雅黑";
	font-size: 14px;
	font-weight: normal;
}

#bottom{
	clear:both;
	width:1200px;
	height:110px;
	margin:0 auto;
	text-align: center;
	
}

#bottomContent{
	padding: 14px 0 0 0;
	line-height: 200%;
	text-align: center;
	
	
}

#text{
	color: #FFFFFF;
	font-size: 12px;
}

</style>
 
 <body>
    <div style="background-color:#086691;width:100%">
    	<div id="bottom">
    		<div id="bottomContent" >
    		<span id="text">
    		&copy 2017 辽宁工程技术大学电信学院
    		<br>
    		地址：葫芦岛市兴城市辽宁工程技术大学行政楼5楼   邮编：125100 电话：0451-85421542
    		<br>
    		管理维护：电信学院  技术支持：信息化处
    		</span>
    		</div>
    	</div>
    </div>
 </body>

