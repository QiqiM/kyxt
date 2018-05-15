<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>

	<head>
		<base href="<%=basePath%>">

		<link rel="stylesheet" href="./layui/css/layui.css" media="all">
	</head>

	<body>
		<span hidden="hidden" id='paperid'></span>
		<div style="text-align: center;">
			<div class="layui-inline">
				<br>
				<table id="demo" lay-filter="demo" class="layui-table">
					  <colgroup>
    				<col width="150">
    				<col width="200">
    				<col width="150">
    				<col width="200">
  					</colgroup>
  					<tbody>
					<tr>
						<td >论文名称</td>
						<td id="title" colspan="3"></td>

					</tr>
					<tr>
						<td>第一作者</td>
						<td id="firstauthor"></td>
						<td>第一作者类型</td>
						<td id="fatype"></td>
						
					</tr>
					<tr>
						<td>发表时间</td>
						<td id="pubtime"></td>
						<td>所属专业</td>
						<td id="majorname"></td>
						
					</tr>
					<tr>
						<td>学科分类</td>
						<td id="subpart"></td>
						<td>一级学科</td>
						<td id="firstsub"></td>	
					</tr>
					<tr>
						<td>期刊分类</td>
						<td id="pubpart"></td>
						<td>期刊名称</td>
						<td id="journal"></td>	
					</tr>
					<tr>
						<td>项目来源</td>
						<td id="prosource"></td>
						<td>版面</td>
						<td id="layout"></td>	
					</tr>
					<tr>
						<td>发表范围</td>
						<td id="pubarea"></td>
						<td>是否译文</td>
						<td id="istrans"></td>	
					</tr>
					<tr>
						<td>附件</td>
						<td id="fileurl" colspan="3"><a href="DownLoadFlie?filename="  id="file" style="color:red"></a></td>
						
					</tr>
					</tbody>
				
				</table>
				<button class="layui-btn layui-btn-normal"  id= "auditdetail">审核情况</button>
				<button class="layui-btn layui-btn-normal" onclick="javascript:history.back(-1);">返回</button>
			</div>
		</div>

		<script src="./layui/layui.js" charset="utf-8"></script>

		<script src="./jquery/jquery-3.2.1.min.js"></script>
	
		<script>
			layui.use(['layer', 'form', 'table'], function() {
				var form = layui.form;
				var table = layui.table;
				var layer = layui.layer;
				$("#paperid").val(${param.paperid}); 
        		//alert($("#tid").val());
					
				$.get('PaperInfo',
				  {"paperid":$("#paperid").val()},
				  function(res){
				  		//alert(res.data[0].empnum);
				  		$("#title").text(res.data[0].title);
				  		$("#firstauthor").text(res.data[0].firstauthor);
				  		var fa = $("#firstauthor").text();
				  		if(fa.indexOf("（学）")>-1 || fa.indexOf("(学)")>-1){
				  			$("#fatype").text("本校学生")
				  		}else{
				  			$("#fatype").text("本校老师")
				  		}
				  		
				  		$("#pubtime").text(res.data[0].pubtime);
				  		$("#majorname").text(res.data[0].majorname);
				  		$("#subpart").text(res.data[0].subpartname);
				  		$("#firstsub").text(res.data[0].firstsubname);
				  		$("#pubpart").text(res.data[0].pubpartname);
				  		$("#journal").text(res.data[0].journalname);
				  		$("#prosource").text(res.data[0].sourcename);
				  		$("#pubarea").text(res.data[0].pubarea);
				  		$("#layout").text(res.data[0].layout);
				  		$("#istrans").text(res.data[0].istrans);
				  		$("#fileurl a").text(res.data[0].fileurl);  
				  		
				  	var file1 = $("#file").text();
				 	//alert($("#file").text());
				 	var str = "DownLoadFile?filename=" + file1;
				 	//alert(str);
				 	$("#file").attr("href",str); 	
				 		
				 			//$("#file").click(function(){
				 			//alert($("#file").text());
				 			//})
				  });
				  
				  
				   $("#auditdetail").click(function(){
				 
				 	 layer.open({
							type: 2,
							title: '审核记录详细信息',
							shade: 0,
							fixed: false,
							area: ['950', 400],
							maxmin: true, //最大化，最小化
							content: 'paper/auditQuery.jsp',
							success: function(layero, index) {
									var body = layer.getChildFrame('body', index); //巧妙的地方在这里哦
									body.contents().find("#paperid").val($("#paperid").val());

								}
				 			});
				 		});
				 
				  

			});
		</script>
	</body>

</html>