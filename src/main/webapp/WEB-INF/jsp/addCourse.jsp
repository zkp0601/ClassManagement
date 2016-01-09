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
			<li><i class="icon-dashboard"></i> <a href="/ClassManagement/">首页</a></li>

			<li class="active">发布课程</li>
		</ul>
		<!-- .breadcrumb -->

		<div class="nav-search" id="nav-search">
			<form class="form-search">
				<span class="input-icon"> <input type="text"
					placeholder="Search ..." class="nav-search-input"
					id="nav-search-input" autocomplete="off" /> <i
					class="icon-search nav-search-icon"></i>
				</span>
			</form>
		</div>
		<!-- #nav-search -->
	</div>

	<div class="page-content">
		<div class="row">
			<div class="col-xs-12" style="width: 96%;">
				<div class="well" style="background-color: ghostwhite">
					<div class="page-header">
						<h1>
							课程信息 <small> <i class="icon-double-angle-right"></i>
								Course Informations
							</small>
						</h1>
					</div>
					<!-- /.page-header -->

					<form class="form-horizontal" action="/ClassManagement/course/insert" method="post" role="form"  
						id="form_validate" style="margin-left:12px;">
						<div class="form-group" style="height: 20px;">
							<label class="control-label no-padding-right" for="form-field-1" style="float:left;"> &nbsp;&nbsp;&nbsp;课程名称 </label>
							
							<div class="col-sm-8" style="float:left;">
								<span class="input-icon">
									<input type="text" id="course_name" name="course_name" />
									<i class="icon-book blue"></i>
								</span>
							</div>
						</div>

						<div class="space-4"></div>

						<div class="form-group" style="height: 20px;">
							<label class="control-label no-padding-right"
								for="form-field-2" style="float:left;"> &nbsp;&nbsp;&nbsp;课程老师 </label>

							<div class="col-sm-8" style="float:left;">
								<span class="input-icon">  
									<input type="text" id="teacher_name" name="teacher_name" />
									<i class="icon-user"></i>
								</span>
							</div>
						</div>

						<div class="space-4"></div>

						<div class="form-group" style="height: 20px;">
							<label class="control-label no-padding-right" for="form-field-2" style="float:left;"> &nbsp;&nbsp;&nbsp;上课地点 </label>

							<div class="col-sm-8" style="float:left;">
								<span class="input-icon"> 
									<input type="text" id="position" name="position" />
									<i class="icon-map-marker orange"></i>
								</span>

							</div>
						</div>

						<div class="space-4"></div>

						<div class="form-group" style="height: 20px;">
							<label class="control-label no-padding-right" for="form-field-2" style="float:left;"> &nbsp;&nbsp;&nbsp;开始时间 </label>

							<div class="col-sm-8" style="float:left;">
								<span class="input-icon"> 
									<input type="text" id="start_time" name="start_time" autocomplete=off />
									<i class="icon-play green"></i>
								</span>

							</div>
						</div>

						<div class="space-4"></div>

						<div class="form-group" style="height: 20px;">
							<label class="control-label no-padding-right"
								for="form-field-2" style="float:left;"> &nbsp;&nbsp;&nbsp;结束时间 </label>

							<div class="col-sm-8" style="float:left;">
								<span class="input-icon"> 
									<input type="text" id="end_time" name="end_time" autocomplete=off />
									<i class="icon-pause red"></i>
								</span>

							</div>
						</div>

						<div class="space-4"></div>

						<div class="form-group" style="height: 20px;">
							<label class="control-label no-padding-right"
								for="form-field-2" style="float:left;"> 签到IP限制 </label>

							<div class="col-sm-8" style="float:left;">
								<span class="input-icon"> <input type="text"
									id="signInIP" name="signInIP" /> <i
									class="icon-exchange blue"></i>
								</span>

							</div>
						</div>

						<div class="space-4"></div>

						<div class="clearfix form-actions" style="background-color:ghostwhite;">
							<div class="col-md-offset-3 col-md-9">
								<button class="btn btn-info" type="submit">
									<i class="icon-ok bigger-110"></i> Submit
								</button>

								&nbsp; &nbsp; &nbsp;
								<button class="btn" type="reset">
									<i class="icon-undo bigger-110"></i> Reset
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="footer.jsp"%>

<script src='<c:url value="/js/jquery.validate.min.js"></c:url>'></script>
<script src='<c:url value="/js/date-time/DatePicker/WdatePicker.js"></c:url>'></script>

<style type="text/css"> 
	label.error{
		margin-left: 10px; 
		color: red; 
	}	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#form_validate').validate({
			focusCleanup:true,//clear the error message when the error element get focus again. 
			onkeyup:false, 
			rules:{
				course_name:"required",
				teacher_name:"required",
				position:"required",
				start_time:"required",
				end_time:"required"
			},
			messages:{
				course_name:"请输入课程名称",
				teacher_name:"请输入授课教师",
				position:"请输入上课地点",
				start_time:"请输入上课时间",
				end_time:"请输入下课时间"
			},
			errorPlacement: function(error, element) {                             //错误信息位置设置方法  
				 error.appendTo( element.next() );                        //这里的element是录入数据的对象  
			}
		});
	})
	
	$(function(){
		$("#start_time").click(function () {
            $this = $(this);
            WdatePicker({
                /* onpicked: function (dp) {
                    $this.parents('form').submit();
                }, */
                dateFmt: 'HH:mm'
            });
        });
        $("#end_time").click(function () {
            $this = $(this);
            WdatePicker({
                /* onpicked: function (dp) {
                    $this.parents('form').submit();
                }, */
                dateFmt: 'HH:mm'
            });
        });
	});
</script>