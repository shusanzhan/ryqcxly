<%@page import="com.ystech.cust.model.CustomerImage"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="description" content="Common Buttons &amp; Icons" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

	<!-- bootstrap & fontawesome -->
	<link rel="stylesheet" href="${ctx}/assets/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${ctx}/assets/css/font-awesome.min.css" />
	<!-- page specific plugin styles -->
	<!-- text fonts -->
	<link rel="stylesheet" href="${ctx}/assets/css/ace-fonts.css" />
	<!-- ace styles -->
	<link rel="stylesheet" href="${ctx}/assets/css/ace.min.css" id="main-ace-style" />

	<!--[if lte IE 9]>
		<link rel="stylesheet" href="${ctx}/assets/css/ace-part2.min.css" />
	<![endif]-->
	<link rel="stylesheet" href="${ctx}/assets/css/ace-skins.min.css" />
	<link rel="stylesheet" href="${ctx}/assets/css/ace-rtl.min.css" />

	<!--[if lte IE 9]>
	  <link rel="stylesheet" href="${ctx}/assets/css/ace-ie.min.css" />
	<![endif]-->

	<!-- inline styles related to this page -->

	<!-- ace settings handler -->
	<script src="${ctx}/assets/js/ace-extra.min.js"></script>

	<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

	<!--[if lte IE 8]>
	<script src="${ctx}/assets/js/html5shiv.min.js"></script>
	<script src="${ctx}/assets/js/respond.min.js"></script>
	<![endif]-->
