<%@ include file="header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="main-content">
	<div class="breadcrumbs" id="breadcrumbs">
		<script type="text/javascript">
			try {
				ace.settings.check('breadcrumbs', 'fixed')
			} catch (e) {
			}
		</script>

		<ul class="breadcrumb">
			<li>
				<i class="icon-home home-icon"></i> 
				<a href="/ClassManagement/index">首页</a>
			</li>
		</ul>
		<!-- .breadcrumb -->

		<div class="nav-search" id="nav-search">
			<form class="form-search">
				<span class="input-icon"> 
					<input type="text" placeholder="Search..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
					<i class="icon-search nav-search-icon"></i>
				</span>
			</form>
		</div>
		<!-- #nav-search -->
	</div>

	<div class="page-content">
		<div class="row">
			<div class="col-xs-12" style="width: 96%;">
				<!-- PAGE CONTENT BEGINS -->
				<div class="well" style="background-color: ghostwhite">
					<div class="page-header" style="border-bottom: 1px dotted #438eb9;">
						<h1 style="font-size: 20px; color: #d15b47 !important;">
							<c:choose>
								<c:when test="${is_teacher==true}">个人发布课程</c:when>
								<c:otherwise>个人添加课程</c:otherwise>
							</c:choose>
							<small> <i class="icon-double-angle-right"></i> Personal Published
								Courses
							</small>
						</h1>
					</div>
					<!-- /.page-header end -->

					<div style="margin: 0 8px; border-bottom: 1px dotted #438eb9; padding: 10px 0;">
						<!-- class list begin -->
						<h4 style="color: #8089a0;">
							<c:if test="${anyCourses==false}">
								<c:choose>
									<c:when test="${is_teacher==true}">暂未发布课程</c:when>
									<c:otherwise>暂未添加课程</c:otherwise>
								</c:choose>
							</c:if>
							<c:forEach items="${course_infos}" var="course">
								<a href="/ClassManagement/course/index?course_id=${course.course_id}">
									<button class="btn btn-sm btn-app btn-inverse" style="font-size: 12px;">
										${course.course_name}
									</button>
								</a>
							</c:forEach>
						</h4>
						<button class="btn btn-app btn-success" id="publish_new_course" style="font-size: 15px; margin-top: 10px;">
							<c:choose>
								<c:when test="${is_teacher==true}">点此发布</c:when>
								<c:otherwise>点此添加</c:otherwise>
							</c:choose>
						</button>
					</div>
				</div>

				<div class="well" id="well_draw_chart" style="background-color: ghostwhite;">
					<div class="page-header" style="border-bottom: 1px dotted #438eb9;">
						<h1 style="font-size: 20px; color: #d15b47 !important;">
							课程数据情况总览 <small> <i class="icon-double-angle-right"></i> Course Data Situation
								Overview
							</small>
						</h1>
					</div>
					<!-- page-header end -->
					<div class="widget-box">
						<c:choose>
							<c:when test="${anyCourses!=false}">
								<div class="widget-header widget-header-flat widget-header-small">
									<i class="icon-star orange"></i>
									所有课程
									<div class="widget-toolbar no-border">
										<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown">当前</button>
									</div>
								</div>
								<div class="widget-body" style="background-color:ghostwhite">
									<div class="widget-main" style="width:50%;display:block;float: left;">
										<div id="student-ratio"></div>
									</div> <!-- /widget-main -->
									<div class="widget-main" style="width:50%;display:block;float:left;">
										<div id="attendance-ratio"></div>
									</div> <!-- /widget-main -->
								</div> <!-- /widget-body -->
							</c:when>
							<c:otherwise>
								<div style="margin: 0 8px; border-bottom: 1px dotted #438eb9; padding: 10px 0;">
									<h1 style="font-size: 20px; color: #8089a0 !important;">暂无相关数据</h1>
								</div>
							</c:otherwise>
						</c:choose>
					</div> <!-- /widget-box -->
				</div>
				<!-- /well -->
				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.page-content -->
</div>
<!-- /.main-content -->
<%@ include file="footer.jsp"%>
<script type="text/javascript">
	jQuery(function($) {
		var anyCourses = ${anyCourses};
		if( anyCourses != false ){
			$("#well_draw_chart").attr("style", "background-color: ghostwhite; min-height:325px;");
		}
		
		var student_ratio = $('#student-ratio').css({
			'width' : '70%',
			'min-height' : '150px'
		});
		
		// ajax获取男女比例数据
		var male_ratio, female_ratio;
		if(anyCourses != false){
			var courseList = "${user_info.courseList}";
			$.ajax({
				url : '/ClassManagement/index/getCourseData',
				data: {courseList : courseList},
				type: 'post',
				dataType: 'json',
				async:false,
				success: function(r){
					if(r.male_ratio)
						male_ratio = r.male_ratio;
					if(r.female_ratio)
						female_ratio = r.female_ratio;
				}
			})
		}
		
		var data = [ {
			label : "男",
			data : male_ratio,
			color : "#4F4E96"
		}, {
			label : "女",
			data : female_ratio,
			color : "#DA5430"
		} ]
		function drawPieChart(ratio, data, position) {
			$.plot(ratio, data, {
				series : {
					pie : {
						show : true,
						tilt : 0.8,
						highlight : {
							opacity : 0.25
						},
						stroke : {
							color : '#fff',
							width : 2
						},
						startAngle : 2
					}
				},
				legend : {
					show : true,
					position : position || "ne",
					labelBoxBorderColor : null,
					margin : [ -40, 15 ]
				},
				grid : {
					hoverable : true,
					clickable : true
				}
			})
		}
		drawPieChart(student_ratio, data);

		/**
		we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
		so that's not needed actually.
		 */
		 student_ratio.data('chart', data);
		 student_ratio.data('draw', drawPieChart);

		var $tooltip = $(
				"<div class='tooltip top in'><div class='tooltip-inner'></div></div>")
				.hide().appendTo('body');
		var previousPoint = null;

		student_ratio.on('plothover', function(event, pos, item) {
			if (item) {
				if (previousPoint != item.seriesIndex) {
					previousPoint = item.seriesIndex;
					var tip = item.series['label'] + " : "
							+ item.series['percent'] + '%';
					$tooltip.show().children(0).text(tip);
				}
				$tooltip.css({
					top : pos.pageY + 10,
					left : pos.pageX + 10
				});
			} else {
				$tooltip.hide();
				previousPoint = null;
			}

		});
		
		var attendance_ratio = $('#attendance-ratio').css({
			'width' : '70%',
			'min-height' : '150px'
		});
		data = [ {
			label : "正常",
			data : 85,
			color : "#68BC31"
		}, {
			label : "缺勤",
			data : 4,
			color : "#4F4E96"
		}, {
			label : "迟到",
			data : 9,
			color : "#DA5430"
		}, {
			label : "早退",
			data : 2,
			color : "#FEE074"
		} ]
		drawPieChart(attendance_ratio, data);
		attendance_ratio.data('chart', data);
		attendance_ratio.data('draw', drawPieChart);
		attendance_ratio.on('plothover', function(event, pos, item) {
			if (item) {
				if (previousPoint != item.seriesIndex) {
					previousPoint = item.seriesIndex;
					var tip = item.series['label'] + " : "
							+ item.series['percent'] + '%';
					$tooltip.show().children(0).text(tip);
				}
				$tooltip.css({
					top : pos.pageY + 10,
					left : pos.pageX + 10
				});
			} else {
				$tooltip.hide();
				previousPoint = null;
			}

		});
	})
	
	$('#publish_new_course').click(function(){
		window.location.href = "/ClassManagement/index/add";
	})
</script>