<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
}
.frmContent form table tr td {
    padding-left: 5px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
.icon-remove {
    background-position: -312px 0;
}
</style>
<title>保险单</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx }/outboundOrder/index?customerId=${insCustomer.customerId}'">核查合同</a>-
	<a href="javascript:void(-1);">
		<c:if test="${empty(insCustomer) }">保险费用</c:if>
		<c:if test="${!empty(insCustomer) }">保险费用</c:if>
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="insCustomerId" id="insCustomerId" value="${insCustomer.dbid }">
		<input type="hidden" name="type" id="type" value="${param.type }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td >${insCustomer.name }</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					${insCustomer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td >
					${insCustomer.brand.name }
					${insCustomer.carseriy.name }
					${insCustomer.carModel.name }
				</td>
				<td class="formTableTdLeft">vin码:&nbsp;</td>
				<td >
					${insCustomer.vinCode }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td >
					<c:if test="${empty(insCustomer.carPlateNo) }">
						<input id="carPlateNo" class="large text"   name="carPlateNo" value="${insCustomer.carPlateNo }"  checkType="string,5"  tip="车牌号不能为空">
						<span style="color: red;">*</span>
					</c:if>
					<c:if test="${!empty(insCustomer.carPlateNo) }">
						${insCustomer.carPlateNo}
					</c:if>
				</td>
				<td class="formTableTdLeft">出单店:&nbsp;</td>
				<td colspan="">
					<select id="insEnterpriseId" name="insEnterpriseId" class="text large" checkType="integer,1" tip="请选择出单店">
							<option value="">请选择...</option>
							<c:forEach var="enterprise" items="${enterprises }">
								<option value="${enterprise.dbid }" ${enterprise.dbid==insuranceRecord.insEnterprise.dbid?'selected="selected"':'' }>${enterprise.name }</option>
							</c:forEach>
						</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<c:if test="${insCustomer.customerType==1 }">
				<tr height="42">
					<td class="formTableTdLeft">销售顾问:&nbsp;</td>
					<td >
						${insCustomer.salerName }
					</td>
					<td class="formTableTdLeft">联系电话:&nbsp;</td>
					<td >
						${insCustomer.saler.mobilePhone }
					</td>
				</tr>
			</c:if>
			<tr height="42">
					<td class="formTableTdLeft">客户类型:&nbsp;</td>
					<td >
						<c:if test="${insCustomer.customerType==1 }">
							保有客户
						</c:if>
						<c:if test="${insCustomer.customerType==2 }">
							新增客户
						</c:if>
					</td>
			</tr>
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">基础信息</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">出单公司:&nbsp;</td>
					<td colspan="" >
						<!-- 用户计算历史的 总金额、商业险总金额、强制险总金额-->
						<input type="hidden" name="resourceTotalPrice"  id="resourceTotalPrice" value="${insuranceRecord.totalPrice }">
						<input type="hidden" name="resourceRebateMoney"  id="resourceRebateMoney" value="${insuranceRecord.rebateMoney }">
						<input type="hidden" name="resourceIncidentalInterestMoney"  id="resourceIncidentalInterestMoney" value="${insuranceRecord.incidentalInterestMoney }">
						<input type="hidden" name="insuranceRecord.cashierStatus"  id="cashierStatus" value="${insuranceRecord.cashierStatus }">
						<input type="hidden" name="insuranceRecord.cwStatus"  id="cwStatus" value="${insuranceRecord.cwStatus }">
						<input type="hidden" name="insuranceRecord.busiRiskPrice"  id="busiRiskPrice" value="${insuranceRecord.busiRiskPrice }">
						<input type="hidden" name="type"  id="type" value="3">
						<input type="hidden" name="insuranceRecord.createDate"  id="createDate" value="${insuranceRecord.createDate }">
						<input type="hidden" name="insuranceRecord.totalPrice"  id="totalPrice" value="${insuranceRecord.totalPrice }">
						<input type="hidden" name="insuranceRecord.dbid"  id="dbid" value="${insuranceRecord.dbid }">
						<input type="hidden" name="insuranceRecord.rebateMoney"  id="rebateMoney" value="${insuranceRecord.rebateMoney }">
						<input type="hidden" name="insuranceRecord.incidentalInterestMoney"  id="incidentalInterestMoney" value="${insuranceRecord.incidentalInterestMoney }">
						<input type="hidden" name="busiRiskPer"  id="busiRiskPer" value="${insuranceRecord.insuranceCompany.busiRiskPer}">
						<input type="hidden" name="strongRiskPer"  id="strongRiskPer" value="${insuranceRecord.insuranceCompany.strongRiskPer}">
						<input type="hidden" name="insuranceRecord.busiRiskRebateMoney"  id="busiRiskRebateMoney" value="${insuranceRecord.busiRiskRebateMoney }">
						<input type="hidden" name="insuranceRecord.strongRiskRebateMoney"  id="strongRiskRebateMoney" value="${insuranceRecord.strongRiskRebateMoney }">
						<select id="insuranceCompanyId" name="insuranceCompanyId" class="text large" checkType="integer,1" tip="请选择出单公司" onchange="chanageInsuranceCompany(this.value)">
							<option value="">请选择...</option>
							<c:forEach var="insuranceCompany" items="${insuranceCompanies }">
								<option value="${insuranceCompany.dbid }" ${insuranceCompany.dbid==insuranceRecord.insuranceCompany.dbid?'selected="selected"':'' }>${insuranceCompany.name } </option>
							</c:forEach>
						</select>
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft" width="120">出单渠道:&nbsp;</td>
					<td colspan="" >
						<select id="insuranceInfromId" name="insuranceInfromId" class="text large" checkType="integer,1" tip="请选择出单公司">
							<option value="">请选择...</option>
							<c:forEach var="insuranceInfrom" items="${insuranceInfroms }">
								<option value="${insuranceInfrom.dbid }" ${insuranceInfrom.dbid==insuranceRecord.insuranceInfrom.dbid?'selected="selected"':'' }>${insuranceInfrom.name }</option>
							</c:forEach>
						</select>
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">起保日期:&nbsp;</td>
					<td colspan="" >
						<input id="beginDate" class="large text"  onfocus="new WdatePicker();addYear(this.value)" name="insuranceRecord.beginDate" value="${insuranceRecord.beginDate }" checkType="string,1,50"  tip="起保日期不能为空">
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">脱保日期:&nbsp;</td>
					<td >
						<input type="text" name="insuranceRecord.endDate" id="endDate"	value="${insuranceRecord.endDate }" class="large text"  title="脱保日期" onfocus="new WdatePicker()"	checkType="string,1,50"  tip="脱保日期不能为空">
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft">销售顾问:&nbsp;</td>
					<td colspan="3"><input type="text" readonly="readonly" class="large text"  name="creatorName" id="creatorName"	value="${sessionScope.user.realName }" checkType="string,1,50"  tip="起保日期日期不能为空"></td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">内容:&nbsp;</td>
					<td colspan="3" width="1000">
						<textarea class="text" rows="9" cols="" id="note" name="insuranceRecord.note" style="width: 98%;height: 50px;">${insuranceRecord.note }</textarea>
					</td>
				</tr>
			</table>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">强制险</td>
				</tr>
				<tr height="42">
					<td width="200" align="center">款项&nbsp;</td>
					<td width="320" align="center">选项</td>
					<td width="140" align="center">金额</td>
					<td width="320" align="center">明细</td>
				</tr>
					<tr height="40" style="height: 40px;">
						<td  width="200">强制险</td>
						<td  width="320">
						</td>
						<td width="140">
							<input type="text" id="strongRiskPrice" name="insuranceRecord.strongRiskPrice" value="${insuranceRecord.strongRiskPrice }" class="smallX text" onkeyup="strongRisk(this.value)" checkType="float,0" canEmpty="Y" tip="请输入数字">
						</td>
						<td width="320">
						</td>
					</tr>
					<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="text-align: right;padding-right: 12px;" >强制险合计:<span style="font-size: 20px;color: red;margin:0 5px;" id="strongRiskPriceText">${insuranceRecord.strongRiskPrice }</span>元</td>
					</tr>
			</table>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">商业险</td>
				</tr>
				<tr height="42">
					<td width="200" align="center">款项&nbsp;
						<label>
							<c:if test="${fn:length(bussiInsuranceItems)==fn:length(insuranceRecordItems) }" var="statusL">
								<input type='checkbox' id="selectAllCheck" checked="checked" onclick="selectAll(this,'bussiInsuranceItemId')" /><span id="selectText">取消</span>
							</c:if>
							<c:if test="${statusL==false }">
								<input type='checkbox' id="selectAllCheck"  onclick="selectAll(this,'bussiInsuranceItemId')" /><span id="selectText">取消</span>
							</c:if>
						</label>
					</td>
					<td width="320" align="center">选项</td>
					<td width="140" align="center">金额</td>
					<td width="320" align="center">明细</td>
				</tr>
				<c:forEach var="insuranceItem" items="${bussiInsuranceItems }" varStatus="questIndex">
					<c:set var="itemStatus" value="false"></c:set>
					<c:set var="insuranceRecordItemTarget" value=""></c:set>
					<c:forEach var="insuranceRecordItem" items="${insuranceRecordItems}" varStatus="ss">
						<c:if test="${insuranceItem.dbid==insuranceRecordItem.insuranceItem.dbid }">
							<c:set var="itemStatus" value="true"></c:set>
							<c:set var="insuranceRecordItemTarget" value="${insuranceRecordItem}"></c:set>
						</c:if>
					</c:forEach>
					<c:if test="${itemStatus==false }">
						<tr height="40" style="height: 40px;">
							<td  width="200">
								<label>
									<input type="checkbox" onclick="onclickItem(this)" name="bussiInsuranceItemId" id="id1" value="${insuranceItem.dbid }"> ${insuranceItem.name }
								</label>
							</td>
							<td  width="320">
								<c:if test="${insuranceItem.singleStatus==2 }">
									<c:forEach var="insuranceItemChoice" items="${insuranceItem.insuranceItemChoices }" varStatus="itemIdex">
										<c:if test="${itemIdex.index==0 }">
											<label>
												<input type="radio" name="resultValue${insuranceItem.dbid }" id="bus${questIndex.index+1 }" value="${insuranceItemChoice.dbid }" checked="checked">${insuranceItemChoice.lable }&nbsp;&nbsp;</label>
										</c:if>
										<c:if test="${itemIdex.index!=0 }">
											<label>
												<input type="radio" name="resultValue${insuranceItem.dbid }" id="bus${questIndex.index+1 }" value="${insuranceItemChoice.dbid }">${insuranceItemChoice.lable }&nbsp;&nbsp;</label>
										</c:if>
									</c:forEach>
								</c:if>
							</td>
							<td width="140">
								<input type="text" id="price${insuranceItem.dbid }" price="bprice" name="bprice${insuranceItem.dbid }" value="" onkeyup="jisuanZonge(this)" class="smallX text" disabled="disabled">
							</td>
							<td width="320">
								${insuranceItem.details }
							</td>
						</tr>
					</c:if>
					<c:if test="${itemStatus==true }">
						<tr height="40" style="height: 40px;">
							<td  width="200">
								<label>
									<input type="hidden" id="insuranceRecordItemId${insuranceItem.dbid }" name="insuranceRecordItemId" value="${insuranceRecordItemTarget.dbid }">
									<input type="checkbox" onclick="onclickItem(this)" name="bussiInsuranceItemId" id="id1" checked="checked" value="${insuranceItem.dbid }"> ${insuranceItem.name }
								</label>
							</td>
							<td  width="320">
								<c:if test="${insuranceItem.singleStatus==2 }">
										<c:forEach var="insuranceItemChoice" items="${insuranceItem.insuranceItemChoices }">
											<c:if test="${insuranceItemChoice.dbid==insuranceRecordItemTarget.insuranceItemChoice.dbid }" var="status">
													<label>
														<input type="radio" name="resultValue${insuranceItem.dbid }" id="bus${questIndex.index+1 }" value="${insuranceItemChoice.dbid }" checked="checked">${insuranceItemChoice.lable }&nbsp;&nbsp;</label>
												</c:if>
												<c:if test="${status==false }">
													<label>
														<input type="radio" name="resultValue${insuranceItem.dbid }" id="bus${questIndex.index+1 }" value="${insuranceItemChoice.dbid }">${insuranceItemChoice.lable }&nbsp;&nbsp;</label>
												</c:if>
										</c:forEach>
								</c:if>
							</td>
							<td width="140">
								<input type="text" id="price${insuranceItem.dbid }" price="bprice" name="bprice${insuranceItem.dbid }" value="${insuranceRecordItemTarget.price }" onkeyup="jisuanZonge(this)" class="smallX text">
							</td>
							<td width="320">
								${insuranceItem.details }
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="text-align: right;padding-right: 12px;">商业险合计:<span style="font-size: 20px;color: red;margin:0 5px;" id="busiRiskPriceText">${insuranceRecord.busiRiskPrice}</span>元</td>
				</tr>
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="text-align: right;padding-right: 12px;">总计：<span style="font-size: 20px;color: red;margin:0 5px;" id="totalPriceText">${insuranceRecord.totalPrice }</span>元</td>
				</tr>
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="text-align: right;padding-right: 12px;">
						返利合计:<span id="strongRiskPerText" style="display: none;">${insuranceRecord.strongRiskPrice }*${insuranceRecord.insuranceCompany.busiRiskPer }*%</span>
						<span id="busiRiskPerText" style="display: none;">${insuranceRecord.busiRiskPrice}*${insuranceRecord.insuranceCompany.strongRiskPer }%</span>
						<span style="font-size: 20px;color: red;margin:0 5px;" id="rebateMoneyText">${insuranceRecord.rebateMoney }</span>元</td>
				</tr>
			</table>
			<%-- <div id='te' style="width: 100%">
			<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="5" style="text-align: left;padding-right: 12px;">客户权益</td>
				</tr>
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 30px;text-align: center;">序号</th>
						<th style="width: 280px;text-align: center;">项目名称</th>
						<th style="width: 120px;text-align: center;">价值</th>
						<th style="width: 500px;text-align: center;">备注</th>
						<th style="width: 40px;text-align: center;">操作</th>
				</tr>
				<!-- 添加时展示页面 -->
					<c:if test="${empty(insCustomer) }">
						<c:forEach var="i" begin="0" step="1" end="3">
							<tr id="tr${i+1 }">
								<td style="text-align: center;">
									${i+1 }
								</td>
								<td >
									<input type="text" name="incidentalInterestName" id="incidentalInterestName${i+1 }" onFocus="autoIncidentalInterestByName('incidentalInterestName${i+1 }');create(this)"  class="media text" style="width: 95%">
									<input type="hidden" name="incidentalInterestDbid" id="incidentalInterestDbid${i+1}" onblur="create(this)"  >
								</td>
								<td style="text-align: center;">
									<input type="text"  name="price" id="price${i+1 }" class="small text"   onkeyup="decorePrice()" checkType="integer,1" canEmpty="Y" tip="请输入项目价值，必须为数字" style="width: 95%">
								</td>
								<td>
									<input type="text" name="note" id="note${i+1 }" class="largeXX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" style="width: 95%">
								</td>
								<td style="text-align: center;padding-top: 8px;">
									<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
										<i class="icon-remove icon-black" > </i>
									</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<!-- 添加时展示页面 结束 -->
					<!-- 编辑时展示页面 结束 -->
					<c:if test="${!empty(insCustomer) }">
						<c:set value="${fn:length(insuranceIncidentalInterests)}" var="itemLength"></c:set>
						<c:forEach var="insuranceIncidentalInterest" items="${insuranceIncidentalInterests }" varStatus="i">
							<tr id="tr${i.index+1 }">
								<td style="text-align: center;">
									${i.index+1 }
								</td>
								<td >
									<input type="text" name="incidentalInterestName" id="incidentalInterestName${i.index+1 }" value="${insuranceIncidentalInterest.incidentalInterest.name }" onFocus="autoIncidentalInterestByName('incidentalInterestName${i.index+1 }');create(this)"   class="small text"  style="width: 95%;">
									<input type="hidden" name="incidentalInterestDbid" id="incidentalInterestDbid${i.index+1}" value="${insuranceIncidentalInterest.incidentalInterest.dbid }" onblur="create(this)" style="width: 100%;">
								</td>
								<td style="text-align: center;">
									<input type="text"  name="price" id="price${i.index+1 }"  class="small text"  value="${insuranceIncidentalInterest.price }" onkeyup="decorePrice()" checkType="integer,1" canEmpty="Y" tip="请输入项目价值，必须为数字" style="width: 95%">
								</td>
								<td>
									<input type="text" name="note" id="note${i.index+1 }"  class="small text"  style="width: 92%;" value="${insuranceIncidentalInterest.note }" checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" style="width: 95%">
								</td>
								<td style="text-align: center;padding-top: 8px;">
									<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
										<i class="icon-remove icon-black" > </i>
									</a>
								</td>
							</tr>
						</c:forEach>
						<c:forEach var="i" begin="${itemLength }" step="1" end="3">
							<tr id="tr${i+1 }">
								<td style="text-align: center;">
									${i+1 }
								</td>
								<td >
									<input type="text" name="incidentalInterestName" id="incidentalInterestName${i+1 }" onFocus="autoIncidentalInterestByName('incidentalInterestName${i+1 }');create(this)"  class="media text" style="width: 95%">
									<input type="hidden" name="incidentalInterestDbid" id="incidentalInterestDbid${i+1}" onblur="create(this)"  >
								</td>
								<td style="text-align: center;">
									<input type="text"  name="price" id="price${i+1 }" class="small text"   onkeyup="decorePrice()" checkType="integer,1" canEmpty="Y" tip="请输入项目价值，必须为数字" style="width: 95%">
								</td>
								<td>
									<input type="text" name="note" id="note${i+1 }" class="largeXX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" style="width: 95%">
								</td>
								<td style="text-align: center;padding-top: 8px;">
									<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
										<i class="icon-remove icon-black" > </i>
									</a>
								</td>
							</tr>
					</c:forEach>
					</c:if>
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="5" style="text-align: right;padding-right: 12px;">
						客户权益合计：
						<span style="font-size: 20px;color: red;margin:0 5px;" id="incidentalInterestMoneyText">
							<c:if test="${empty(insuranceRecord.incidentalInterestMoney) }">
								0
							</c:if>
							<c:if test="${!empty(insuranceRecord.incidentalInterestMoney) }">
								${insuranceRecord.incidentalInterestMoney }
							</c:if>
						</span>元
					</td>
				</tr>
			</table>
		</div> --%>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/insuranceRecord/save')"	class="but butSave">保存并继续</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function formatFloat(x) {
    var f_x = parseFloat(x);
    if (isNaN(f_x)) {
        alert('function:changeTwoDecimal->parameter error');
        return 0;
    }
    var f_x = Math.round(x * 100) / 100;
    var s_x = f_x.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    return s_x;
}
function selectAll(checkbox, domname) {
	var totalPrice=0;
	var nonDeductiblePriceTotal=0;
	var doms = document.getElementsByName(domname);
	for ( var i = 0; i < doms.length; i++) {
		if (doms[i].type == "checkbox") {
			doms[i].checked = checkbox.checked;
			if(checkbox.checked){
				$("#price"+$(doms[i]).val()).removeAttr("disabled");
				$("#nonDeductiblePrice"+$(doms[i]).val()).removeAttr("disabled");
				$("#selectText").text("");
				$("#selectText").text("取消");
				$(doms[i]).parent().addClass("checked");
				var price=$("#price"+$(doms[i]).val()).val();
				price=parseFloat(price);
				if(isNaN(price)){
					price=0;
				}
				totalPrice=price+totalPrice;
				
				var nonDeductiblePrice=$("#nonDeductiblePrice"+$(doms[i]).val()).val();
				nonDeductiblePrice=parseFloat(nonDeductiblePrice);
				if(isNaN(nonDeductiblePrice)){
					nonDeductiblePrice=0;
				}
				nonDeductiblePriceTotal=nonDeductiblePriceTotal+nonDeductiblePrice;
			}else{
				$("#selectText").text("");
				$("#selectText").text("全选");
				$("#busiRiskPrice").val(0);
				$("#busiRiskPriceText").text(0);
				$("#price"+$(doms[i]).val()).attr("disabled","disabled");
				$("#price"+$(doms[i]).val()).val("0");
				$("#nonDeductiblePrice"+$(doms[i]).val()).attr("disabled","disabled");
				$("#nonDeductiblePrice"+$(doms[i]).val()).val("0");
				$(doms[i]).parent().removeClass("checked");
			}
		}
	}
	var strongRiskPrice=$("#strongRiskPrice").val();
	strongRiskPrice=parseFloat(strongRiskPrice);
	if(isNaN(strongRiskPrice)){
		strongRiskPrice=0;
	}
	totalPrice=totalPrice;
	$("#busiRiskPrice").val(totalPrice);
	$("#busiRiskPriceText").text(totalPrice);
	
	$("#nonDeductiblePriceTotal").val(nonDeductiblePriceTotal);
	$("#nonDeductiblePriceText").text(nonDeductiblePriceTotal);
	getTotalPrice();
}
function onclickItem(checkbox){
	if(checkbox.checked){
		$("#price"+$(checkbox).val()).removeAttr("disabled");
		//总金额添加
		var price=$("#price"+$(checkbox).val()).val();
		//总金额添加
		$("#nonDeductiblePrice"+$(checkbox).val()).removeAttr("disabled");
		var price=$("#nonDeductiblePrice"+$(checkbox).val()).val();
	
		price=parseFloat(price);
		if(isNaN(price)){
			price=0;
		}
		var busiRiskPrice=$("#busiRiskPrice").val();
		busiRiskPrice=parseFloat(busiRiskPrice);
		if(isNaN(busiRiskPrice)){
			busiRiskPrice=0;
		}
		busiRiskPrice=busiRiskPrice+price;
		$("#busiRiskPrice").val(busiRiskPrice);
		$("#busiRiskPriceText").text(busiRiskPrice);
	}else{
		//总金额减
		$("#price"+$(checkbox).val()).attr("disabled","disabled");
		var price=$("#price"+$(checkbox).val()).val();
		$("#nonDeductiblePrice"+$(checkbox).val()).attr("disabled","disabled");
		price=parseFloat(price);
		if(isNaN(price)){
			price=0;
		}
		var busiRiskPrice=$("#busiRiskPrice").val();
		busiRiskPrice=parseFloat(busiRiskPrice);
		if(isNaN(busiRiskPrice)){
			busiRiskPrice=0;
		}
		busiRiskPrice=busiRiskPrice-price;
		$("#busiRiskPrice").val(busiRiskPrice);
		$("#busiRiskPriceText").text(busiRiskPrice);
		$("#price"+$(checkbox).val()).val("");
		
		var nonDeductiblePrice=$("#nonDeductiblePrice"+$(checkbox).val()).val();
		price=parseFloat(nonDeductiblePrice);
		if(isNaN(nonDeductiblePrice)){
			nonDeductiblePrice=0;
		}
		var nonDeductiblePriceTotal=$("#nonDeductiblePriceTotal").val();
		nonDeductiblePriceTotal=parseFloat(nonDeductiblePriceTotal);
		if(isNaN(nonDeductiblePriceTotal)){
			nonDeductiblePriceTotal=0;
		}
		nonDeductiblePriceTotal=nonDeductiblePriceTotal-nonDeductiblePrice;
		$("#nonDeductiblePriceTotal").val(nonDeductiblePriceTotal);
		$("#nonDeductiblePriceText").text(nonDeductiblePriceTotal);
		$("#nonDeductiblePrice"+$(checkbox).val()).val("");
	}
	var doms = document.getElementsByName("bussiInsuranceItemId");
	var jlength=0;
	for ( var i = 0; i < doms.length; i++) {
		if (doms[i].type == "checkbox") {
			if(doms[i].checked){
			}else{
				jlength=jlength+1;
			}
		}
	}
	if(jlength==doms.length){
		$("#selectText").text("");
		$("#selectText").text("全选");
		$("#selectAllCheck").removeAttr("checked");
	}else{
		$("#selectText").text("");
		$("#selectText").text("取消");
		$("#selectAllCheck").attr("checked",'true');
	}
	getTotalPrice();
}
function jisuanZonge(val){
	//获取档案行的坐标
	
	var prices=$("input[price='bprice']");
	var totalPrice=0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		price=parseFloat(price);
		if(isNaN(price)){
			price=0;
		}
		totalPrice=totalPrice+price;
	}
	//总金额添加
	$("#busiRiskPrice").val(totalPrice);
	$("#busiRiskPriceText").text(totalPrice);
	
	var priceId=$(val).attr("id");
	var varinsId=priceId.substring(5,priceId.length);
	showNonDe(varinsId);
	jisuanNo();
	getTotalPrice();
}
function jisuanNo(val){
	var prices=$("input[nonDeductiblePrice='bnonDeductiblePrice']");
	var totalPrice=0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		price=parseFloat(price);
		if(isNaN(price)){
			price=0;
		}
		totalPrice=totalPrice+price;
	}
	//总金额添加
	$("#nonDeductiblePriceTotal").val(totalPrice);
	$("#nonDeductiblePriceText").text(totalPrice);
	getTotalPrice();
}
function strongRisk(val){
	if(null==val||val==""){
		$("#strongRiskPriceText").text(0);
	}else{
		$("#strongRiskPriceText").text(val);
	}
	getTotalPrice();
	//总金额添加
}
function addYear(date){
	if(null!=date&&date!=''){
		var d1=new Date(date); 
		var d2=new Date(d1); 
		d2.setFullYear(d2.getFullYear()+1); 
		d2.setDate(d2.getDate()-1); 
		$("#endDate").val(d2.format("yyyy-MM-dd"));
	}
}

