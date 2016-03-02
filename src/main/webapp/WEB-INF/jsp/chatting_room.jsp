<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html style="overflow: hidden;">
<head>
<link rel="stylesheet"
	href='<c:url value="/css/bootstrap.min.css"></c:url>' />
<link rel="stylesheet" href='<c:url value="/css/ace.min.css"></c:url>' />
<link rel="stylesheet"
	href='<c:url value="/css/fontawesome/font-awesome.min.css"></c:url>' />
</head>
<body style="background-color:#5A494E">
	<!-- 发起聊天弹出对话窗口 -->
	<div>
		<div class="col-sm-6">
			<div class="widget-box ">
				<div class="widget-header">
					<h4 class="lighter smaller">
						<i class="icon-comment blue"></i> 会话
					</h4>
				</div>

				<div class="widget-body">
					<div class="widget-main no-padding">
						<div class="slimScrollDiv"
							style="position: relative; overflow: hidden; width: auto; height: 300px;">
							<div class="dialogs" id="dialogs" style="overflow: hidden; width: auto; height: 300px; overflow: scroll;">
								
								<c:forEach items="${allMessages}" var="message">
									<div class="itemdiv dialogdiv">
										<div class="user">
											<c:choose>
												<c:when test="${message.sender_id==user.user_id}">
													<img alt="John's Avatar" src='<c:url value="${sender_info.img_url}"></c:url>'>
												</c:when>
												<c:otherwise>
													<img alt="John's Avatar" src='<c:url value="${receiver_info.img_url}"></c:url>'>
												</c:otherwise>
											</c:choose>
										</div>

										<div class="body" <c:if test="${message.sender_id==user.user_id}">style="background-color:#D1F9D1;"</c:if>>
											<div class="time">
												<i class="icon-time"></i> <span class="blue">${message.send_time}</span>
											</div>
	
											<div class="name">
												<c:choose>
													<c:when test="${message.sender_id==user.user_id}">
														<a href="#">${user.username}</a>
														<span class="label label-info arrowed arrowed-in-right">admin</span>
													</c:when>
													<c:otherwise> <a href="#">${receiver_name}</a> </c:otherwise>
												</c:choose>
											</div>
											<div class="text">${message.content}</div>
	
											<div class="tools">
												<a href="#" class="btn btn-minier btn-info"> <i
													class="icon-only icon-share-alt"></i>
												</a>
											</div>
										</div>
									</div>
								</c:forEach>
								<div style="text-align:center;color:gray;padding-bottom:10px;">无更多历史消息</div>
							</div>
							<div class="slimScrollBar ui-draggable"
								style="width: 7px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 252.809px; background: rgb(0, 0, 0);"></div>
							<div class="slimScrollRail"
								style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; opacity: 0.2; z-index: 90; right: 1px; background: rgb(51, 51, 51);"></div>
						</div>

						<form>
							<div class="form-actions">
								<div class="input-group">
									<input type="text" class="form-control" id="message" name="message" onkeydown="globleEvent(event);" autocomplete="off"/>
									<span class="input-group-btn">
										<button class="btn btn-sm btn-info no-radius" type="button" id="btn-sending" onClick="sendMessage()">
											<i class="icon-share-alt"></i> 
											发送
										</button>
										<button class="btn btn-sm btn-danger no-radius" onClick="close_window()" style="margin-left: 5px;">关闭</button>
									</span>
								</div>
							</div>
						</form>
					</div>
					<!-- /widget-main -->
				</div>
				<!-- /widget-body -->
			</div>
			<!-- /widget-box -->
		</div>
	</div>
	<script src='<c:url value="/js/jquery-2.0.3.min.js"></c:url>'></script>
	<script src='<c:url value="/js/jquery.slimscroll.min.js"></c:url>'></script>
	<script src='<c:url value="/js/jquery.mobile.custom.min.js"></c:url>'></script>
	<script src='<c:url value="/js/sockjs.min.js"></c:url>'></script>
	<script src='<c:url value="/js/jquery.json-2.4.min.js"></c:url>'></script>
	<script type="text/javascript">
		
		jQuery(function($) {
			$('.dialogs').slimScroll({
				height : '300px'
			});
			
			// 设置聊天框滑动条显示在最下面
			var dialogs = document.getElementById('dialogs');
			dialogs.scrollTop = dialogs.scrollHeight;
		})
		
		
		window.opener.ws.onmessage = function( event ){
			var message = $.parseJSON(event.data);
			var item = 
				'<div class="itemdiv dialogdiv">'+
					'<div class="user">' +
						'<img alt="John\'s Avatar" src=\'<c:url value="'+'${receiver_info.img_url}'+'"></c:url>\'>'+
					'</div>'+

					'<div class="body">'+
						'<div class="time">'+
							'<i class="icon-time"></i> <span class="blue">'+ message.send_time +'</span>'+
						'</div>'+
	
						'<div class="name">'+
							'<a href="#">'+ message.sender_username +'</a>'+
						'</div>'+
						'<div class="text">'+ message.content +'</div>'+
		
						'<div class="tools">'+
							'<a href="#" class="btn btn-minier btn-info">'+
								'<i class="icon-only icon-share-alt"></i>'+
							'</a>'+
						'</div>'+
					'</div>'+
				'</div>';
			$('.dialogs').append(item);
			// 设置聊天框滑动条显示在最下面
			var dialogs = document.getElementById('dialogs');
			dialogs.scrollTop = dialogs.scrollHeight; 
		}
		
		// 获取当前时间，格式 YYYY-MM-DD hh:mm:ss
		function getTime(){
			var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			
			var hour = date.getHours();
			var min = date.getMinutes();
			var sec = date.getSeconds();
			
			month = month < 10 ? ( "0" + month ) : month;
			day = day < 10 ? ( "0" + day ) : day;
			hour = hour < 10 ? ( "0" + hour ) : hour;
			min = min < 10 ? ( "0" + min ) : min;
			sec = sec < 10 ? ( "0" + sec ) : sec;
			
			var time = year + "-" + month + "-" + day + " " + hour + ":" + min + ":" + sec;
			return time;
		}
		
		// 获取url参数
		function getUrlParameters(){
			var url = location.search;
			var requestParams = new Object();
			
			if(url.indexOf("?") != -1){
				var str = url.substr(1);
				var param_array = str.split("&");
				for(var i = 0; i < param_array.length; i++){
					requestParams[param_array[i].split("=")[0]] = param_array[i].split("=")[1]
				}
			}
			return requestParams;
		}
		
		// 利用ajax去获取服务端的session值
		var message_sender_id = null;
		var message_receiver_id = null;
		var username = null;
		$.ajax({
			url: "/ClassManagement/user/getCurrentUserFromSession",
			data: {attribute:"currentUser"},
			type : 'post',
			dataType: 'json',
			async: false,
			success : function(r){
				if(r.user_id){
					message_sender_id = r.user_id;
					username = r.username;
				}
			}
		});
		
		/** 打开聊天窗口之后，将所有聊天记录设成已读 */
		var receiver_id = ${user.user_id};
		var requestParams = getUrlParameters();
		var sender_id = requestParams["receiver_id"];
		
		$.ajax({
			url: "/ClassManagement/message/updateUnreadStatus",
			data : {sender_id : sender_id, receiver_id : receiver_id},
			type:"post",
			
			success : function(){
				
			}
		});
		
		function sendMessage() {
			var message = new Object();
			message["content"] = document.getElementById('message').value;
			
			if(message["content"] == "")
				return;
				
			if(window.opener.ws != null){
				var requestParams = getUrlParameters();
				
				message["sender_id"] = message_sender_id;
				message["sender_username"] = username;
				message["receiver_id"] = requestParams["receiver_id"];
				message["send_time"] = getTime();
				// 将message变成json格式传输
				window.opener.ws.send($.toJSON(message));
				document.getElementById('message').value = "";
				
				var item = 
					'<div class="itemdiv dialogdiv">'+
						'<div class="user">' +
							'<img alt="John\'s Avatar" src=\'<c:url value="/'+'${sender_info.img_url}'+'"></c:url>\'>'+
						'</div>'+

						'<div class="body" style="background-color:#D1F9D1;">'+
							'<div class="time">'+
								'<i class="icon-time"></i> <span class="blue">'+ message["send_time"] +'</span>'+
							'</div>'+
		
							'<div class="name">'+
								'<a href="#">'+ message["sender_username"] +'</a>'+
								'<span class="label label-info arrowed arrowed-in-right">admin</span>'+
							'</div>'+
							'<div class="text">'+ message["content"]+'</div>'+
			
							'<div class="tools">'+
								'<a href="#" class="btn btn-minier btn-info">'+
									'<i class="icon-only icon-share-alt"></i>'+
								'</a>'+
							'</div>'+
						'</div>'+
					'</div>';
				$('.dialogs').append(item);
				// 设置聊天框滑动条显示在最下面
				var dialogs = document.getElementById('dialogs');
				dialogs.scrollTop = dialogs.scrollHeight; 
			}
			else{
				alert('消息发送失败.');  
			}
				
		}

		function close_window() {
			/* if (window.opener.ws != null) {
				window.opener.ws.close();
				window.opener.ws = null;
			} */
			window.open("about:blank","_self").close();
		}
		
		function globleEvent(e){
			e = window.event || e;
			if((e.keyCode || e.which) == 13){
				e.preventDefault();
				document.getElementById("btn-sending").click();	
			}
		}

	</script>
</body>
</html>