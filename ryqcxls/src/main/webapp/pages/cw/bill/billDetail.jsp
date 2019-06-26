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
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">

</style>
<title>挂帐明细</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/bill/queryList'">挂账列表</a>-
		<a href="javascript:void(-1);" onclick="javascript:void(-1);">挂帐明细</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<form action="" name="frmId" id="frmId" >
		<input type="hidden" name="bill.billProjectId" id="insuranceDbid">
		<input type="hidden" name="dbid" id="dbid">
		<input type="hidden" name="bill.custId" id="custId">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">挂帐明细</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%" >挂账单号:&nbsp;</td>
				<td style="width:30%">
					${bill.singleNumber}
				</td>
				<td class="formTableTdLeft" style="width:20%" >挂账人:&nbsp;</td>
				<td style="width:30%">
					${bill.agent}
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%" >挂账信息:&nbsp;</td>
				<td style="width:30%">
					${bill.custName}
				</td>
				<td class="formTableTdLeft" style="width:20%">挂账类型:&nbsp;</td>
				<td style="width:30%">
					<c:if test="${bill.billType eq 1}">
						应收挂账
					</c:if>
					<c:if test="${bill.billType eq 2}">
						应付挂账
					</c:if>
				</td>	
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">挂账项目:&nbsp;</td>
				<td style="width:30%">
				 	<c:choose>
						<c:when test="${bill.billProject eq 1}">
							保险返利挂账
						</c:when>
						<c:when test="${bill.billProject eq 2}">
							金融应收挂账
						</c:when>
						<c:when test="${bill.billProject eq 3}">
							车辆成本应付挂账
						</c:when>
						<c:when test="${bill.billProject eq 4}">
							装饰成本应付挂账（无销售部）
						</c:when>
						<c:when test="${bill.billProject eq 5}">
							配件应付挂账
						</c:when>
						<c:when test="${bill.billProject eq 6}">
							工厂返利挂账
						</c:when>
						<c:when test="${bill.billProject eq 7}">
							装饰成本应付挂账（有销售部）
						</c:when>
					</c:choose> 
				</td>
				<td class="formTableTdLeft" style="width:20%">挂账单位名称:&nbsp;</td>
				<td style="width:30%">
					${bill.billCompany}
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">挂账单位电话:&nbsp;</td>
				<td style="width:30%">
					<c:if test="${empty bill.companyTel}">
						无
					</c:if>
					<c:if test="${!empty bill.companyTel}">
						${bill.companyTel }
					</c:if>
				</td>
				<td class="formTableTdLeft">挂账日期:&nbsp;</td>
				<td>
					${bill.billDate }
				</td>
			</tr>	
			<tr height="42">
			<td class="formTableTdLeft" style="width:20%">
					<c:if test="${bill.billType eq 1}">
						应收款金额:&nbsp;
					</c:if>
					<c:if test="${bill.billType eq 2}">
						应付款金额&nbsp;
					</c:if>
				</td>
				<td style="width:30%">
					<c:if test="${empty bill.totalPayOrReceive}">
						0.0
					</c:if>
					<c:if test="${!empty bill.totalPayOrReceive}">
						${bill.totalPayOrReceive }
					</c:if>
				</td>
				<td class="formTableLeft" style="width:20%">挂账金额:&nbsp;</td>
				<td style="width:30%">
					<c:if test="${empty bill.billAmount}">
						0.0
					</c:if>
					<c:if test="${!empty bill.billAmount}">
						${bill.billAmount }
					</c:if>
				</td>
			</tr>
		<tr height = "42">
		<td class="formTableTdLeft">
				<c:if test="${bill.billType eq 1}">
					是否到帐:&nbsp;
				</c:if>
				<c:if test="${bill.billType eq 2}">
					是否付款:&nbsp;
				</c:if>
			</td>
			<td>
					<c:if test="${bill.isToAccount eq 1}">
						是
					</c:if>
					<c:if test="${bill.isToAccount eq 2}">
						否
					</c:if>
			</td>
		<td class="formTableTdLeft">
			<c:if test="${bill.billType eq 1}">
					本次回款:&nbsp;
			</c:if>
			<c:if test="${bill.billType eq 2}">
					本次付款:&nbsp;
			</c:if>
		</td>
			<td>
					<c:if test="${empty bill.thisReturn }">
						0.0
					</c:if>
					<c:if test="${!empty bill.thisReturn }">
						${bill.thisReturn }
					</c:if>
			</td>
	</tr>
	<tr>
		<td class="formTableTdLeft">
				<c:if test="${bill.billType eq 1}">
					累计回款:&nbsp;
				</c:if>
				<c:if test="${bill.billType eq 2}">
					累计付款:&nbsp;
				</c:if>
			</td>
			<td>
				<c:if test="${empty bill.accumulativeReturn }">
					0.0
				</c:if>
				<c:if test="${!empty bill.accumulativeReturn }">
					${bill.accumulativeReturn }
				</c:if>
			</td>
		<td class="formTableTdLeft">差额:&nbsp;</td>
			<td>
				<c:if test="${empty bill.difference}">
					0.0
				</c:if>
				<c:if test="${!empty bill.difference}">
					${bill.difference }
				</c:if>
			</td>
	
	</tr>
		<tr>
			<td class="formTableTdLeft">付款期限(天):&nbsp;</td>
			<td>
				<c:if test="${empty bill.termOfPayment}">
					无
				</c:if>
				<c:if test="${!empty bill.termOfPayment}">
					${bill.termOfPayment }
				</c:if>
			</td>
			<td class="formTableTdLeft">是否销账:&nbsp;</td>
			<td>
				<c:if test="${bill.isWriteOff eq 1}">
					是
				</c:if>
				<c:if test="${bill.isWriteOff eq 2}">
					否
				</c:if>
			</td>
		</tr>
		<tr>	
			<td class="formTableTdLeft">销账日期:&nbsp;</td>
			<td>
					<c:if test="${empty bill.writeOffDate}">
						未销账
					</c:if>
					<c:if test="${!empty bill.writeOffDate}">
						${bill.writeOffDate }
					</c:if>
			</td>
			<td >备注：&nbsp;</td>
			<td>
					<c:if test="${empty bill.remarks }">
						无
					</c:if>
					<c:if test="${empty bill.remarks }">
						${bill.remarks }
					</c:if>
			</td>
		</tr>
	</table>
		<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;回</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
</script>
</html>