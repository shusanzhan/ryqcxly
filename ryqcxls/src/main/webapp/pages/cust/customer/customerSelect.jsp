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
function getCheckBoxsmsTemplate() {
	var array = new Array();
	var arrayNames = new Array();
	var checkeds = $("input[type='checkbox'][name='id']");
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			array.push(checkbox.value);
			arrayNames.push($(checkbox).attr("tip"));
		}
	});
	$("#smsTemplates").val(arrayNames.toString()+"|"+array.toString());
}
</script>
<title>客户信息选择</title>
</head>
<body class="bodycolor">
 <!--location end-->
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/custCustomer/customerSelect" method="post" >
		<input type="hidden" id="smsTemplates" name="smsTemplates">
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
  				<td><label>意向级别：</label></td>
  				<td>
  					<select class="text midea" id="customerPhaseId" name="customerPhaseId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }" >
							<c:if test="${customerPhase.dbid>=1&&customerPhase.dbid<=4 }">
								<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
							</c:if>
						</c:forEach>
					</select>
  				</td>
  				<%-- <td><label>客户状态：</label></td>
  				<td>
  					<select class="text midea" id="lastResult" name="lastResult"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<option value="0" ${param.lastResult==0?'selected="selected"':'' } >创建客户</option>
						<option value="1" ${param.lastResult==1?'selected="selected"':'' }>成交客户</option>
					</select>
  				</td> --%>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text midea" value="${param.mobilePhone}"></input></td>
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
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id');getCheckBoxsmsTemplate()" /></td>
			<td class="span1">名称</td>
			<td class="span1">电话</td>
			<td class="span3">车型</td>
			<td class="span1">意向级别</td>
		</tr>
	</thead>
	<c:forEach var="customer" items="${customers }">
		<tr>
		<td style="text-align: center;">
				<input type="checkbox"   name="id" id="id1" value="${customer.mobilePhone }"  tip="${customer.name }" onclick="getCheckBoxsmsTemplate()"/>
			</td>
			<td>
				<c:if test="${fn:length(customer.name)>12 }" var="status">
					${fn:substring(customer.name,0,12) }...
				</c:if>
				<c:if test="${status==false }">
					${customer.name }
				</c:if>
			</td>
			<td>
				${customer.mobilePhone}
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}">
				<c:if test="${fn:length(carModel)>8 }" var="status">
					${fn:substring(carModel,0,8) }...
				</c:if>
				<c:if test="${ status==false}">
					${carModel}  ${customer.carModelStr}
				</c:if>
			</td>
			<td>
				${customer.customerPhase.name}
			</td>
		</tr>
	</c:forEach>
</table>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>