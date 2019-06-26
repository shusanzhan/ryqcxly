<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>经销商买卖结算单</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1)" class="current">经销商买卖结算单</a>
</div>
<div class="line"></div>
<div class="frmContent">
<c:if test="${orderBuySalerExpress.approvalStatus==3 }">
	<div class="alert alert-error">
		 <p>审批结果：审批驳回 </p>
		 <p>审批人：${orderBuySalerExpress.approvalPerson } 审批日期：${orderBuySalerExpress.approvalDate }</p>
		 <p>审批意见：${orderBuySalerExpress.approvalNote } </p>
	</div>
</c:if>
<form action="" id="frmId" name="frmId" method="post">
	<input type="hidden" name="type" id="type" value="${param.type }">
	<input type="hidden" name="orderBuySalerDbid" id="orderBuySalerDbid" value="${orderBuySaler.dbid }">
	<input type="hidden" name="factoryOrderDbid" id="factoryOrderDbid" value="${factoryOrder.dbid }">
	<input type="hidden" name="orderBuySalerExpress.dbid" id="dbid" value="${orderBuySalerExpress.dbid }">
	<input type="hidden" name="orderBuySalerExpress.createDate" id="createDate" value="${orderBuySalerExpress.createDate }">
			<table id="chargeItem" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;" >
				<thead>
					<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 30px;text-align: center;">序号</th>
						<th style="width: 80px;text-align: center;">结算项目</th>
						<th style="width: 80px;text-align: center;">结算金额</th>
						<th style="width: 80px;text-align: center;">成本</th>
						<th style="width: 160px;text-align: center;">备注</th>
					</tr>
				</thead>
				<tbody style="overflow: scroll;">
					<c:if test="${empty(orderBuySalerExpress) }">
						<tr >
							<td style="text-align: center;">
								1
							</td>
							<td style="text-align: center;">车辆</td>
							<td >
								<input type="text" name="orderBuySalerExpress.carStatementPrice" id="carStatementPrice" value="${factoryOrder.purchasePrice }"  onfocus="jisuan()" onchange="jisuan()" class="smallX text" style="width: 92%;">
							</td>
							<td>
								<input type="text" name="orderBuySalerExpress.carBuyPrice" id="carBuyPrice" value="${factoryOrder.purchasePrice}" class="smallX text" style="width: 92%;" onfocus="jisuan()" onchange="jisuan()">
							</td>
							<td style="text-align: center;">
								<input type="text"  name="orderBuySalerExpress.carStatementNote" id="carStatementNote" value="车辆平过" class="smallX text" style="width: 92%;" >
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								2
							</td>
							<td style="text-align: center;">装饰</td>
							<td >
								<input type="text" name="orderBuySalerExpress.decorePrice" id="decorePrice" value="0.0" onfocus="jisuan()" onchange="jisuan()" class="smallX text" style="width: 92%;">
							</td>
							<td>
								<input type="text" name="orderBuySalerExpress.decoreCostPrice" id="decoreCostPrice" value="0.0" class="smallX text" style="width: 92%;" onfocus="jisuan()" onchange="jisuan()" >
							</td>
							<td style="text-align: center;">
								<input type="text"  name="orderBuySalerExpress.decoreNote" id="decoreNote" value="${orderBuySalerExpress.decoreNote }" class="smallX text" style="width: 92%;" >
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								3
							</td>
							<td style="text-align: center;">金融</td>
							<td >
								<input type="text" name="orderBuySalerExpress.finPrice" id="finPrice" value="0.0" onfocus="jisuan()" onchange="jisuan()" class="smallX text" style="width: 92%;">
							</td>
							<td>
								<input type="text" name="orderBuySalerExpress.finCostPrice" id="finCostPrice" value="0.0" class="smallX text" style="width: 92%;" onfocus="jisuan()" onchange="jisuan()" >
							</td>
							<td style="text-align: center;">
								<input type="text"  name="orderBuySalerExpress.finNote" id="finNote" value="" class="smallX text" style="width: 92%;" >
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								4
							</td>
							<td style="text-align: center;">其他</td>
							<td >
								<input type="text" name="orderBuySalerExpress.otherPrice" id="otherPrice" value="0.0" onfocus="jisuan()" onchange="jisuan()" class="smallX text" style="width: 92%;">
							</td>
							<td>
								<input type="text" name="orderBuySalerExpress.otherCostPrice" id="otherCostPrice" value="0.0" class="smallX text" style="width: 92%;" >
							</td>
							<td style="text-align: center;">
								<input type="text"  name="orderBuySalerExpress.otherNote" id="otherNote" value="${orderBuySalerExpress.otherNote }" class="smallX text" style="width: 92%;" >
							</td>
						</tr>
					</c:if>
					<c:if test="${!empty(orderBuySalerExpress) }">
						<tr >
							<td style="text-align: center;">
								1
							</td>
							<td style="text-align: center;">车辆</td>
							<td >
								<input type="text" name="orderBuySalerExpress.carStatementPrice" id="carStatementPrice" value="${orderBuySalerExpress.carStatementPrice }" onfocus="jisuan()" onchange="jisuan()" class="smallX text" style="width: 92%;">
							</td>
							<td>
								<input type="text" name="orderBuySalerExpress.carBuyPrice" id="carBuyPrice" value="${orderBuySalerExpress.carBuyPrice}" class="smallX text" style="width: 92%;" >
							</td>
							<td style="text-align: center;">
								<input type="text"  name="orderBuySalerExpress.carStatementNote" id="carStatementNote" value="${orderBuySalerExpress.carStatementNote }" class="smallX text" style="width: 92%;" >
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								2
							</td>
							<td style="text-align: center;">装饰</td>
							<td >
								<input type="text" name="orderBuySalerExpress.decorePrice" id="decorePrice" value="${orderBuySalerExpress.decorePrice }" onfocus="jisuan()" onchange="jisuan()" class="smallX text" style="width: 92%;">
							</td>
							<td>
								<input type="text" name="orderBuySalerExpress.decoreCostPrice" id="decoreCostPrice" value="${orderBuySalerExpress.decoreCostPrice }" class="smallX text" style="width: 92%;" onfocus="jisuan()" onchange="jisuan()" >
							</td>
							<td style="text-align: center;">
								<input type="text"  name="orderBuySalerExpress.decoreNote" id="decoreNote" value="${orderBuySalerExpress.decoreNote }" class="smallX text" style="width: 92%;" >
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								3
							</td>
							<td style="text-align: center;">金融</td>
							<td >
								<input type="text" name="orderBuySalerExpress.finPrice" id="finPrice" value="${orderBuySalerExpress.finPrice }" onfocus="jisuan()" onchange="jisuan()" class="smallX text" style="width: 92%;">
							</td>
							<td>
								<input type="text" name="orderBuySalerExpress.finCostPrice" id="finCostPrice" value="${orderBuySalerExpress.finCostPrice }" class="smallX text" style="width: 92%;" onfocus="jisuan()" onchange="jisuan()" >
							</td>
							<td style="text-align: center;">
								<input type="text"  name="orderBuySalerExpress.finNote" id="finNote" value="${orderBuySalerExpress.finNote }" class="smallX text" style="width: 92%;" >
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								4
							</td>
							<td style="text-align: center;">其他</td>
							<td >
								<input type="text" name="orderBuySalerExpress.otherPrice" id="otherPrice" value="${orderBuySalerExpress.otherPrice }" onfocus="jisuan()" onchange="jisuan()" class="smallX text" style="width: 92%;">
							</td>
							<td>
								<input type="text" name="orderBuySalerExpress.otherCostPrice" id="otherCostPrice" value="${orderBuySalerExpress.otherCostPrice }" class="smallX text" style="width: 92%;" onfocus="jisuan()" onchange="jisuan()" >
							</td>
							<td style="text-align: center;">
								<input type="text"  name="orderBuySalerExpress.otherNote" id="otherNote" value="${orderBuySalerExpress.otherNote }" class="smallX text" style="width: 92%;" >
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px">
			<tr height="42">
				<td class="formTableTdLeft">总结算价:&nbsp;</td>
				<td >
					<c:if test="${empty(orderBuySalerExpress) }">
						<input type="text" readonly="readonly" name="orderBuySalerExpress.totalAmountPrice" id="totalAmountPrice" onkeyup="disMoneyDis(this.value)" value="${factoryOrder.purchasePrice }" class="largeX text" title="折扣率" placeholder="0.0"	checkType="float,1" tip="折扣率不能为空"><span style="color: red;">*</span>
					</c:if>
					<c:if test="${!empty(orderBuySalerExpress) }">
						<input type="text" readonly="readonly"  name="orderBuySalerExpress.totalAmountPrice" id="totalAmountPrice" onkeyup="disMoneyDis(this.value)" value="${orderBuySalerExpress.totalAmountPrice }" class="largeX text" title="折扣率" placeholder="0.0"	checkType="float,1" tip="折扣率不能为空"><span style="color: red;">*</span>
					</c:if>
				</td>
				<td class="formTableTdLeft">总成本:&nbsp;</td>
				<td>
					<c:if test="${empty(orderBuySalerExpress) }">
						<input type="text" readonly="readonly"  name="orderBuySalerExpress.totalCostPrice" id="totalCostPrice" value="${factoryOrder.purchasePrice }" class="largeX text" title="折扣后金额" ><span style="color: red;">*</span>
					</c:if>
					<c:if test="${!empty(orderBuySalerExpress) }">
						<input type="text" readonly="readonly"  name="orderBuySalerExpress.totalCostPrice" id="totalCostPrice" value="${orderBuySalerExpress.totalCostPrice }" class="largeX text" title="折扣后金额" ><span style="color: red;">*</span>
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">预估毛利:&nbsp;</td>
				<td colspan="3">
					<c:if test="${empty(orderBuySalerExpress) }">
						<input type="text" readonly="readonly"  name="orderBuySalerExpress.profitPrice" id="profitPrice" value="0.0" class="largeX text" title="折扣后金额" ><span style="color: red;">*</span>
					</c:if>
					<c:if test="${!empty(orderBuySalerExpress) }">
						<input type="text" readonly="readonly"  name="orderBuySalerExpress.profitPrice" id="profitPrice" value="${orderBuySalerExpress.profitPrice }" class="largeX text" title="折扣后金额" ><span style="color: red;">*</span>
					</c:if>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="orderBuySalerExpress.note" id="note" title="内容简介"  class="largeXX text" style="height: 60px;width: 92%;">${orderBuySalerExpress.note }</textarea>
				</td>
			</tr>
		</table>
