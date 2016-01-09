<%@ include file="header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href='<c:url value="/css/fullcalendar.css"></c:url>'
	rel="stylesheet" />
<div class="main-content">
	<div class="breadcrumbs" id="breadcrumbs">
		<script type="text/javascript">
			try {
				ace.settings.check('breadcrumbs', 'fixed')
			} catch (e) {
			}
		</script>

		<ul class="breadcrumb">
			<li><i class="icon-calendar"></i> <a href="/ClassManagement/index/calendar">日历</a></li>
			<li class="active" id="currentDate">详情</li>
		</ul>
		<!-- .breadcrumb -->

		<div class="nav-search" id="nav-search">
			<form class="form-search">
				<span class="input-icon"> <input type="text"
					placeholder="Search ..." class="nav-search-input"
					id="nav-search-input" autocomplete="off"> <i
					class="icon-search nav-search-icon"></i>
				</span>
			</form>
		</div>
		<!-- #nav-search -->
	</div>

	<div class="page-content">
		<div class="page-header">
			<h1 style="font-size: 20px; color: #d15b47 !important;">
				当前日期与事项 
				<small> 
					<i class="icon-double-angle-right"></i> 
					Current Date & Affair 
				</small>
			</h1>
		</div>
		<!-- /.page-header -->

		<div class="row">
			<div class="col-xs-12" style="width: 100%;">
				<!-- PAGE CONTENT BEGINS -->

				<div class="row">
					<div class="col-sm-9">
						<div class="space"></div>

						<div id="calendar" class="fc fc-ltr"></div>
					</div>

					<div class="col-sm-3">
						<div class="widget-box transparent">
							<div class="widget-header">
								<h4>Draggable events</h4>
							</div>

							<div class="widget-body">
								<div class="widget-main no-padding">
									<div id="external-events">
										<div class="external-event label-grey ui-draggable"
											data-class="label-grey" style="position: relative;">
											<i class="icon-move"></i> My Event 1
										</div>

										<div class="external-event label-success ui-draggable"
											data-class="label-success" style="position: relative;">
											<i class="icon-move"></i> My Event 2
										</div>

										<div class="external-event label-danger ui-draggable"
											data-class="label-danger" style="position: relative;">
											<i class="icon-move"></i> My Event 3
										</div>

										<div class="external-event label-purple ui-draggable"
											data-class="label-purple" style="position: relative;">
											<i class="icon-move"></i> My Event 4
										</div>

										<div class="external-event label-yellow ui-draggable"
											data-class="label-yellow" style="position: relative;">
											<i class="icon-move"></i> My Event 5
										</div>

										<div class="external-event label-pink ui-draggable"
											data-class="label-pink" style="position: relative;">
											<i class="icon-move"></i> My Event 6
										</div>

										<div class="external-event label-info ui-draggable"
											data-class="label-info" style="position: relative;">
											<i class="icon-move"></i> My Event 7
										</div>

										<label> <input type="checkbox"
											class="ace ace-checkbox" id="drop-remove"> <span
											class="lbl"> Remove after drop</span>
										</label>
									</div>
								</div>
							</div>
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

<%@ include file="footer.jsp"%>
<script src='<c:url value="/js/fullcalendar.min.js"></c:url>'></script>
<script type="text/javascript">
	jQuery(function($) {
		/* initialize the calendar
		 -----------------------------------------------------------------*/

		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();

		var calendar = $('#calendar')
				.fullCalendar(
						{
							buttonText : {
								prev : '<i class="icon-chevron-left"></i>',
								next : '<i class="icon-chevron-right"></i>'
							},

							header : {
								left : 'prev,next today',
								center : 'title',
								right : 'month,agendaWeek,agendaDay'
							},
							events : [ {
								title : 'All Day Event',
								start : new Date(y, m, 1),
								className : 'label-important'
							}, {
								title : 'Long Event',
								start : new Date(y, m, d - 5),
								end : new Date(y, m, d - 2),
								className : 'label-success'
							}, {
								title : 'Some Event',
								start : new Date(y, m, d - 3, 16, 0),
								allDay : false
							} ],
							editable : true,
							droppable : true, // this allows things to be dropped onto the calendar !!!
							drop : function(date, allDay) { // this function is called when something is dropped

								// retrieve the dropped element's stored Event Object
								var originalEventObject = $(this).data(
										'eventObject');
								var $extraEventClass = $(this).attr(
										'data-class');

								// we need to copy it, so that multiple events don't have a reference to the same object
								var copiedEventObject = $.extend({},
										originalEventObject);

								// assign it the date that was reported
								copiedEventObject.start = date;
								copiedEventObject.allDay = allDay;
								if ($extraEventClass)
									copiedEventObject['className'] = [ $extraEventClass ];

								// render the event on the calendar
								// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
								$('#calendar').fullCalendar('renderEvent',
										copiedEventObject, true);

								// is the "remove after drop" checkbox checked?
								if ($('#drop-remove').is(':checked')) {
									// if so, remove the element from the "Draggable Events" list
									$(this).remove();
								}

							},
							selectable : true,
							selectHelper : true,
							select : function(start, end, allDay) {

								bootbox.prompt("New Event Title:", function(
										title) {
									if (title !== null) {
										calendar.fullCalendar('renderEvent', {
											title : title,
											start : start,
											end : end,
											allDay : allDay
										}, true // make the event "stick"
										);
									}
								});

								calendar.fullCalendar('unselect');

							},
							eventClick : function(calEvent, jsEvent, view) {

								var form = $("<form class='form-inline'><label>Change event name &nbsp;</label></form>");
								form
										.append("<input class='middle' autocomplete=off type=text value='" + calEvent.title + "' /> ");
								form
										.append("<button type='submit' class='btn btn-sm btn-success'><i class='icon-ok'></i> Save</button>");

								var div = bootbox
										.dialog({
											message : form,

											buttons : {
												"delete" : {
													"label" : "<i class='icon-trash'></i> Delete Event",
													"className" : "btn-sm btn-danger",
													"callback" : function() {
														calendar
																.fullCalendar(
																		'removeEvents',
																		function(
																				ev) {
																			return (ev._id == calEvent._id);
																		})
													}
												},
												"close" : {
													"label" : "<i class='icon-remove'></i> Close",
													"className" : "btn-sm"
												}
											}

										});

								form.on('submit', function() {
									calEvent.title = form.find(
											"input[type=text]").val();
									calendar.fullCalendar('updateEvent',
											calEvent);
									div.modal("hide");
									return false;
								});
							}

						});
	})
</script>