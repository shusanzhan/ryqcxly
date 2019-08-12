<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>客户管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户管理</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="operator('${ctx }/custCustomer/handerOverCar')">交车确认单</a>
		<a class="but button" href="javascript:void();" onclick="window.open('${ctx }/custCustomer/testDriveAgreement')">客户综合信息</a>
		<a href="javascript:void(-1)" class="but button" onclick="window.open('${ctx }/custCustomer/customerFolder')">意向跟踪卡</a> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/custCustomer/customerShoppingRecordqueryList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>意向级别：</label></td>
  				<td>
  					<select class="text midea" id="customerPhaseId" name="customerPhaseId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
							<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text midea" value="${param.mobilePhone}"></input></td>
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
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 60px;">编号</td>
			<td style="width: 100px;">名称</td>
			<td style="width: 100px;">意向级别</td>
			<td style="width: 100px;">常用手机号</td>
			<td style="width: 80px;">EMAIL</td>
			<td style="width:80px;">购车时间</td>
			<td style="width: 80px;">业务员</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 120px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td>
			<td>${customer.sn }</td>
			<td>
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
					</c:if>
			</td>
			<td>
				${customer.customerPhase.name}
			</td>
			<td>
				${customer.mobilePhone}
			</td>
			<td>
				${customer.email}
			</td>
			<td>${customer.bussiStaff }</td>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }"/>
			</td>
			<td style="text-align: center;">
			<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/add?customerId=${customer.dbid }'">交车预约</a> | 
			<a href="javascript:void(-1)" class="aedit" onclick="alert('提交订单功能正在开发中.....')">添加客户跟踪</a>| 
			 <%-- 
			<br> 
			<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerPidBookingRecord/add?customerId=${customer.dbid }','',900,520)">试驾协议</a> | 
			<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerLastBussi/add?customerId=${customer.dbid }','添加跟进记录',900,500)">成交结果</a> | 
			<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/custCustomer/delete?dbids=${customer.dbid}','searchPageForm')" title="删除">删除</a></td> --%>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>
