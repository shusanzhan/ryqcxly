<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
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
</style>
<title>保险单</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);">
	投保明细
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<c:set value="${insuranceRecord.insCustomer }" var="insCustomer"></c:set>
		<input type="hidden" name="insCustomerId" id="insCustomerId" value="${insCustomer.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">客户资料</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td >
					${insCustomer.name }
					<c:if test="${insCustomer.customerType==1 }">
						（保有）
					</c:if>
					<c:if test="${insCustomer.customerType==2 }">
						（新增）
					</c:if>
				</td>
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
					${insCustomer.carName }
				</td>
				<td class="formTableTdLeft">vin码:&nbsp;</td>
				<td >
					${insCustomer.vinCode }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td >
					${insCustomer.carPlateNo }
				</td>
				<td class="formTableTdLeft">车辆型号:&nbsp;</td>
				<td >
					${insCustomer.sqrNo }
				</td>
			</tr>
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
			<tr height="42">
				<td class="formTableTdLeft">购买次数:&nbsp;</td>
				<td >
					<span style="font-size: 20px;color: red;margin:0 5px;">${insCustomer.historyBuyNum }</span>
				</td>
				<td class="formTableTdLeft">购买总金额:&nbsp;</td>
				<td >
					<span style="font-size: 20px;color: red;margin:0 5px;">${insCustomer.historyBuyMoney }</span>
				</td>
			</tr>
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">投保明细</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">投保店:&nbsp;</td>
				<td >
					${insuranceRecord.insEnterprise.name }
				</td>
				<td class="formTableTdLeft">签订日期:&nbsp;</td>
				<td >
					${insuranceRecord.buyDate }
				</td>
			</tr>
			<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">出单公司:&nbsp;</td>
					<td colspan="" >
						${insuranceRecord.insuranceCompany.name }
					</td>
					<td class="formTableTdLeft" width="120">出单渠道:&nbsp;</td>
					<td colspan="" >
						${insuranceRecord.insuranceInfrom.name }						
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">保期:&nbsp;</td>
					<td colspan="" >
						${insuranceRecord.beginDate }~${insuranceRecord.endDate }
					</td>
					<td class="formTableTdLeft">销售顾问:&nbsp;</td>
					<td >
						${insuranceRecord.creatorName }
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">备注:&nbsp;</td>
					<td colspan="3" width="1000">
						${insuranceRecord.note }
					</td>
				</tr>
				<tr height="42"  style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="200" align="center">款项&nbsp;</td>
					<td width="320" align="center">选项</td>
					<td width="140" align="center">金额</td>
					<td width="320" align="center">备注</td>
				</tr>
				<tr height="40" style="height: 40px;">
					<td  width="200">强制险</td>
					<td  width="320">
					</td>
					<td width="140">
						<span style="font-size: 20px;color: red;margin:0 5px;">${insuranceRecord.strongRiskPrice }</span>
					</td>
					<td width="320">
					</td>
				</tr>
				<c:forEach var="insuranceRecordItem" items="${insuranceRecordItems}">
					<tr height="40" style="height: 40px;">
						<td  width="200">${insuranceRecordItem.insuranceItem.name}</td>
						<td  width="320">
							<c:if test="${!empty(insuranceRecordItem.insuranceItem.insuranceItemChoices) }">
								<c:if test="${fn:length(insuranceRecordItem.insuranceItem.insuranceItemChoices)>1 }">
									<c:forEach var="insuranceItemChoice" items="${insuranceRecordItem.insuranceItem.insuranceItemChoices }">
										<c:if test="${insuranceItemChoice.dbid==insuranceRecordItem.insuranceItemChoice.dbid }" var="status">
												<label>
													<input type="radio" name="resultValue${insuranceItem.dbid }" id="bus${questIndex.index+1 }" value="${insuranceItemChoice.dbid }" checked="checked">${insuranceItemChoice.lable }&nbsp;&nbsp;</label>
											</c:if>
											<c:if test="${status==false }">
												<label>
													<input type="radio" name="resultValue${insuranceItem.dbid }" id="bus${questIndex.index+1 }" value="${insuranceItemChoice.dbid }">${insuranceItemChoice.lable }&nbsp;&nbsp;</label>
											</c:if>
									</c:forEach>
								</c:if>
							</c:if>
						</td>
						<td width="140">
							<span style="font-size: 20px;color: red;margin:0 5px;">${insuranceRecordItem.price }</span>
						</td>
						<td width="320">
						</td>
					</tr>
				</c:forEach>
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="text-align: right;padding-right: 12px;">总计：<span style="font-size: 20px;color: red;margin:0 5px;" id="totalPriceText">${insuranceRecord.totalPrice }</span>元</td>
				</tr>
		</table>
		<c:if test="${!empty(insuranceIncidentalInterests)&&fn:length(insuranceIncidentalInterests)>0 }">
			<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="5" style="text-align: left;padding-right: 12px;">客户权益</td>
				</tr>
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 30px;text-align: center;">序号</th>
						<th style="width: 280px;text-align: center;">项目名称</th>
						<th style="width: 120px;text-align: center;">价值</th>
						<th style="width: 500px;text-align: center;">备注</th>
				</tr>
				<!-- 添加时展示页面 -->
					<c:forEach var="insuranceIncidentalInterest" items="${insuranceIncidentalInterests }" varStatus="i">
						<tr id="tr${i.index+1 }">
							<td style="text-align: center;">
								${i.index+1 }
							</td>
							<td >
								${insuranceIncidentalInterest.incidentalInterest.name }
								<input type="hidden" name="incidentalInterestDbid" id="incidentalInterestDbid${i.index+1}" value="${insuranceIncidentalInterest.incidentalInterest.dbid }" onblur="create(this)" style="width: 100%;">
							</td>
							<td style="text-align: center;">
								${insuranceIncidentalInterest.price }
							</td>
							<td>
								${insuranceIncidentalInterest.note }
							</td>
						</tr>
					</c:forEach>
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
			</c:if>
	</form>
	<div class="formButton" style="width: 100%;">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
	</div>
	</div>
</body>
</html>