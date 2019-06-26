<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>客户跟踪信息</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/fullcalendar.css" />	
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css" class="skin-color" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
.aeditCust{
    color: #08c;
    text-decoration: none;
}
.aeditCust:HOVER {
	  color: #08c;
    text-decoration: none;
}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户跟踪信息</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/customerTrack/dayCustomerTrack'">今日需回访客户</a> --%>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerTrack/queryRoomManageList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input class="small text" id="userName" name="userName"  value="${param.userName }" >
  				</td>
  				<td><label>客户名称：</label></td>
  				<td>
  					<input class="small text" id="name" name="name"  value="${param.name }" >
				</td>
  				<td><label>电话号码：</label></td>
  				<td>
  					<input class="small text" id="phone" name="phone"  value="${param.phone}" >
				</td>
  				<td><label>意向级别：</label></td>
  				<td>
  					<select id="customerPhaseId" name="customerPhaseId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
								<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
						</c:forEach>
					</select>
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 60px;">名称</td>
			<td style="width: 140px;">车系</td>
			<td style="width: 60px;">创建日期</td>
			<td style="width: 60px;">级别(前/后)</td>
			<td style="width:80px;">超时状态</td>
			<td style="width:80px;">超时天数</td>
			<td style="width:80px;">创建时间</td>
			<td style="width:80px;">销售顾问</td>
			<td style="width:80px;">总回访次数</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customerTrack">
		<c:set value="${customerTrack.customer }" var="customer"></c:set>
		<tr>
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
						${customer.name }<br>
						${customer.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/edit?dbid=${customer.dbid}&parentMenu=1'">编辑明细</a></li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerTrack/add?customerId=${customer.dbid }','添加跟进记录',900,500)">添加跟进记录</a> </li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name} ${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}">
				${customer.customerBussi.brand.name}${carModel}  ${customer.carModelStr}
			</td>
			<td>
				<fmt:formatDate value="${customerTrack.finishDate}" pattern="yyyy-MM-dd hh:mm"/>
			</td>
			<td>
				${customerTrack.beforeCustomerPhase.name}
				/
				${customerTrack.beforeCustomerPhase.name}
			</td>
			<td>
				<c:if test="${customerTrack.taskOverTimeStatus==1 }">
					<span style="color: green">未超时</span>
				</c:if>
				<c:if test="${customerTrack.taskOverTimeStatus==2 }">
					<span style="color: red">已超时</span>
				</c:if>
			</td>
			<td>
				${customerTrack.taskOverTimeNum }
			</td>
			<td>
				<fmt:formatDate value="${customerTrack.createTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				${customer.bussiStaff }<br>
				${customer.department.name }
			</td>
			<td>
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerTrack/personCustomerTrackRecord?customerId=${customer.dbid}&redirect=3'">${customer.trackNum }</a>  
			</td>
			<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerTrack/view?dbid=${customerTrack.dbid}&type=1','查看跟进记录',900,500)">查看</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<div style="clear: both;"></div>
