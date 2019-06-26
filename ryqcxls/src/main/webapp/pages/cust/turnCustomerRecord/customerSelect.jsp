<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript">
/** 获取checkBox的value* */
function getCheckBoxCustomer() {
	var array = new Array();
	var arrayNames = new Array();
	var checkeds = $("input[type='checkbox'][name='id']");
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			array.push(checkbox.value);
			arrayNames.push($(checkbox).attr("tip"));
		}
	});
	$("#customerIds").val(array.toString()+"|"+arrayNames.toString());
}
</script>
<title>客户信息查找管理</title>
</head>
<body class="bodycolor">
 <!--location end-->
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/turnCustomerRecord/customerSelect" metdod="post">
  		<input type="hidden" id="customerIds" name="customerIds">
  		<input type="hidden" id="userId" name="userId" value="${userId }">
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>创建时间：</label></td>
  				<td>
  					<input type="text" id="startDate" name="startDate" value="${param.startDate }" onFocus="WdatePicker({isShowClear:true})" class="text small">
  					<input type="text" id="endDate" name="endDate"   value="${param.endDate }"  onFocus="WdatePicker({isShowClear:true})" class="text small">
  				</td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
  				<td>级别</td>
  				<td>
  					<select id="customerPhaseId" name="customerPhaseId" class="text small" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择</option>
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
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id');getCheckBoxCustomer()" /></td>
			<td class="span2">姓名</td>
			<td class="span2">常用手机号</td>
			<td class="span2">级别</td>
			<td class="span2">创建时间</td>
		</tr>
	</thead>
	<c:forEach var="customer" items="${customers }">
		<c:if test="${empty(customer.customerPidBookingRecord) }" var="status">
			<tr height="32" align="center">
						<td><input type='checkbox' name="id" id="id1" tip="${customer.name }" value="${customer.dbid }" onclick="getCheckBoxCustomer()"/></td>
						<td>
								${customer.name }
						</td>
						<td>${customer.mobilePhone }</td>
						<td>${customer.customerPhase.name }</td>
						<td><fmt:formatDate value="${customer.createFolderTime }"/> </td>
					</tr>
			</c:if>
		<c:if test="${status==false }">
			<c:if test="${customer.customerPidBookingRecord.pidStatus!=2 }">
				<tr height="32" align="center">
					<td><input type='checkbox' name="id" id="id1" tip="${customer.name }" value="${customer.dbid }" onclick="getCheckBoxCustomer()"/></td>
					<td>
							${customer.name }
					</td>
					<td>${customer.mobilePhone }</td>
					<td>${customer.customerPhase.name }</td>
					<td><fmt:formatDate value="${customer.createFolderTime }"/> </td>
				</tr>
			</c:if>
		</c:if>
	</c:forEach>
</table>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>