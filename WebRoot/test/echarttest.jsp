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
		 <style>
        /*内部样式表，一般用于覆盖公用样式*/
      	 #outbox{
            color: 0xff5;
            width:100%;
            height:100%;
            margin: 0 -150 0 -150
         }
    </style>
	</head>
	
	<body>

		 <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
		 <div id="outbox" style="width:100%;height:100%;">
    		<div id="main" style="width: 600px;height:400px;">
    		</div>
    	</div>
	
		<script src="./jquery/jquery-3.2.1.min.js"></script>
		<script src="./js/echarts.js"></script>
		<script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: 'ECharts 入门示例'
            },
            tooltip: {},
            legend: {
                data:['销量']
            },
            xAxis: {
                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: [5, 20, 36, 10, 10, 20]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>

		

	</body>

</html>