</head>
<title>客户资料</title>
</head>
<body class="bodycolor">
	<div class="page-content">

					<!-- /section:settings.box -->
					<div class="page-content-area">
						<div class="page-header">
							<h1>
								${insCustomer.name }资料明细
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<div>
									<div class="user-profile row" id="user-profile-1">
										<div class="col-xs-12 col-sm-3 center">
											<div>
												<!-- #section:pages/profile.picture -->
												<span class="profile-picture">
													<%
														CustomerImage custImg=(CustomerImage)request.getAttribute("customerImage");
												        if(null!=custImg){
															StringBuffer fi=new StringBuffer();
															fi.append("<img src='/customerImage.jpg?imgPath="+URLEncoder.encode(URLEncoder.encode(custImg.getUrl(), "UTF-8"),"UTF-8")+"&date="+DateUtil.format2(new Date())+"' alt=\"\" class=\"editable img-responsive editable-click editable-empty\" id=\"avatar\">");
																fi.append("");
															fi.append("</img>");
															out.println(fi.toString());
												        }else{
															StringBuffer fi=new StringBuffer();
															fi.append("<img src=\"../assets/avatars/profile-pic.jpg\" alt=\"\" class=\"editable img-responsive editable-click editable-empty\" id=\"avatar\">");
																fi.append("");
															fi.append("</img>");
															out.println(fi.toString());
												        }
													%>
													
												</span>

												<!-- /section:pages/profile.picture -->
												<div class="space-4"></div>

												<div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
													<div class="inline ">
														<a data-toggle="dropdown" class="user-title-label dropdown-toggle" href="#">
															<c:if test="${insCustomer.buyInsuranceStatus==1 }">
																<i class="ace-icon fa fa-circle light-green"></i>
															</c:if>
															<c:if test="${insCustomer.buyInsuranceStatus==2 }">
																<i class="ace-icon fa fa-circle red"></i>
															</c:if>
															<c:if test="${insCustomer.buyInsuranceStatus==3 }">
																<i class="ace-icon fa fa-circle grey"></i>
															</c:if>
															&nbsp;
															<span class="white">${insCustomer.name }</span>
														</a>
													</div>
												</div>
											</div>

											<div class="space-6"></div>

											<!-- #section:pages/profile.contact -->
											<div class="profile-contact-info">
												<div class="profile-contact-links align-left">
													<a class="btn btn-link" href="javascript:void(-1)" onclick="window.location.href='${ctx }/insuranceRecord/add?dbid=${insCustomer.dbid}'">
														<i class="ace-icon fa fa-plus-circle bigger-120 green"></i>
														购买保险&#12288;&#12288;&#12288;&#12288;
													</a>
													<c:if test="${insCustomer.buyInsuranceStatus==3 }">
													<a class="btn btn-link" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/insCustomer/outFlowDetail?dbid=${insCustomer.dbid }','流失原因',760,440)">
														<i class="ace-icon fa fa-envelope bigger-120 pink"></i>
														查看流失原因
													</a>
							                        </c:if>
													<a class="btn btn-link" href="${ctx }/insuranceRecord/historyDetail?customerId=${insCustomer.dbid}">
														<i class="ace-icon fa fa-globe bigger-125 blue"></i>
														购买历史记录
													</a>
												</div>

												<div class="space-6"></div>

											</div>


										</div>

										<div class="col-xs-12 col-sm-9">
											<div class="center">
												<span class="btn btn-app btn-sm btn-primary no-hover" style="width: 120px; padding: 12px 8px;">
													<span class="line-height-1 bigger-170"> ${insCustomer.historyBuyNum } </span>

													<br>
													<span class="line-height-1 smaller-90"> 购买次数 </span>
												</span>

												<span class="btn btn-app btn-sm btn-yellow no-hover" style="width: 120px; padding: 12px 8px;">
													<span class="line-height-1 bigger-170"> ${insCustomer.historyBuyMoney }</span>
													<br>
													<span class="line-height-1 smaller-90"> 购买总金额 </span>
												</span>

												<span class="btn btn-app btn-sm btn-pink no-hover" style="width: 120px; padding: 12px 8px;">
													<span class="line-height-1 bigger-170" style=""> ${customer.orderContract.totalPrice } </span>
													<br>
													<span class="line-height-1 smaller-90">合同金额 </span>
												</span>
												<a href="javascript:void(-1)" onclick="window.history.go(-1)" class="btn btn-app btn-sm btn-success no-hover">
													<i class="ace-icon fa fa-arrow-left bigger-170"></i>
													<span class="line-height-1 smaller-90">返回 </span>
												</a>
											</div>

											<div class="space-12"></div>

											<!-- #section:pages/profile.info -->
											<div class="profile-user-info profile-user-info-striped">
												<div class="profile-info-row">
													<div class="profile-info-name"> 姓名 </div>

													<div class="profile-info-value">
														<span id="username" class="editable editable-click">${insCustomer.name }</span>
													</div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name"> 联系电话 </div>

													<div class="profile-info-value">
														<span id="username" class="editable editable-click">${insCustomer.mobilePhone }</span>
													</div>
												</div>

												<div class="profile-info-row">
													<div class="profile-info-name"> 地址 </div>

													<div class="profile-info-value">
														<i class="fa fa-map-marker light-orange bigger-110"></i>
														<span id="country" class="editable editable-click">
															${customer.area.fullName }${customer.address }
														</span>
													</div>
												</div>

												<div class="profile-info-row">
													<div class="profile-info-name"> 年龄 </div>

													<div class="profile-info-value">
														<span id="age" class="editable editable-click">${customer.age }</span>
													</div>
												</div>

												<div class="profile-info-row">
													<div class="profile-info-name"> 生日 </div>

													<div class="profile-info-value">
														<span id="signup" class="editable editable-click">
															<fmt:formatDate value="${customer.nbirthday }"/>(农历)
														</span>
													</div>
												</div>

												<div class="profile-info-row">
													<div class="profile-info-name"> 车型 </div>
													<div class="profile-info-value">
														<span id="login" class="editable editable-click">
															${insCustomer.brand.name }
															${insCustomer.carseriy.name }
															${insCustomer.carModel.name } 
														</span>
													</div>
												</div>

												<div class="profile-info-row">
													<div class="profile-info-name"> vin码 </div>
													<div class="profile-info-value">
														<span id="about" class="editable editable-click">
															${insCustomer.vinCode }
														</span>
													</div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name"> 销售顾问 </div>
													<div class="profile-info-value">
														<span id="about" class="editable editable-click">
															${insCustomer.salerName }
														</span>
													</div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name"> 登记时间 </div>
													<div class="profile-info-value">
														<span id="about" class="editable editable-click">
															${insCustomer.recordDate }
														</span>
													</div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name"> 保单时间 </div>
													<div class="profile-info-value">
														<span id="about" class="editable editable-click">
															${insCustomer.beginDate }~${insCustomer.endDate }
														</span>
													</div>
												</div>
											</div>

											<!-- /section:pages/profile.info -->
											<div class="space-20"></div>

											<div class="widget-box transparent">
												<div class="widget-header widget-header-small">
													<h4 class="widget-title blue smaller">
														<i class="ace-icon fa fa-rss orange"></i>
														购买历史
													</h4>

													<div class="widget-toolbar action-buttons">
													</div>
												</div>
												<div class="widget-body">
													<div class="widget-main padding-8">
														<!-- #section:pages/profile.feed -->
														<div class="profile-feed ace-scroll scroll-active" id="profile-feed-1" style="height: auto;">
														<div class="scroll-track" style="display: block; height: 200px;">
														<div class="scroll-bar" style="height: 62px; top: 0px;"></div>
														</div>
														<div class="scroll-content">
															<c:if test="${insCustomer.historyBuyNum>0 }">
																<c:forEach var="insuranceRecord" items="${insuranceRecords }">
																	<div class="profile-activity clearfix">
																		<div>
																			<a href="${ctx }/insuranceRecord/insuranceRecordDetail?dbid=${insuranceRecord.dbid }" class="user"> 明细 </a>
																				${insuranceRecord.strongRisk }
																				${insuranceRecord.busiRisk }
																			<div class="time">
																				<i class="ace-icon fa fa-clock-o bigger-110"></i>
																				${insuranceRecord.beginDate }~
																				${insuranceRecord.endDate }
																			</div>
																		</div>
		
																		<!-- <div class="tools action-buttons">
																			<a class="blue" href="#">
																				<i class="ace-icon fa fa-pencil bigger-125"></i>
																			</a>
		
																			<a class="red" href="#">
																				<i class="ace-icon fa fa-times bigger-125"></i>
																			</a>
																		</div> -->
																	</div>
																</c:forEach>
															</c:if>
															<c:if test="${insCustomer.historyBuyNum<=0 }">
																<div class="profile-activity clearfix">
																	<div>
																		<a href="#" class="user">无购买记录</a>
																	</div>
	
																</div>
															</c:if>
														
														</div>

														<!-- /section:pages/profile.feed -->
													</div>
												</div>
											</div>



										</div>
									</div>
								</div>
								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
					</div><!-- /.page-content-area -->
				</div>
</body>
<script type="text/javascript">
window.jQuery || document.write("<script src='${ctx}/assets/js/jquery.min.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${ctx}/assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
if('ontouchstart' in document.documentElement) document.write("<script src='${ctx}/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="${ctx}/assets/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${ctx}/assets/js/ace-elements.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script src="${ctx}/assets/js/ace.min.js"></script>
<!-- the following scripts are used in demo only for onpage help and you don't need them -->
<link rel="stylesheet" href="${ctx}/assets/css/ace.onpage-help.css" />
<script type="text/javascript"> ace.vars['base'] = '..'; </script>
<script src="${ctx}/assets/js/ace/elements.onpage-help.js"></script>
<script src="${ctx}/assets/js/ace/ace.onpage-help.js"></script>
</html>