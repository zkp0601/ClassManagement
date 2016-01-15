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
			<li><i class="icon-home home-icon"></i> <a href="#">Home</a></li>

			<li><a href="#">Other Pages</a></li>
			<li class="active">Error 404</li>
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
			<div class="col-xs-12" style="width: 97%;">
				<!-- PAGE CONTENT BEGINS -->

				<div class="error-container">
					<div class="well">
						<h1 class="grey lighter smaller">
							<span class="blue bigger-125"> <i class="icon-meh"></i>
								404
							</span> Page Not Found
						</h1>

						<hr />
						<h3 class="lighter smaller">We looked everywhere but we
							couldn't find it!</h3>

						<div style="font-text: center;">
							<form class="form-search">
								<span class="input-icon align-middle"> <i
									class="icon-search"></i> <input type="text"
									class="search-query" placeholder="Give it a search..." />
								</span>
								<button class="btn btn-sm" onclick="return false;">Go!</button>
							</form>

							<div class="space"></div>
							<h4 class="smaller">You can try one of the following:</h4>

							<ul class="list-unstyled spaced inline bigger-110 margin-15">
								<li><span>✅</span> Re-check the url for searching</li>

								<li><span>✅</span> Read the FAQ</li>

								<li><span>✅</span> Tell us about it</li>
							</ul>
						</div>

						<hr />
						<div class="space"></div>

						<div class="center">
							<a href="/ClassManagement" class="btn btn-danger"> <i
								class="icon-arrow-left"></i> 返回首页
							</a>
						</div>
					</div>
				</div>
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