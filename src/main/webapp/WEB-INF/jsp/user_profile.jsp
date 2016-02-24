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
			<li><i class="icon-edit"></i> <a href="../user/profile">个人信息</a></li>
			<li class="active">${target_user_info.name}</li>
		</ul>
		<!-- .breadcrumb -->

		<div class="nav-search" id="nav-search">
			<form class="form-search">
				<span class="input-icon"> <input type="text"
					placeholder="Search..." class="nav-search-input"
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
				<!-- PAGE CONTENT BEGINS -->
				<div class="well" style="background-color: ghostwhite">
					<div class="page-header" style="border-bottom: 1px dotted #438eb9;">
						<h1 style="font-size: 20px; color: #d15b47 !important;">
							用户信息页面 <small> <i class="icon-double-angle-right"></i>
								User Profile Page
							</small>
						</h1>
					</div>
					<!-- /.page-header end -->
					
					<c:if test="${myself==true}">
						<div class="clearfix">
							<div class="pull-left alert alert-success no-margin">
								<button type="button" class="close" data-dismiss="alert">
									<i class="icon-remove"></i>
								</button>
	
								<i class="icon-exclamation-sign bigger-120 green"></i> 点击头像可进行修改
								...
							</div>
						</div>
						<div class="hr dotted"></div>
					</c:if>
					<div id="user-profile-1" class="user-profile row">
						<div class="col-xs-12 col-sm-3 center">
							<div>
								<span class="profile-picture"> <img id="avatar"
									class="editable img-responsive" alt="Alex's Avatar"
									src='<c:url value="/img/avatars/profile-pic.jpg"></c:url>' />
								</span>

								<div class="space-4"></div>

								<div
									class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
									<div class="inline position-relative">
										<div class="user-title-label">
											<i class="icon-circle light-green middle"></i> &nbsp; <span
												class="white">${target_user_info.name}</span>
										</div>
									</div>
								</div>
							</div>

							<div class="space-6"></div>
							<c:if test="${myself!=true}">
								<div class="profile-contact-info">
									<a href="#" class="btn btn-sm btn-block btn-success" id="show_chatting_room_btn"> <i
										class="icon-rss bigger-120" style="color: coral"></i> <span
										class="bigger-110">Sending A Message</span>
									</a>
								</div>
							</c:if>
						</div>

						<div class="col-xs-12 col-sm-9">
							<h4 class="blue">
								<span class="label label-purple arrowed-in-right"> <i
									class="icon-circle smaller-80 align-middle"></i> 用户名
								</span> <span class="middle">${target_user_name}</span>
							</h4>

							<div class="profile-user-info">
								<div class="profile-info-row">
									<div class="profile-info-name">用户ID</div>

									<div class="profile-info-value">
										<i class="icon-info-sign light-blue bigger-110"></i> <span
											id="user_id" name="user_id">${target_user_info.user_id}</span>
									</div>
								</div>

								<div class="profile-info-row">
									<div class="profile-info-name">位置</div>

									<div class="profile-info-value">
										<i class="icon-map-marker light-orange bigger-110"></i> <span>广东</span>
										<span>广州</span>
									</div>
								</div>

								<div class="profile-info-row">
									<div class="profile-info-name">性别</div>
									<div class="profile-info-value">
										<i class="icon-male light-blue"></i>
										<span class="editable editable-click" name="sex" id="sex">${target_user_info.sex}</span>
									</div>
								</div>

								<div class="profile-info-row">
									<div class="profile-info-name">联系电话</div>
									<div class="profile-info-value">
										<i class="icon-phone"></i> 
										<span class="editable editable-click" name="phone_num" id="phone_num">${target_user_info.phone_num}</span>
									</div>
								</div>

								<div class="profile-info-row">
									<div class="profile-info-name">邮箱</div>
									<div class="profile-info-value">
										<i class="icon-envelope" style="color: darkcyan;"></i> <span
											class="editable editable-click" name="email" id="email">${target_user_info.email}</span>
									</div>
								</div>

								<div class="profile-info-row">
									<div class="profile-info-name">注册时间</div>
									<div class="profile-info-value">
										<i class="icon-check green"></i> <span>20/06/2010</span>
									</div>
								</div>
							</div>

							<div class="hr hr-8 dotted"></div>

							<div class="profile-user-info">
								<div class="profile-info-row">
									<div class="profile-info-name">Website</div>

									<div class="profile-info-value">
										<a href="#" target="_blank">www.alexdoe.com</a>
									</div>
								</div>

								<div class="profile-info-row">
									<div class="profile-info-name">
										<i class="middle icon-weibo bigger-150"
											style="color: orangered;"></i>
									</div>

									<div class="profile-info-value">
										<a href="#">Find me on Weibo</a>
									</div>
								</div>
							</div>
							
							<div class="hr hr-8 dotted"></div>
							<c:if test="${myself==true}">
								<div class="profile-user-info">
									<div class="profile-info-row">
										<div class="profile-info-name"></div>
										<div class="profile-info-value">
											<button class="btn btn-app btn-info btn-inverse" id="save_profile" disabled="true" style="font-size: 12px;">保存</button>
										</div>
									</div>
								</div>
							</c:if>
						</div>

					</div>
				</div>
				<!-- well、PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.page-content -->

</div>

