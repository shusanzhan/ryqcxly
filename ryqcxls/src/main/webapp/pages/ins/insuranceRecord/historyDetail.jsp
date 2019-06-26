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
	【${insCustomer.name }】投保明细
</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">客户资料</td>
			</tr>
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
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 8px">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="4%" style="text-align: center;">序号</td>
				<td width="24%" style="text-align: center;">险种</td>
				<td width="12%" style="text-align: center;">保期</td>
				<td width="8%" style="text-align: center;">出单公司</td>
				<td width="8%" style="text-align: center;">出单渠道</td>
				<td  width="16%" style="text-align: center;">保费</td>
				<td  width="6%" style="text-align: center;">返利</td>
				<td  width="8%" style="text-align: center;">客户权益</td>
				<td width="8%" style="text-align: center;">购买日期</td>
				<td width="8%" style="text-align: center;">操作</td>
			</tr>
			<c:forEach var="insuranceRecord" items="${insuranceRecords }" varStatus="i">
				<tr height="42">
				<td align="center">${i.index+1 }</td>
				<td style="padding: 5px;">
					${insuranceRecord.strongRisk }
					${insuranceRecord.busiRisk }
				</td>
				<td align="center">
					${insuranceRecord.beginDate }~
					${insuranceRecord.endDate }
				</td>
				<td align="center">
					${insuranceRecord.insuranceCompany.name }
				</td>
				<td align="center">
					${insuranceRecord.insuranceInfrom.name }
				</td>
				<td style="text-align: center;">
					<span style="font-size: 14px;color: red;">${insuranceRecord.totalPrice }</span>=<span style="font-size: 14px;color: red;">${insuranceRecord.strongRiskPrice }</span> +  <span style="font-size: 14px;color: red;">${insuranceRecord.busiRiskPrice }</span>
				</td>
				<td style="text-align: center;">
					<span style="font-size: 14px;color: red;">${insuranceRecord.rebateMoney }</span>
				</td>
				<td style="text-align: center;">
					<span style="font-size: 14px;color: red;">${insuranceRecord.incidentalInterestMoney }</span>
				</td>
				<td align="center">
					${insuranceRecord.createDate }
				</td>
				<td align="center">
					<a href="${ctx }/insuranceRecord/insuranceRecordDetail?dbid=${insuranceRecord.dbid }" class="aedit" style="color:#2b7dbc">明细</a>
				</td>
			</c:forEach>
		</table>
	<div class="formButton" style="width: 100%;">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
	</div>
	</div>
</body>
</html>