function getTotalPrice(){
	var strongRiskPrice= $("#strongRiskPrice").val();
	strongRiskPrice=parseFloat(strongRiskPrice);
	if(isNaN(strongRiskPrice)){
		strongRiskPrice=0;
	}
	var busiRiskPrice= $("#busiRiskPrice").val();
	busiRiskPrice=parseFloat(busiRiskPrice);
	if(isNaN(busiRiskPrice)){
		busiRiskPrice=0;
	}
	var nonDeductiblePriceTotal=$("#nonDeductiblePriceTotal").val();
	nonDeductiblePriceTotal=parseFloat(nonDeductiblePriceTotal);
	if(isNaN(nonDeductiblePriceTotal)){
		nonDeductiblePriceTotal=0;
	}
	busiRiskPrice=busiRiskPrice+nonDeductiblePriceTotal;
	var totalPrice=busiRiskPrice+strongRiskPrice;
	$("#totalPrice").val(totalPrice);
	$("#totalPriceText").text(totalPrice);
	
	var busiRiskPer=$("#busiRiskPer").val();
	var strongRiskPer=$("#strongRiskPer").val();
	if(busiRiskPer==''||busiRiskPer==null){
		alert("请先选中出单公司！");
		return ;
	}else{
		busiRiskPer=parseFloat(busiRiskPer);
	}
	if(strongRiskPer==''||strongRiskPer==null){
		alert("请先选中出单公司！");
		return ;
	}else{
		strongRiskPer=parseFloat(strongRiskPer);
	}
	var rebateMoney=busiRiskPrice*busiRiskPer/100+strongRiskPer*strongRiskPrice/100;
	rebateMoney=formatFloat(rebateMoney);
	$("#rebateMoney").val(rebateMoney);
	$("#rebateMoneyText").text(rebateMoney);
	$("#busiRiskRebateMoney").val(busiRiskPrice*busiRiskPer/100);
	$("#strongRiskRebateMoney").val(strongRiskPer*strongRiskPrice/100);
	$("#busiRiskPerText").text(busiRiskPrice+"*"+busiRiskPer+"%");
	$("#strongRiskPerText").text(strongRiskPrice+"*"+strongRiskPer+"%");
}
//商品表格编辑部分
function create(v){
	var value=$(v).val();
	if(null==value||value.length<=0){
		return ;
	}
	var id=$(v).parent().parent().attr("id");
	if(id==$("#shopNumber tr").last().attr("id")){
		crateTr();
		$("#te").scrollTop($("#shopNumber")[0].scrollHeight);
	}
}
function deleteTr(tr) {
	var lent=$("#shopNumber").find("tr").size();
	// 删除规格值
	if ($("#shopNumber").find("tr").size() <= 3) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
		 $("#shopNumber").find("tr").each(function(i){
			 if(i>=2&&i<(lent-2)){
				$(this).find(':first').text('').text(i-1);
		 	}
			 
		});
		//计算总金额、总数量
		decorePrice();
	}
}
function crateTr() {
	var size = $("#shopNumber").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="incidentalInterestName" id="incidentalInterestName'+size+'" value="" style="width: 95%;" onFocus=\'autoIncidentalInterestByName("incidentalInterestName'+size+'");create(this)\' class="media text"/>'
			+ '<input type="hidden" name="incidentalInterestDbid" id="incidentalInterestDbid'+size+'" value="">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text"  name="price" id="price'+size+'" class="small text" checkType="integer,1" canEmpty="Y" tip="请输入项目价值，必须为数字" style="width: 95%;" >'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="note" id="note'+size+'" class="largeXX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" style="width: 95%">'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#shopNumber").append(str);
}

function autoIncidentalInterestByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/incidentalInterest/autoIncidentalInterest",{
			max: 20,      
	        width: 130,    
	        matchSubset:false,   
	        matchContains: true,  
			dataType: "json",
			parse: function(data) {   
		    	var rows = [];      
		        for(var i=0; i<data.length; i++){      
		           rows[rows.length] = {       
		               data:data[i]       
		           };       
		        }       
		   		return rows;   
		    }, 
			formatItem: function(row, i, total) {   
		       return "<span>名称："+row.name+"&nbsp;&nbsp;类型： "+row.type+" </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect);
	//计算总金额
}

function onRecordSelect(event, data, formatted) {
		var id=$(event.currentTarget).attr("id");
		var sn=id.substring(22,id.length);
		$("#incidentalInterestName"+sn).val(data.name);
		$("#incidentalInterestDbid"+sn).val(data.dbid);
		decorePrice();
	}
function decorePrice(){
	var prices=$("input[name=price]");
	var totalA=0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		if(price==""||price==null){
			price=0;
		}else{
			price=parseInt(price);
		}
		totalA=totalA+price;
	}
	$("#incidentalInterestMoney").val(totalA);
	$("#incidentalInterestMoneyText").text(totalA);
}
function chanageInsuranceCompany(value){
	$.post('${ctx}/insuranceCompany/autoInsuranceCompany?dbid='+value+"&dateTime="+new Date(),{},function(data){
		if(data.error=="error"){
			$("#busiRiskPer").val(0);
			$("#strongRiskPer").val(0);
			$("#busiRiskPerText").text(0);
			$("#strongRiskPerText").text(0);
		}else{
			$("#busiRiskPer").val(data.busiRiskPer);
			$("#strongRiskPer").val(data.strongRiskPer);
			$("#busiRiskPerText").text("商业险*"+data.busiRiskPer+"%");
			$("#strongRiskPerText").text("强制险*"+data.strongRiskPer+"%");
			getTotalPrice();
		}
	})
}
function showNonDe(dbid){
	var nonDeductibleStatus=$("input[name='nonDeductibleStatus"+dbid+"']:checked").val();
	var price=$("#price"+dbid).val();
	price=parseFloat(price);
	if(isNaN(price)){
		price=0;
	}
	var nonDeductiblePer=$("#nonDeductiblePer"+dbid).val();
	nonDeductiblePer=parseFloat(nonDeductiblePer);
	if(isNaN(nonDeductiblePer)){
		nonDeductiblePer=0;
	}
	if(nonDeductibleStatus==2){
		$("#nonDeductiblePrice"+dbid).show();
		var nonDeductiblePrice=price*nonDeductiblePer/100;
		$("#nonDeductiblePrice"+dbid).val(nonDeductiblePrice);
	}else{
		$("#nonDeductiblePrice"+dbid).hide();
		$("#nonDeductiblePrice"+dbid).val("0");
	}
	getTotalPrice();
}
</script>
</html>