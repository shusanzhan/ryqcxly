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
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/insCustomer/queryWatingList'">待买客户</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(insCustomer) }">保险单</c:if>
	<c:if test="${!empty(insCustomer) }">保险单</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="insCustomerId" id="insCustomerId" value="${insCustomer.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">客户信息</td>
				</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td width="34%">
					<input type="text" class="text large" id="name" name="insCustomer.name" value="${insCustomer.name }" checkType="string,1" tip="请输入客户姓名">
					<span style="color: red;">*</span>
					<c:if test="${empty(insCustomer) }">
						<label><input type="radio" id="sex" name="insCustomer.sex" value="男"  checked="checked">男</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="insCustomer.sex" value="女" >女</label>
					</c:if>
					<c:if test="${!empty(insCustomer) }">
						<label><input type="radio" id="sex" name="insCustomer.sex" value="男" ${insCustomer.sex=='男'?'checked="checked"':'' }>男</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="insCustomer.sex" value="女" ${insCustomer.sex=='女'?'checked="checked"':'' } >女</label>
					</c:if>
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td width="34%">
					<input type="text" class="text large" id="mobilePhone" name="insCustomer.mobilePhone" value="${insCustomer.mobilePhone }" checkType="mobilePhone" tip="请输入电话号码">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" class="text large" id="carName" name="insCustomer.carName" value="${insCustomer.carName }" checkType="string,1,300" tip="车型不能为空">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">车辆型号:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" class="text large" id="sqrNo" name="insCustomer.sqrNo" value="${insCustomer.sqrNo }" checkType="string,1,300" tip="车辆型号不能为空">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">vin码:&nbsp;</td>
				<td >
					<input type="text" class="text large" id="vinCode" name="insCustomer.vinCode" value="${insCustomer.vinCode }" checkType="string,17,17" tip="vin码不能为空">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td id="carModelLabel" >
					<input id="carPlateNo" class="large text"   name="insCustomer.carPlateNo" value="${insCustomer.carPlateNo }"  checkType="string,5"  tip="车牌号不能为空">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">签订日期:&nbsp;</td>
					<td colspan="1">
						<input type="text" name="insuranceRecord.buyDate" id="buyDate"	value="${insuranceRecord.buyDate }" class="large text"  title="签订日期" onfocus="new WdatePicker()"	checkType="string,1,50"  tip="签订日期不能为空">
					</td>
				<td class="formTableTdLeft">购车日期:&nbsp;</td>
				<td width="34%" colspan="1">
					<input id="insCustomerbuyDate" value="${insCustomer.buyDate }" name="insCustomer.buyDate" class="large text"  onfocus="new WdatePicker()"  checkType="string,1,50"  tip="购车日期不能为空">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">销售人员:&nbsp;</td>
				<td width="34%" colspan="1">
					<input type="text" name="insCustomer.salerName" id="salerName"	value="${insCustomer.salerName }" onfocus="autoUser('saler')" class="large text" title="销售员"	checkType="string,1"  tip="销售员不能为空">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">出单店:&nbsp;</td>
				<td colspan="">
					<select id="insEnterpriseId" name="insEnterpriseId" class="text large" checkType="integer,1" tip="请选择出单店">
							<option value="">请选择...</option>
							<c:forEach var="enterprise" items="${enterprises }">
								<option value="${enterprise.dbid }" ${enterprise.dbid==sessionScope.user.enterprise.dbid?'selected="selected"':'' }>${enterprise.name }</option>
							</c:forEach>
						</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td width="34%" colspan="3">
					<textarea rows="" cols="" id="note" class="large text"  name="insCustomer.note" style="height: 60px;width: 80%;margin: 5px;"></textarea>
				</td>
			</tr>
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">基础信息</td>
				</tr>
				<tr>
					<td class="formTableTdLeft" width="120">客户类型:&nbsp;</td>
					<td colspan="3">
						<select id="insType" name="insuranceRecord.insType" class="text large" checkType="integer,1" tip="请选择出单公司" onchange='changeInsType()'>
							<option value="-1">请选择...</option>
							<option value="1" ${param.type==1?'selected="selected"':'' }>新车保险</option>
							<option value="2"  ${param.type==2?'selected="selected"':'' } >续保</option>
						</select>
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" >出单公司:&nbsp;</td>
					<td colspan="" width="34%">
						<input type="hidden" name="type"  id="type" value="${param.type }">
						<input type="hidden" name="insuranceRecord.totalPrice"  id="totalPrice" value="0.0">
						<input type="hidden" name="resourceTotalPrice"  id="resourceTotalPrice" value="0.0">
						<input type="hidden" name="insuranceRecord.dbid"  id="dbid" value="">
						<input type="hidden" name="insuranceRecord.rebateMoney"  id="rebateMoney" value="0.0">
						<input type="hidden" name="insuranceRecord.incidentalInterestMoney"  id="incidentalInterestMoney" value="0.0">
						<!-- 用于计算返利 基础数据 -->
						<input type="hidden" name="busiRiskPer"  id="busiRiskPer" value="0.0">
						<input type="hidden" name="strongRiskPer"  id="strongRiskPer" value="0.0">
						
						<input type="hidden" name="insuranceRecord.busiRiskRebateMoney"  id="busiRiskRebateMoney" value="0.0">
						<input type="hidden" name="insuranceRecord.strongRiskRebateMoney"  id="strongRiskRebateMoney" value="0.0">
						<input type="hidden" name="nonDeductiblePriceTotal"  id="nonDeductiblePriceTotal" value="0.0">
						<select id="insuranceCompanyId" name="insuranceCompanyId" class="text large" checkType="integer,1" tip="请选择出单公司" onchange="chanageInsuranceCompany(this.value)">
							<option value="">请选择...</option>
							<c:forEach var="insuranceCompany" items="${insuranceCompanies }">
								<option value="${insuranceCompany.dbid }" ${insuranceCompany.dbid==insuranceRecord.insuranceCompany.dbid?'selected="selected"':'' }>${insuranceCompany.name } </option>
							</c:forEach>
						</select>
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft" >出单渠道:&nbsp;</td>
					<td colspan="" width="34%">
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
					<td class="formTableTdLeft" >起保日期:&nbsp;</td>
					<td colspan="" width="34%">
						<input id="beginDate" class="large text"  onfocus="new WdatePicker();addYear(this.value)" name="insuranceRecord.beginDate" value="${insuranceRecord.beginDate }" checkType="string,1,50"  tip="起保日期不能为空">
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">脱保日期:&nbsp;</td>
					<td width="34%">
						<input type="text" name="insuranceRecord.endDate" id="endDate"	value="${insuranceRecord.endDate }" class="large text"  title="脱保日期" onfocus="new WdatePicker()"	checkType="string,1,50"  tip="脱保日期不能为空">
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" width="120">强制险:&nbsp;</td>
					<td colspan="" >
						<input id="strongRiskPrice" class="large text"   name="insuranceRecord.strongRiskPrice" value="${insuranceRecord.strongRiskPrice }" onkeyup="getTotalPrice()" checkType="float,0"  tip="强制险不能为空">
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">商业险:&nbsp;</td>
					<td >
						<input type="text" name="insuranceRecord.busiRiskPrice" id="busiRiskPrice"	value="${insuranceRecord.busiRiskPrice }" class="large text" onkeyup="getTotalPrice()" checkType="float,0"  tip="商业险不能为空">
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft">操作人:&nbsp;</td>
					<td colspan="3"><input type="text" readonly="readonly" class="large text"  name="creatorName" id="creatorName"	value="${sessionScope.user.realName }" checkType="string,1,50"  tip="起保日期日期不能为空"></td>
				</tr>
				<tr style="height: 40px;" height="40">
					<td class="formTableTdLeft" >内容:&nbsp;</td>
					<td colspan="3" width="1000">
						<textarea class="text" rows="9" cols="" id="note" name="insuranceRecord.note" style="width: 98%;height: 50px;">${insuranceRecord.note }</textarea>
					</td>
				</tr>
			</table>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="5" style="">商业险</td>
				</tr>
				<tr height="32">
					<td width="180" align="center">款项&nbsp;
						<label>
							<input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'bussiInsuranceItemId')" /><span id="selectText">取消</span>
						</label>
					</td>
					<td width="220" align="center">选项</td>
					<td width="200" align="center">不计免赔</td>
					<td width="240" align="center">明细</td>
				</tr>
				<c:forEach var="insuranceItem" items="${bussiInsuranceItems }" varStatus="questIndex">
						<tr height="40" style="height: 40px;">
							<td  width="200">
								<label>
									<input type="checkbox" onclick="onclickItem(this)" name="bussiInsuranceItemId" id="id1"   value="${insuranceItem.dbid }"> ${insuranceItem.name }
								</label>
							</td>
							<td  width="220">
								<c:if test="${insuranceItem.singleStatus==2 }">
									<c:forEach var="insuranceItemChoice" items="${insuranceItem.insuranceItemChoices }" varStatus="itemIdex">
										<c:if test="${itemIdex.index==0 }">
											<label>
												<input type="radio" name="resultValue${insuranceItem.dbid }" id="bus${questIndex.index+1 }" value="${insuranceItemChoice.dbid }" >${insuranceItemChoice.lable }&nbsp;&nbsp;</label>
										</c:if>
										<c:if test="${itemIdex.index!=0 }">
											<label>
												<input type="radio" name="resultValue${insuranceItem.dbid }" id="bus${questIndex.index+1 }" value="${insuranceItemChoice.dbid }" checked="checked">${insuranceItemChoice.lable }&nbsp;&nbsp;</label>
										</c:if>
									</c:forEach>
								</c:if>
							</td>
							<td width="200">
								<c:if test="${insuranceItem.nonDeductibleStatus==2 }">
									<input type="hidden" name="nonDeductiblePer${insuranceItem.dbid }" id="nonDeductiblePer${insuranceItem.dbid }" value="${insuranceItem.nonDeductiblePer }" >
									<label>
										<input type="radio" onclick="" name="nonDeductibleStatus${insuranceItem.dbid }" id="nonDeductibleStatus${insuranceItem.dbid }" value="1" >否&nbsp;&nbsp;
									</label>
									<label>
										<input type="radio" onclick="" name="nonDeductibleStatus${insuranceItem.dbid }" id="nonDeductibleStatus${insuranceItem.dbid }" value="2" checked="checked">是&nbsp;&nbsp;
									</label>
								</c:if>
							</td>
							<td width="240">
								${insuranceItem.details }
							</td>
						</tr>
				</c:forEach>
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="5" style="text-align: right;padding-right: 12px;">总计：<span style="font-size: 20px;color: red;margin:0 5px;" id="totalPriceText">0</span>元</td>
				</tr>
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="5" style="text-align: right;padding-right: 12px;">返利合计:<span id="strongRiskPerText">强制险*%</span>+<span id="busiRiskPerText">商业险*%</span>=<span style="font-size: 20px;color: red;margin:0 5px;" id="rebateMoneyText">0</span>元</td>
				</tr>
			</table>
			
			<div id='te' style="width: 100%">
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
			</div>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/insuranceRecord/saveInsCustomerAndInsuranceRecord')"	class="but butSave">保&nbsp;&nbsp;存</a> 
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
				$("#selectText").text("");
				$("#selectText").text("取消");
				$(doms[i]).parent().addClass("checked");
			}else{
				$("#selectText").text("");
				$("#selectText").text("全选");
				$(doms[i]).parent().removeClass("checked");
			}
		}
	}
}
function onclickItem(checkbox){
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
	//$("#busiRiskPrice").val(totalPrice);
	//$("#busiRiskPriceText").text(totalPrice);
	
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
function changeInsType(){
	var insuranceCompanyId=$("#insuranceCompanyId").val();
	if(insuranceCompanyId==undefined||insuranceCompanyId==''){
		
	}else{
		chanageInsuranceCompany(insuranceCompanyId)
	}
}
function chanageInsuranceCompany(value){
	var insType=$("#insType").val();
	if(insType==undefined||insType=='-1'){
		alert("请先选择客户类型");
		return ;
	}
	$.post('${ctx}/insuranceCompany/autoInsuranceCompany?dbid='+value+"&dateTime="+new Date(),{},function(data){
		if(data.error=="error"){
			$("#busiRiskPer").val(0);
			$("#strongRiskPer").val(0);
			$("#busiRiskPerText").text(0);
			$("#strongRiskPerText").text(0);
		}else{
			if(insType==1){
				$("#busiRiskPer").val(data.busiRiskPer);
				$("#strongRiskPer").val(data.strongRiskPer);			
				$("#busiRiskPerText").text("商业险*"+data.busiRiskPer+"%");
				$("#strongRiskPerText").text("强制险*"+data.strongRiskPer+"%");
			}
			if(insType==2){
				$("#busiRiskPer").val(data.gonnaBusiRiskPer);
				$("#strongRiskPer").val(data.gonnaStrongRiskPer);
				$("#busiRiskPerText").text("商业险*"+data.gonnaBusiRiskPer+"%");
				$("#strongRiskPerText").text("强制险*"+data.gonnaStrongRiskPer+"%");
			}	
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
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelId").remove();
	$("#carSeriyId").remove();
	$.post("${ctx}/carSeriy/ajaxCarSeriy?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}

function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	$("#carColorLable").children().remove();
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/carModel/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
	$.post("${ctx}/carColor/ajaxCarColor?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carColorLable").append(data);
		}
	});
}
function autoUser(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/user/ajaxUser",{
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
		       return "<span>用户Id："+row.userId+"&nbsp;&nbsp;&nbsp;名称："+row.name+"&nbsp;&nbsp;</span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect2);
	//计算总金额
}

function onRecordSelect2(event, data, formatted) {
		$("#salerName").val(data.name);
}
</script>
</html>