<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>工厂返利批量收银</title>
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
	<a href="javascript:void(-1);" onclick="">工厂返利明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/rebateManagement/queryRebateDetailList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="query" name="query" value="1">
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				 <td><label>返利项目：</label></td>
  				<td>
  					<select class="text middle" id="childrenRebateTypeId" name="childrenRebateTypeId" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<c:forEach var="childrenRebateType" items="${childrenRebateTypes }">
  							<option value="${childrenRebateType.dbid}"  ${param.childrenRebateTypeId==childrenRebateType.dbid?'selected="selected"':''}>${childrenRebateType.name}</option>
  						</c:forEach>
  					</select>
  				</td> 
  				<td><label>收据号：</label></td>
  				<td><input type="text" id="receiptNumber" name="receiptNumber" class="text small" value="${param.receiptNumber}"></input></td>
  				<td><label>收银人：</label></td>
  				<td><input type="text" id="payee" name="payee" class="text small" value="${param.payee }"></td>
  			</tr>
  			<tr>
  				<td><label>收银日期：</label></td>
  				<td>
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td style="text-align: center;">
  					~
				</td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)}" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 没有工厂返利收银信息.
	</div>
</c:if>
<c:if test="${!empty(page.result)}" var="status">
	<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 150px;">车辆信息</td> 
			<td style="width: 80px;">vin码</td>
			<td style="width: 80px;">收据号</td>
			<td style="width: 100px;">返利名称</td>
			<td style="width: 100px;">工厂价</td>
			<td style="width: 80px;">返利比例</td>
			<td style="width: 80px;">返利金额</td>
			<td style="width:80px;">返利实收金额</td>
			<td style="width: 80px;">返利付款期限</td>
			<td style="width: 50px;">返利状态</td>
			<td style="width:70px;">返利收银人</td>
			<td style="width:70px;">返利收银时间</td>
			<td style="width:80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="rebate">
		<tr >
			<td style="text-align:left; ">
				<span style="text-align: left;">
				${rebate.factoryOrder.carSeriy.name }
				${rebate.factoryOrder.carModel.name }
				${rebate.factoryOrder.carColor.name }
				</span>
			</td>
			<td>
				${rebate.factoryOrder.vinCode}
			</td>
			<td>
				${rebate.cashier.receiptNumber}
			</td>
			<td>
				${rebate.name }
			</td>
			<td>
				${rebate.factoryOrder.factoryPrice }
			</td>
			<td>
				<c:if test="${empty rebate.rebateRatio }">
					无
				</c:if>
				<c:if test="${!empty rebate.rebateRatio }">
					${rebate.rebateRatio}%
				</c:if>
			</td>
			<td>
				<span style="color:red">${rebate.rebateMoney}</span>
			</td>
			<td>
				<span style="color:red">${rebate.realRebateMoney}</span>
			</td>
			<td >
				${rebate.rebateTerm }
			</td>
			<td>
				<span style="color:green">已收银</span>
			</td>
			<td>
				${rebate.cashier.payee}
			</td>
			<td>
				<fmt:formatDate value="${rebate.cashier.cashierTime}" pattern="yyyy-MM-dd"/> 
			</td>
			<td style="text-align: center;">
				<a href="${ctx}/rebateManagement/cashRebateDetail?rebateId=${rebate.dbid}" class="aedit">收银明细</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<</c:if>

<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<p id="total" style="display:none;font-size:20px;color:red;cursor:hand">总额:<span id="totals"></span></p>
</body>
<script type="text/javascript">
</script>
</html>
