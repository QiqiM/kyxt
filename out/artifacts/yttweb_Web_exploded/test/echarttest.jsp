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
    	
    	<span id="time"></span>
    	
    	
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
    	
	
		<script src="./jquery/jquery-3.2.1.min.js"></script>
		<script src="./js/echarts.js"></script>

  
		
		<script type="text/javascript">
		$(function(){//jquery的文档就绪函数
		
		
	
	
		
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        
		
        // 指定图表的配置项和数据
       option = {
       
         title: {
                text: '专业论文统计'
            },
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        data:['电子',"计算机",'通信',"电控"]
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : ['2015','2016','2017','2018']
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'电子',
            type:'bar',
            data:[320, 332, 301, 334]
        },
        {
            name:'计算机',
            type:'bar',
            data:[120, 132, 101, 134]
        },
        
        {
            name:'通信',
            type:'bar',
            data:[862, 1018, 964, 1026],
            markLine : {
                lineStyle: {
                    normal: {
                        type: 'dashed'
                    }
                },
                data : [
                    [{type : 'min'}, {type : 'max'}]
                ]
            }
        },
         {
            name:'电控',
            type:'bar',
      
            data:[62, 82, 91, 84]
        }
        
    ]
};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
	});
    </script>

		

	</body>

</html>