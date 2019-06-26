<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>工厂返利收银</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">工厂车辆返利明细</a>
</div>
 <!--location end-->
<div class="line"></div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/rebateManagement/queryCashierList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text middle">
  				</td>
  				<td><label>收银人：</label></td>
  				<td>
  					<input type="text" id="cashRebatePerson" name="cashRebatePerson" value="${param.cashRebatePerson }" class="text small">
  				</td>
  				<td><label>收银日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
<c:if test="${empty(page.result)}" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 没有工厂车辆返利收银信息.
	</div>
</c:if>
<c:if test="${!empty(page.result)}">
	<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 200px;">名称</td>
			<td style="width: 80px;">vin码</td>
			<td style="width: 50px;">执行价</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width:70px;">返利总额</td>
			<td style="width:90px;">返利收银金额</td>
			<td style="width:70px">返利状态</td>
			<td style="width:70px">收银人</td>
			<td style="width:70px;">收银日期</td>
			<td style="width: 100px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr >
			<td>
				${factoryOrder.carSeriy.name }
				${factoryOrder.carModel.name }
				${factoryOrder.carColor.name }
			</td>
			<td>
				${factoryOrder.vinCode}
			</td>
			<td>
				${factoryOrder.marketPrice}
			</td>
			<td>
				${factoryOrder.factoryPrice}
			</td>
			<td>
				<ystech:factoryRebateMoney factoryOrderId="${factoryOrder.dbid }" />
			</td>
			<td>
				<span style="color:red"><ystech:factoryRebateCashMoney factoryOrderId="${factoryOrder.dbid }" /></span>
			</td>
			<td>
				<c:if test="${factoryOrder.factoryRebateState eq 1}">
					默认
				</c:if>
				<c:if test="${factoryOrder.factoryRebateState eq 2}">
					已录入
				</c:if>
				<c:if test="${factoryOrder.factoryRebateState eq 3}">
					<span style="color:green">到帐</span>
				</c:if>
				<c:if test="${factoryOrder.factoryRebateState eq 4}">
					<span style="color:red">未结算完</span>
				</c:if>
			</td>
			<td>
				${factoryOrder.rebateCashPerson }
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.rebateCashDate }" />
			</td>
			<td style="text-align: center;">
				<a href="${ctx}/rebateManagement/cashDetail?factoryOrderId=${factoryOrder.dbid}" class="aedit">收银明细</a>
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
</script>
</html>