<%@ include file="footer.jsp"%>

<script type="text/javascript">
	jQuery(function($) {
		//editables on first profile page
		$.fn.editable.defaults.mode = 'inline';
		$.fn.editableform.loading = "<div class='editableform-loading'><i class='light-blue icon-2x icon-spinner icon-spin'></i></div>";
		$.fn.editableform.buttons = '<button type="submit" class="btn btn-info editable-submit"><i class="icon-ok icon-white"></i></button>'
				+ '<button type="button" class="btn editable-cancel"><i class="icon-remove"></i></button>';

		var sex_value = [];
		$.each({
			"male" : "男",
			"female" : "女"
		}, function(k, v) {
			sex_value.push({
				id : k,
				text : v
			});
		});

		$('#sex').editable({
			type : 'select2',
			value : '男',
			name : 'sex',
			source : sex_value
		});

		$('#phone_num').editable({
			type : 'text',
			name : 'phone_num',
		});

		$('#email').editable({
			type : 'text',
			name : 'email',
		});

		// *** editable avatar *** //
		try {//ie8 throws some harmless exception, so let's catch it

			//it seems that editable plugin calls appendChild, and as Image doesn't have it, it causes errors on IE at unpredicted points
			//so let's have a fake appendChild for it!
			if (/msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()))
				Image.prototype.appendChild = function(el) {
				}

			var last_gritter
			$('#avatar')
					.editable(
							{
								type : 'image',
								name : 'avatar',
								value : null,
								image : {
									//specify ace file input plugin's options here
									btn_choose : '更换头像',
									droppable : true,
									/**
									//this will override the default before_change that only accepts image files
									before_change: function(files, dropped) {
										return true;
									},
									 */

									//and a few extra ones here
									name : 'avatar',//put the field name here as well, will be used inside the custom plugin
									max_size : 110000,//~100Kb
									on_error : function(code) {//on_error function will be called when the selected file has a problem
										if (last_gritter)
											$.gritter.remove(last_gritter);
										if (code == 1) {//file format error
											last_gritter = $.gritter
													.add({
														title : 'File is not an image!',
														text : 'Please choose a jpg|gif|png image!',
														class_name : 'gritter-error gritter-center'
													});
										} else if (code == 2) {//file size rror
											last_gritter = $.gritter
													.add({
														title : 'File too big!',
														text : 'Image size should not exceed 100Kb!',
														class_name : 'gritter-error gritter-center'
													});
										} else {//other error
										}
									},
									on_success : function() {
										$.gritter.removeAll();
									}
								},
								url : function(params) {
									// ***UPDATE AVATAR HERE*** //
									//You can replace the contents of this function with examples/profile-avatar-update.js for actual upload

									var deferred = new $.Deferred

									//if value is empty, means no valid files were selected
									//but it may still be submitted by the plugin, because "" (empty string) is different from previous non-empty value whatever it was
									//so we return just here to prevent problems
									var value = $('#avatar').next().find(
											'input[type=hidden]:eq(0)').val();
									if (!value || value.length == 0) {
										deferred.resolve();
										return deferred.promise();
									}

									//dummy upload
									setTimeout(
											function() {
												var thumb = null;
												if ("FileReader" in window) {
													//for browsers that have a thumbnail of selected image
													thumb = $('#avatar')
															.next().find('img')
															.data('thumb');
													if (thumb){
														 $('#avatar').get(0).src = thumb;
													}
													
												}

												deferred.resolve({
													'status' : 'OK'
												});

												if (last_gritter)
													$.gritter.remove(last_gritter);
												
												last_gritter = $.gritter
														.add({
															title : '头像已更新!',
															text : 'Uploading successfully.',
															class_name : 'gritter-info gritter-center'
														});
												

											},
											parseInt(Math.random() * 800 + 800))

									return deferred.promise();
								},

								success : function(response, newValue) {
								}
							})
		} catch (e) {
		}

		////////////////////
		//change profile
		$('[data-toggle="buttons"] .btn').on('click', function(e) {
			var target = $(this).find('input[type=radio]');
			var which = parseInt(target.val());
			$('.user-profile').parent().addClass('hide');
			$('#user-profile-' + which).parent().removeClass('hide');
		});
		
		// 开启聊天窗口
		var receiver_id = ${target_user_info.user_id};
		$('#show_chatting_room_btn').on('click', function(){
			window.open('/ClassManagement/user/chatting?receiver_id='+receiver_id, 'newwindow', 
					'height=420px, width=600px, top=200px, left=400px, toolbar=no, menubar=no, scrollbars=no, resizable=true, location=no, status=no');
		});
		
		$('#save_profile').on('click', function(){
			var sex = document.getElementById("sex").innerHTML;
			var phone_num = document.getElementById("phone_num").innerHTML;
			var email = document.getElementById("email").innerHTML;
			$.ajax({
				url:'/ClassManagement/user/updateProfile',
				data:{sex:sex, phone_num:phone_num, email:email},
				type:'post',
				dataType:'json',
				success: function(r){
					if(r){
						$('#save_profile').attr('disabled', 'true');
						alert("信息更新成功");
					}
					else{
						alert("信息更新失败");
					}
				}
			})
		});
		
		$('.editable').click(function(){
			$('#save_profile').removeAttr('disabled');
		});
	})
</script>
