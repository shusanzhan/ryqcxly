<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>预收收银列表</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">预收收银列表</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
	<a class="but button" href="${ctx}/advanceMangement/add">支出</a> 
	<%-- <div class="operate">
		 <a class="but button" href="${ctx}/advancePayment/queryCustList">添加定金客户</a> 
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div> --%>
   	<!-- <tr  style="display:block" id="zf">
				<td colspan="4" >
				<table>
					<tr>
						<td ><div style="display:block" id="pt1">支付宝:&nbsp;<input type="text" name="alipay" id=""alipay class="small text" title="支付宝" checkType="double,0" tip="支付宝金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt2" >微信:&nbsp;<input type="text" name="weChat" id="weChat" class="small text" title="微信" checkType="double,0" tip="微信支付金额不能为空，且为数字类型"></div></td>					
						<td ><div style="display:block" id="pt3">POS:&nbsp;<input type="text" name="POS" id="POS"  class="small text" title="POS" checkType="double,0" tip="POS支付金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt4" >现金:&nbsp;<input type="text" name="cash" id="cash" class="small text" title="现金" checkType="double,0" tip="现金支付金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt5" >支票:&nbsp;<input type="text" name="check" id="check" class="small text" title="支票" checkType="double,0" tip="支票支付金额不能为空，且为数字类型"></div></td>
					</tr>
					</table>
					</td>
			</tr>  -->
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/advanceMangement/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>销售人员：</label></td>
  				<td><input type="text" id="salesman" name="salesman" class="text small" value="${param.salesman}"></input></td>
  				<%-- <td><label>客户类型：</label></td>
  				<td>
  					<select class="text small" id="custType" name="custType"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.custType==1?'selected="selected"':'' } >展厅（网销客户）</option>
						<option value="2" ${param.custType==2?'selected="selected"':'' } >二网客户</option>
					</select>
				</td> --%>
				<td><label>收款类别：</label></td>
  				<td>
					<select class="text small" id="advanceTypeId" name="advanceTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="receivablesType" items="${receivablesType }">
							<option value="${receivablesType.dbid }" ${param.advanceTypeId==receivablesType.dbid?'selected="selected"':'' } >${receivablesType.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>收款日期：</label></td>
  				<td>
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)}">
	<div class="alert alert-error">
	无预收收银
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span3">客户信息</td>
			<td class="span2">创建来源</td>
			<td class="span3">客户类型</td>
			<td class="span2">收款项目</td>
			<td class="span2">收款类别</td>
			<td class="span2">本笔总额</td>
			<td class="span2">实收金额</td>
			<td class="span2">收据号</td>
			<td class="span2">收银号</td>
			<td class="span2">优惠金额</td>
			<td class="span2">优惠备注</td>
			<td class="span2">订单状态</td>
			<td class="span3">收款日期</td>
			<td class="span3">收款人</td>
			<td class="span2">销售人员</td>
			<td class="span2">备注</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="advancePayment" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align:lcenter;">
				${advancePayment.custName }
				${advancePayment.custTel }
			</td>
			<td style="text-align:center;">
				<c:if test ="${advancePayment.createSource==1}">
					订单创建
				</c:if>
				<c:if test = "${advancePayment.createSource==2}">
				   收款创建
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test ="${advancePayment.custType==1}">
					展厅（网销客户）
				</c:if>
				<c:if test = "${advancePayment.custType==2}">
				  二网客户
				</c:if>
			</td>
			<td style="text-align:center;">
				${advancePayment.itemName }
			</td>
			<td style="text-align:center;">
				${advancePayment.childReceivablesType.name}
			</td>
			<td style="text-align:lcenter;">
				<c:if test = "${empty advancePayment.totalMoney}">
					0.0
				</c:if>
				<c:if test = "${!empty advancePayment.totalMoney}">
					${advancePayment.totalMoney }
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test = "${empty advancePayment.actureMoney}">
					0.0
				</c:if>
				<c:if test = "${!empty advancePayment.actureMoney}">
					${advancePayment.actureMoney }
				</c:if>
			</td>
			<td style="text-align:center;">
				${advancePayment.receiptNum }
			</td>
			<td style="text-align:center;">
				${advancePayment.advanceI }
			</td>
			<td style="text-align:center;">
				<c:if test = "${empty advancePayment.discountMoney}">
					0.0
				</c:if>
				<c:if test = "${!empty advancePayment.discountMoney}">
					${advancePayment.discountMoney }
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test = "${empty advancePayment.discountNote}">
					无
				</c:if>
				<c:if test = "${!empty advancePayment.discountNote}">
					${advancePayment.discountNote }
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test="${advancePayment.orderStatus eq 1}">
					待收
				</c:if>
				<c:if test="${advancePayment.orderStatus eq 2}">
					已收
				</c:if> 
			</td>
			<td style="text-align:center;">
				${advancePayment.advanceTime }
			</td>
			<td style="text-align:center;">
				${advancePayment.payee }
			</td>
			<td style="text-align:center;">
				${advancePayment.salesman.realName}
			</td>
			<td style="text-align:center;">
				<c:if test = "${empty advancePayment.remarks}">
					无
				</c:if>
				<c:if test = "${!empty advancePayment.remarks}">
					${advancePayment.remarks }
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				<a  href="${ctx}/advanceMangement/add?dbid=${advancePayment.dbid }" style="color: #2b7dbc;">支出</a>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/advanceMangement/exportExcel?'+params;
}
</script>
</html>