<div class="row-fluid" style="margin-top: -20px;">
	<div class="span6" >
		<div class="widget-box">
			<div class="widget-title"><span class="icon"><i class="icon-comment"></i></span><h5>待批示回访记录</h5><span class="label label-info tip-left" data-original-title="${waitingReadNum } 在线预约客户">${waitingReadNum }</span></div>
			<div class="widget-content nopadding">
				<ul class="recent-comments">
				<c:if test="${empty(customerTracks) }">
				<li>
						<div class="comments">
							<p>
								无待审批流失客户...
							</p>
						</div>
					</li>
				</c:if>
				  <c:forEach var="customerTrack"  items="${customerTracks }" end="8">
				  	<c:set value="${customerTrack.customer }" var="customer"></c:set>
					<li>
						<div class="comments" >
							<span class="user-info"> 
								客户:<a href="javascript:void(-1)"  onclick="$.utile.openDialog('${ctx}/customerTrack/readCustomerTrack?dbid=${customerTrack.dbid }','审阅跟进记录',1024,580)" class="aeditCust">${customer.name }（${customer.sex }） </a> &nbsp;&nbsp;&nbsp;&nbsp;
								联系电话号：<span style="color: red;">${customer.mobilePhone }</span>
								意向级别：${customer.customerPhase.name}&nbsp;&nbsp;<br>
								意向车型：${customer.customerBussi.brand.name}
								<c:set value="${customer.customerBussi.carSeriy.name} ${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
								${carModel}  ${customer.carModelStr}<br>
								级别(前/后)	：
								${customerTrack.beforeCustomerPhase.name}
								/
								${customerTrack.beforeCustomerPhase.name}
								<br>
								超时状态:<c:if test="${customerTrack.taskOverTimeStatus==1 }">
									<span style="color: green">未超时</span>
								</c:if>
								<c:if test="${customerTrack.taskOverTimeStatus==2 }">
									<span style="color: red">已超时</span>
								</c:if>
								<br>
								超时天数：${customerTrack.taskOverTimeNum }
						   </span>
							<p>
								回访时间:<fmt:formatDate value="${customerTrack.finishDate }" pattern="yyyy-MM-dd HH:mm"/>
								&nbsp;&nbsp;&nbsp;&nbsp;
								销售顾问：${customer.bussiStaff }
							</p>
						</div>
					</li>
				</c:forEach> 
					<li class="viewall">
						<a href="${ctx }/customerTrack/watingReadCustomerTrack" class="tip-top" data-original-title="View all comments"> 点击查看更多 </a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="span6" style="margin-top: -20px;">
		<div class="widget-box">
			<div class="widget-title"><span class="icon"><i class="icon-comment"></i></span><h5>今日需回访记录</h5><span class="label label-info tip-left" data-original-title="${fn:length(todayCustomerTracks) } 今日需回访客户">${fn:length(todayCustomerTracks) }</span></div>
			<div class="widget-content nopadding">
				<ul class="recent-comments">
				<c:if test="${empty(todayCustomerTracks) }">
					<li>
						<div class="comments">
							<p>
								今日无回访客户...
							</p>
						</div>
					</li>
				</c:if>
				<c:forEach var="customerTrack"  items="${todayCustomerTracks }" end="8">
					  	<c:set value="${customerTrack.customer }" var="customer"></c:set>
						<li>
							<div class="comments">
								<span class="user-info"> 
									客户:<a href="javascript:void(-1)"  onclick="window.location.href='/customerTrack/personCustomerTrackRecord?customerId=${customer.dbid}&redirect=3'" class="aeditCust">${customer.name }（${customer.sex }） </a> &nbsp;&nbsp;&nbsp;&nbsp;
									联系电话号：<span style="color: red;">${customer.mobilePhone }</span>
									意向级别：${customer.customerPhase.name}&nbsp;&nbsp;<br>
									意向车型：${customer.customerBussi.brand.name}
									<c:set value="${customer.customerBussi.carSeriy.name} ${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
									${carModel}  ${customer.carModelStr}<br>
									<br>
									到期回访日:<fmt:formatDate value="${customerTrack.nextReservationTime}" pattern="yyyy-MM-dd hh:mm"/>
									<br>
									超时状态:<c:if test="${customerTrack.taskOverTimeStatus==1 }">
										<span style="color: green">未超时</span>
									</c:if>
									<c:if test="${customerTrack.taskOverTimeStatus==2 }">
										<span style="color: red">已超时</span>
									</c:if>
									<br>
									超时天数：${customerTrack.taskOverTimeNum }
							   </span>
								<p>
									创建时间:<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
									&nbsp;&nbsp;&nbsp;&nbsp;
									销售顾问：${customer.bussiStaff }
								</p>
							</div>
						</li>
					</c:forEach> 
					<li class="viewall">
						<a href="${ctx }/customerTrack/dayRoomManageCustomerTrack" class="tip-top" data-original-title="View all comments"> 点击查看更多 </a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
</script>
</html>
