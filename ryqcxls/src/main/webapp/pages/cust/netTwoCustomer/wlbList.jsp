<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车料调配管理</title>
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
	<a href="javascript:void(-1);" onclick="">车辆调配管理</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="operatorLocation('${ctx }/customerFile/printKhb')">客户档案</a> --%>
	   <a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/paymentConfirmation/printPaymentConfirmation')">打印交款确认单</a>
	   <a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/decoreNotice/printDecoreNotice')">打印附加通知单</a>
   </div>
  	<div class="seracrhOperate" style="margin-top: 20px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerPidBookingRecord/queryWlbWatingList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="text small" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text small" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<select id="userId" name="userId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="user" items="${users }">
							<option value="${user.dbid }" ${param.userId==user.dbid?'selected="selected"':'' } >${user.realName }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>处理状态：</label></td>
  				<td>
  					<select id="wlStatus" name="wlStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.wlStatus==1?'selected="selected"':''  }>等待物流部处理</option>
						<option value="2" ${param.wlStatus==2?'selected="selected"':''  }>物流部已处理</option>
					</select>
  				</td>
  				<td><label>车源状态：</label></td>
  				<td>
  					<select id="hasCarOrder" name="hasCarOrder"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.hasCarOrder==1?'selected="selected"':''  }>现车订单</option>
						<option value="2" ${param.hasCarOrder==2?'selected="selected"':''  }>在途订单</option>
						<option value="3" ${param.hasCarOrder==3?'selected="selected"':''  }>无车订单</option>
					</select>
  				</td>
  				<td><label>名称：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  				<td><label>车架号：</label></td>
  				<td><input type="text" id="vinCode" name="vinCode" class="text small" value="${param.vinCode}"></input></td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 50px;">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="margin-top: 50px;">
	<thead>
		<tr>
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 60px;">姓名</td>
			<td style="width:140px;">车型</td>
			<td style="width:60px;">指导价</td>
			<td style="width:80px;">车架号</td>
			<td style="width:60px;">颜色</td>
			<td style="width: 60px;">部门</td>
			<td style="width: 60px;">业务员</td>
			<td style="width: 60px;">车源状态</td>
			<td style="width: 80px;">合同状态</td>
			<td style="width: 80px;">处理状态</td>
			<td style="width: 100px;">创建日期</td>
			<td style="width: 100px;">最后更改时间</td>
			<td style="width: 100px;">处理时间</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td>
			<td>
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
					</c:if>
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					     <ul>
					      <li><a class="drop_down_menu_active" href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/printContract?dbid=${customer.orderContract.dbid }&type=1')">查看合同</a> </li>
					       <c:if test="${(customer.customerPidBookingRecord.pidStatus==1&&customer.customerPidBookingRecord.wlStatus==2)||
					      		(customer.customerPidBookingRecord.pidStatus>=6&&customer.customerPidBookingRecord.wlStatus==2&&customer.customerPidBookingRecord.hasCarOrder==1)}">
					      	 <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/customerPidBookingRecord/customerFile?customerId=${customer.dbid }','searchPageForm','提示：确定将选择客户设置为成交归档客户吗？')">归档</a> </li>
					      </c:if>
					       <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}">
				<%-- <c:if test="${fn:length(carModel)>8 }" var="status">
					${fn:substring(carModel,0,8) }...
				</c:if>
				<c:if test="${ status==false}">
					
				</c:if> --%>
				${carModel}  ${customer.carModelStr}
			</td>
			<td>
				${customer.customerBussi.carModel.navPrice }
			</td>
			<td>
				${customer.customerPidBookingRecord.vinCode }
			</td>
			<td>
				<c:if test="${!empty(customer.customerPidBookingRecord.carColor) }">
					${customer.customerPidBookingRecord.carColor.name }	
				</c:if>
			</td>
			<td>${customer.department.name }</td>
			<td>
				${customer.bussiStaff}
			</td>
			<td>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==1 }">
					<span style="color: blue;">现车订单</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==2 }">
					<span style="color:green;">在途订单</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==3 }">
					<span style="color: red;">无车订单</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==1 }">
					<span style="color: blue">已打印合同</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==3 }">
					<span style="color: #DD9A4B;">等待销售副总审批</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
					<span style="color: #DD9A4B;">等待总经理审批</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
					<span style="color: blue;">总经理同意流失</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==6 }">
					<span style="color: red;">总经理驳回申请</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==7 }">
					<span style="color: red;">销售副总驳回申请</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==1 }">
					<span style="color: red;">等待处理</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
					<span style="color:blue;">已经处理</span>
				</c:if>
			</td>
			<td>
				<fmt:formatDate value="${customer.customerPidBookingRecord.createTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<fmt:formatDate value="${customer.customerPidBookingRecord.wlCreateTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td style="text-align: center;">
				<c:if test="${customer.customerPidBookingRecord.pidStatus==1}">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/wlbEdit?customerId=${customer.dbid }'">交车预约</a>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==6||customer.customerPidBookingRecord.pidStatus==7}">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/wlbEdit?customerId=${customer.dbid }'">交车预约</a>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==3 }">
					<span style="color: #DD9A4B;">合同流失等待审批</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/wlbEdit?customerId=${customer.dbid }'">交车预约</a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
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
