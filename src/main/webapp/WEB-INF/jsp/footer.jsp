<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<div class="ace-settings-container" id="ace-settings-container">
					<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
						<i class="icon-cog bigger-150"></i>
					</div>

					<div class="ace-settings-box" id="ace-settings-box">
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

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
							<label class="lbl" for="ace-settings-navbar">固定导航条</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
							<label class="lbl" for="ace-settings-sidebar">固定滑动条</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
							<label class="lbl" for="ace-settings-rtl">切换到左边</label>
						</div>

						<div>
							<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
							<label class="lbl" for="ace-settings-add-container">切换窄屏</label>
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
</body>
</html>