<div class="formButton">
	<a id="submit" class="but butSave" href="javascript:void(-1)" onclick="$.utile.submitAjaxForm('frmId','${ctx}/orderBuySalerExpress/save')">
		保存
	</a>
	<a class="but butCancle" onclick="window.history.go(-1)">返回</a>
</div>
</form>	
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
//计算合同金额
function jisuan(){
	var totalAmountPrice=0,totalCostPrice=0;
	
	//结算价
   var carStatementPrice=getValue("carStatementPrice");
   var decorePrice=getValue("decorePrice");
   var finPrice=getValue("finPrice");
   var otherPrice=getValue("otherPrice");
	//成本价
   var carBuyPrice=getValue("carBuyPrice");
   var decoreCostPrice=getValue("decoreCostPrice");
   var finCostPrice=getValue("finCostPrice");
   var otherCostPrice=getValue("otherCostPrice");
   
   totalAmountPrice=carStatementPrice+decorePrice+finPrice+otherPrice;
   totalCostPrice=carBuyPrice+decoreCostPrice+finCostPrice+otherCostPrice;
   $("#totalAmountPrice").val(formatFloat(totalAmountPrice));
   $("#totalCostPrice").val(formatFloat(totalCostPrice));
   $("#profitPrice").val(formatFloat(totalAmountPrice-totalCostPrice));
}


function formatFloat(x) {
    var f_x = parseFloat(x);
    if (isNaN(f_x)) {
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
function getValue(carBuyPrice){
	var dd=$("#"+carBuyPrice).val();
	var ss=0;
	if(null!=dd&&dd!=''){
		dd=parseFloat(dd);
		   if(isNaN(dd)){
			   ss=0; 
		   }else{
			   ss=dd;
		   }
	   }else{
		   ss=0;
	   }
	return ss;
}



</script>
</html>
