<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<div class="ace-settings-container" id="ace-settings-container">
					<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
						<i class="icon-cog bigger-150"></i>
					</div>

					<div class="ace-settings-box" id="ace-settings-box">
						<!--  
						<div>
							<div class="pull-left">
								<select id="skin-colorpicker" class="hide">
									<option data-skin="default" value="#438EB9">#438EB9</option>
									<option data-skin="skin-1" value="#222A2D">#222A2D</option>
									<option data-skin="skin-2" value="#C6487E">#C6487E</option>
									<option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
								</select>
							</div>
							<span>&nbsp; 更换皮肤</span>
						</div>
						-->

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
							<label class="lbl" for="ace-settings-navbar">固定导航条</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
							<label class="lbl" for="ace-settings-sidebar">固定左栏(非移动端)</label>
						</div>
						
						<!-- 
						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
							<label class="lbl" for="ace-settings-rtl">切换到左边</label>
						</div>
						 -->
						 
						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
							<label class="lbl" for="ace-settings-add-container">切换窄屏(非移动端)</label>
						</div>
					</div>
				</div><!-- /#ace-settings-container -->
			</div><!-- /.main-container-inner -->
			
			<div style="float:right;width:240px;font-weight:bold;" id="runTime"></div>
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<span style="font-size:16px;">⇧</span>
			</a>
		</div><!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->
		<!-- 
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
		-->
		<!-- <![endif]-->

		<!--[if IE]>
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<![endif]-->

		<!--[if !IE]> -->

		<script type="text/javascript">
			//window.jQuery || document.write("<script src=\'<c\:url value=\""+"/js/jquery-2.0.3.min.js\"></c\:url>\'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
			<script type="text/javascript">
 				window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
			</script>
		<![endif]-->

		<script type="text/javascript">
			//if("ontouchend" in document) document.write("<script src='<c\:url value=\""+"/js/jquery.mobile.custom.min.js\"></c\:url>'>"+"<"+"/script>");
		</script>
		<script src='<c:url value="/js/jquery-2.0.3.min.js"></c:url>'></script>
		<script src='<c:url value="/js/jquery.mobile.custom.min.js"></c:url>'></script>
		<script src='<c:url value="/js/bootstrap.min.js"></c:url>'></script>
		<script src='<c:url value="/js/typeahead-bs2.min.js"></c:url>'></script>

		<!-- page specific plugin scripts -->
		<script src='<c:url value="/js/jquery-ui-1.10.3.custom.min.js"></c:url>'></script>
		<script src='<c:url value="/js/jquery.ui.touch-punch.min.js"></c:url>'></script>
		<script src='<c:url value="/js/jquery.gritter.min.js"></c:url>'></script>
		<script src='<c:url value="/js/jquery.slimscroll.min.js"></c:url>'></script>
		<script src='<c:url value="/js/jquery.easy-pie-chart.min.js"></c:url>'></script>
		<script src='<c:url value="/js/jquery.sparkline.min.js"></c:url>'></script>
		<script src='<c:url value="/js/flot/jquery.flot.min.js"></c:url>'></script>
		<script src='<c:url value="/js/flot/jquery.flot.pie.min.js"></c:url>'></script>
		<script src='<c:url value="/js/flot/jquery.flot.resize.min.js"></c:url>'></script>
		<script src='<c:url value="/js/select2.min.js"></c:url>'></script>
		<script src='<c:url value="/js/x-editable/bootstrap-editable.min.js"></c:url>'></script>
		<script src='<c:url value="/js/x-editable/ace-editable.min.js"></c:url>'></script>
		<script src='<c:url value="/js/jquery.maskedinput.min.js"></c:url>'></script>
		<!-- ace scripts -->

		<script src='<c:url value="/js/ace-elements.min.js"></c:url>'></script>
		<script src='<c:url value="/js/ace.min.js"></c:url>'></script>

		<!-- inline scripts related to this page -->
		<!-- 
			<div style="display:none"><script src='http://v7.cnzz.com/stat.php?id=155540&web_id=155540' language='JavaScript' charset='gb2312'></script></div>
		-->
		<script type="text/javascript">
			function openChattingRoom(receiver_id){
				window.open('/ClassManagement/user/chatting?receiver_id='+receiver_id, 'newwindow', 
						'height=420px, width=600px, top=200px, left=400px, toolbar=no, menubar=no, scrollbars=no, resizable=true, location=no, status=no');
			}
			jQuery(function($){
				
				/** 设置首页导航栏未读消息情况 */
				$.ajax({
					url:"/ClassManagement/index/getUnreadMessageStatistic",
					type:"post",
					dataType:"json",
					
					success : function(r){
						var count = 0;
						var message_unread_show = 
							'<li class="dropdown-header" style="background-color:#E3FBED!important;color:#412E50;">'+
								'<i class="icon-comment"></i>'+'消息提示'+
							'</li>';
						$.each(r,function(key,value){ 
							count++;
							message_unread_show += 
								'<li>'+
									'<a href="#" onclick="openChattingRoom('+r[key].sender_id+')">'+
										'<img src=\'<c:url value="/img/avatars/avatar.jpg"></c:url>\' class="msg-photo" alt="'+r[key].sender_name+'\'s Avatar" />'+
										'<span class="msg-body">'+
											'<span class="msg-title">'+
												'<span class="blue">'+r[key].sender_name+':</span>'+
												' Sent you the messages ...'+
												'<span class="pull-right badge badge-danger">+'+r[key].message_num+'</span>'+
											'</span>'+

											'<span class="msg-time green">'+
												'<i class="icon-time green"></i>'+
												'<span>'+r[key].date+'</span>'+
											'</span>'+
										'</span>'+
									'</a>'+
								'</li>';
						}); 
						message_unread_show += 
							'<li>'+
								'<div style="text-align:center; color:#8090a0;">'+
									'<i class="icon-mail-forward"></i> No more messages'+
								'<div>'+
							'</li>';
						document.getElementById('unread_message_num').innerHTML = count;
						document.getElementById('message_unread_show').innerHTML = message_unread_show;
					}
				});
				
				/** 设置首页导航栏公告情况 */
				$.ajax({
					url:'/ClassManagement/index/getAllNoticesStatistic',
					type: 'post',
					
					success : function(r){
						var total_notice_num = 0;
						var all_notices_show = 
							'<li class="dropdown-header">'+
								'<i class="icon-warning-sign"></i>'+'课程公告'+
							'</li>';
						for( var item in r){
							total_notice_num += r[item].notice_num;
							all_notices_show +=
								'<li>'+
									'<a href="/ClassManagement/notice/index?course_id='+r[item].course_id+'">'+
										'<div class="clearfix">'+
											'<span class="pull-left">'+
												'<i class="btn btn-xs no-hover btn-pink icon-magic"></i>'+
												r[item].course_name+
											'</span>'+
											'<span class="pull-right badge badge-info">+'+r[item].notice_num+'</span>'+
										'</div>'+
									'</a>'+
								'</li>'
						}
						all_notices_show +=
							'<li>'+
								'<div style="text-align:center;">'+
									'<i class="icon-mail-forward"></i> No more notices'+
								'</div>'+
							'</li>';
						//document.getElementById('total_notices_num').innerHTML = total_notice_num-0;
						document.getElementById('all_notices_show').innerHTML = all_notices_show;
					}
				})
				
				/** 设置首页导航栏课程情况 */
				$.ajax({
					url:"/ClassManagement/index/getAllCourse_infos",
					type:"post",
					
					success : function(r){
						var all_my_courses = 
							'<li class="dropdown-header">'+
								'<i class="icon-ok"></i>'+'所有课程'+
							'</li>';
						for( var item in r ){
							all_my_courses +=
								'<li>'+
								'<a href="/ClassManagement/course/index?course_id='+r[item].course_id+'">'+
									'<div class="clearfix">'+
										'<span class="pull-left">'+
											'<i class="btn btn-xs no-hover btn-danger icon-fire"></i>'+
											r[item].course_name+
										'</span>'+
										'<span class="pull-right badge badge-info"><i class="icon-arrow-right"></i></span>'+
									'</div>'+
								'</a>'+
							'</li>';
						}
						all_my_courses +=
							'<li>'+
								'<div style="text-align:center;">'+
									'<i class="icon-mail-forward"></i> No more courses'+
								'</div>'+
							'</li>';
						document.getElementById('all_my_courses').innerHTML = all_my_courses;
					}
					
				})
			})
		</script>
</body>
</html>
