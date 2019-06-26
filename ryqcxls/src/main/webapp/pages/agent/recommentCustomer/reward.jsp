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
<title>客户奖励信息</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);">
	经纪人奖励
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="customerId"" id="customerId" value="${customer.dbid }">
		<input type="hidden" name="recommendCustomerId"" id="recommendCustomerId" value="${recommendCustomer.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="100%" colspan="4" style="">客户基本信息</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td >${customer.name }</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					${customer.mobilePhone }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td >
					${customer.customerPidBookingRecord.brand.name }
					${customer.customerPidBookingRecord.carSeriy.name }
					${customer.customerPidBookingRecord.carModel.name }
				</td>
				<td class="formTableTdLeft">vin码:&nbsp;</td>
				<td >
					${customer.customerPidBookingRecord.vinCode }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">成交时间:&nbsp;</td>
				<td colspan="">
					<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }"/> 
				</td>
				<td class="formTableTdLeft">销售顾问:&nbsp;</td>
				<td >
					${customer.user.realName }
					${customer.user.mobilePhone }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">经纪人姓名:&nbsp;</td>
				<td >
					${member.name }
					(
						<c:if test="${member.sex=='男' }">
							<span style="color: #56a845">${member.sex }</span>
						</c:if>
						<c:if test="${member.sex=='女' }">
							<span style="color: #ff6700">${member.sex }</span>
						</c:if>
					)
				</td>
				<td class="formTableTdLeft">经纪人联系电话:&nbsp;</td>
				<td >
					${member.mobilePhone }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">上级经纪人姓名:&nbsp;</td>
				<td >
					${parentMember.name }
					(
						<c:if test="${parentMember.sex=='男' }">
							<span style="color: #56a845">${parentMember.sex }</span>
						</c:if>
						<c:if test="${parentMember.sex=='女' }">
							<span style="color: #ff6700">${parentMember.sex }</span>
						</c:if>
					)
				</td>
				<td class="formTableTdLeft">上级经纪人联系电话:&nbsp;</td>
				<td >
					${parentMember.mobilePhone }
				</td>
			</tr>
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">奖励信息</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">经纪人奖励状态:&nbsp;</td>
					<td colspan="3" >
						<c:if test="${agentSet.agentRewardStatus==1 }">
							<span style="color: green">开启</span>
						</c:if>
						<c:if test="${agentSet.agentRewardStatus==2 }">
							<span style="color: red">停用</span>
						</c:if>
						经济类别：${spread.name }
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">经纪人奖励红包:&nbsp;</td>
					<td colspan="" >
						<c:if test="${agentSet.agentRewardModel==1}">
							<input type="text" readonly="readonly"   name="agentRewardNum" id=agentRewardNum	value="${agentSet.agentRewardNum}" class="large text"  checkType="float,0"  tip="经纪人奖励红包">
						</c:if>
						<c:if test="${agentSet.agentRewardModel==2}">
							<c:if test="${empty(agentSetLevel) }">
								<input type="text" readonly="readonly"   name="agentRewardNum" id=agentRewardNum	value="${agentSet.agentRewardNum}" class="large text"  checkType="float,0"  tip="经纪人奖励红包">
							</c:if>
							<c:if test="${!empty(agentSetLevel)}">
								<input type="text" readonly="readonly"   name="agentRewardNum" id=agentRewardNum	value="${agentSetLevel.rewardMoney}" class="large text"  checkType="float,0"  tip="经纪人奖励红包">
							</c:if>
						</c:if>
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft" width="120">经纪人奖励积分:&nbsp;</td>
					<td colspan="" >
						<input type="text" readonly="readonly"   name="pointNum" id="pointNum"	value="0" class="large text"  checkType="float,0"  tip="商业险返利">
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">上级经纪人奖励状态:&nbsp;</td>
					<td colspan="3" >
						<c:if test="${agentSet.agentRewardParentStatus==1 }">
							<span style="color: green">开启</span>
						</c:if>
						<c:if test="${agentSet.agentRewardParentStatus==2 }">
							<span style="color: red">停用</span>
						</c:if>
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">上级红包奖励红包:&nbsp;</td>
					<td colspan="3" >
						<input type="text" readonly="readonly"   name="agentRewardParentNum" id=agentRewardParentNum	value="${agentSet.agentRewardParentNum}" class="large text"  checkType="float,0"  tip="商业险返利">
						<span style="color: red;">*</span>
					</td>
				</tr>
				<%-- <tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">内容:&nbsp;</td>
					<td colspan="3" width="1000">
						<textarea class="text" rows="9" cols="" id="note" name="insuranceRecord.note" style="width: 98%;height: 50px;">${insuranceRecord.note }</textarea>
					</td>
				</tr> --%>
			</table>
	</form>
	<div class="formButton">
		<c:if test="${agentSet.agentRewardStatus==2 }">
			<span style="color: red;">系统停止推荐经纪人奖励</span>
		</c:if>
		<c:if test="${agentSet.agentRewardStatus==1 }">
			<a href="javascript:void(-1)"	onclick="if(vali()){$.utile.submitForm('frmId','${ctx}/recommendCustomer/saveReward')}"	class="but butSave">保&nbsp;&nbsp;存</a>
		</c:if> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
	function vali(){
		var status=confirm("您确定发送经纪人奖励吗？改操作不可撤销。请确定");
		return status
	}
</script>
</html>