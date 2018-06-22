<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<base href="<%=basePath%>">

		<title>Echarts</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<style>
			select {
				border: solid 2px #FFFF00;
				appearance: none;
				-moz-appearance: none;
				/*for firefox*/
				-webkit-appearance: none;
				/*for chrome*/
				padding-right: 10px;
				color: #393D49;
				/* 字体颜色*/
				font-size: 30px;
				width: 200px;
				height: 39px;
				overflow: hidden;
				background: right #FFFFFF;
			}
			
			option {
				color: #2BA5E6;
			}
		</style>
		<link rel="stylesheet" href="./layui/css/layui.css" media="all">
		<!--  <script type="text/javascript" src="http://echarts.baidu.com/build/dist/echarts.js"></script> -->
		<script src="./js/echarts.js"></script>
		<script src="./jquery/jquery-3.2.1.min.js"></script>
		<script src="layui/layui.js" charset="utf-8"></script>
		

	</head>

	<body>

		<div id="main" style="height: 450px; width: 800Px"></div>
		<div style="margin-left: 80px">
			<form class="layui-form layui-form-pane">
				<div class="layui-form-item">
					<br>
					<div class="layui-inline">

						<label class="layui-form-label">选择年限</label>
						<div class="layui-input-inline">
							<input name="time" id="date" lay-verify="date" placeholder="yyyy" autocomplete="off" class="layui-input" type="text">
						</div>
						<div class="layui-input-inline">
							<button type="button" class=" layui-btn layui-btn-normal" id="demo1"><i class="layui-icon" style="font-size:15px;">&#xe669; 生成图表  </i></button>
						</div>
						<div class="layui-input-inline">
							<button type="button" class=" layui-btn layui-btn-normal" id="reset" style="margin-left: 20px">重置</button>
						</div>
					</div>
				</div>

			</form>
			<select name="pubtypeid" id="pubtypeid" lay-filter="pubtypeid">
				<option value="0">请选择刊物类型</option>

			</select>
			<div class="layui-input-inline">
				<div id="a2" style="width:300px;height:38px;background:#E2EEF1;margin-left: 105px">
				</div>

			</div>
			<input hidden="hidden" id="pubid">
		</div>

		<script>
			layui.use(['form', 'layer', 'element'], function() {

				var form = layui.form,
					layer = layui.layer,
					element = layui.element;

				//异步加载期刊等级分类下拉框
				function loadselect() {
					$.get("PubPart", {
							"methodname": "lode"
						},
						function(data) {
							var i;
							for(i = 0; i < data.item.length; i++) {
								$("#pubtypeid").append("<option value='" + data.item[i].id + "'>" + data.item[i].name + "</option>");
							}

						});
				}
				loadselect();

				$(function() {
					var aa="";
					$("#pubtypeid").change(function() {
						if($(this).val() != '0') {
							setx($(this).find("option:selected").text());
							aa += $(this).find("option:selected").val() + ",";
							$("#pubid").val(aa);
							//alert($("#pubid").val());
						}

						$("#pubtypeid").find("option:selected").hide().fadeOut(1000);
					})

					function setx(data) {
						var temp = data + "/";
						var a = "<span>" + temp + "</span>";
						$("#a2").append(a);
					}

					$("#reset").click(function() {
						//alert($("#a2 span").text());
						//alert($("#pubid").val());
						$("#a2 span").text("");
						$("#date").val("");
						$("#pubtypeid").find("option").remove();
						$("#pubtypeid").append("<option value='0'>请先选择刊物类型</option>");
						$("#pubid").val("");
						aa="";
						//alert($("#pubid").val());
						loadselect();

					})

				})

			});
		</script>
		
		
		<script type="text/javascript">
			drewEcharts();
			function drewEcharts() {
				// 基于准备好的dom，初始化echarts图表
				var myChart = echarts.init(document.getElementById('main'));
				myChart.showLoading({
					animation: false,
					text: 'Loading',
					textStyle: {
						fontSize: 20
					}
				});
				//myChart.showLoading(); 

				var option = {
					title: {
						subtext: '专业按期刊分类统计发表论文情况'
					},
					tooltip: {
						show: true,
						trigger: 'axis'
					},
					legend: {
						data: []
					},
					toolbox: {
						show: true,
						feature: {
							dataView: {
								show: true,
								readOnly: false
							},
							magicType: {
								show: true,
								type: ['line', 'bar']
							},
							restore: {
								show: true
							},
							saveAsImage: {
								show: true
							}
						}
					},
					calculable: true,
					xAxis: [{
						type: 'category',
						data: []
					}],
					yAxis: [{
						type: 'value'
					}],
					series: []
				};

				$.ajax({
					type: "post",
					//async : false, //同步执行
					url: "PubChart",
					data: {},
					dataType: "json", //返回数据形式为json
					success: function(data) {

						//if(data){
						//alert(data[1][0]);
						//}

						var Item = function() {
							return {
								name: '',
								type: 'bar',
								markPoint: {
									data: [{
											type: 'max',
											name: '最大值'
										},
										{
											type: 'min',
											name: '最小值'
										}
									]
								},
								markLine: {
									data: [{
										type: 'average',
										name: '平均值'
									}]
								},
								data: []
							}
						}; // series中的每一项为一个item,所有的属性均可以在此处定义  

						var legends = []; // 准备存放图例数据  
						var Series = []; // 准备存放图表数据  

						var legend = {
							data: []
						};
						for(var i = 0; i < data[2].length; i++) {
							legend.data.push(data[2][i]); // 将每一项的图例名称也放到图例的数组中
						}

						option.legend = legend; //图例动态加载
						option.xAxis[0].data = data[1]; //动态加载x轴

						for(var j = 0; j < data[2].length; j++) {

							var it = new Item();
							it.name = data[2][j];
							it.data = data[j + 3];
							Series.push(it); // 将item放在series中  
						}
						option.series = Series; // 设置图表  
						myChart.setOption(option); // 重新加载图表  
						myChart.hideLoading(); //关闭加载动画

					},
					error: function(errorMsg) {
						alert("不好意思，大爷，图表请求数据失败啦!");
						myChart.hideLoading();
					}
				})

				layui.use(['layer', 'form', 'laydate', 'table'], function() {
					var form = layui.form;
					var layer = layui.layer;

					var laydate = layui.laydate;
					//日期渲染,日期验证
					date = new Date();
					laydate.render({
						elem: '#date',
						max: 'date',
						type: 'year',
						range: true
					});

					$("#demo1").click(function() {
						//alert($("#date").val());
						$.ajax({
							type: "post",
							url: "PubChart",
							data: {
								"pagetime": $("#date").val(),
								"pubpart":$("#pubid").val()
							},
							dataType: "json", //返回数据形式为json
							success: function(data) {

								var Item = function() {
									return {
										name: '',
										type: 'bar',
										markPoint: {
											data: [{
													type: 'max',
													name: '最大值'
												},
												{
													type: 'min',
													name: '最小值'
												}
											]
										},
										markLine: {
											data: [{
												type: 'average',
												name: '平均值'
											}]
										},
										data: []
									}
								}; // series中的每一项为一个item,所有的属性均可以在此处定义  

								var legends = []; // 准备存放图例数据  
								var Series = []; // 准备存放图表数据  

								var legend = {
									data: []
								};
								for(var i = 0; i < data[2].length; i++) {
									legend.data.push(data[2][i]); // 将每一项的图例名称也放到图例的数组中
								}

								option.legend = legend; //图例动态加载
								option.xAxis[0].data = data[1]; //动态加载x轴

								for(var j = 0; j < data[2].length; j++) {

									var it = new Item();
									it.name = data[2][j];
									it.data = data[j+3];
									Series.push(it); // 将item放在series中  
								}
								option.series = Series; // 设置图表  
								myChart.setOption(option, true); // 重新加载图表  

							},
							error: function(errorMsg) {
								alert("不好意思，大爷，图表请求数据失败啦!");
								myChart.hideLoading();
							}
						})

					});

				});

			}
		</script>

	</body>

</html>