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
<form action="" id="frmId" name="frmId" method="post">
	<input type="hidden" name="type" id="type" value="">
	<input type="hidden" name="orderBuySalerDbid" id="orderBuySalerDbid" value="${orderBuySaler.dbid }">
	<input type="hidden" name="factoryOrderDbid" id="factoryOrderDbid" value="${factoryOrder.dbid }">
	<input type="hidden" name="orderBuySalerExpressId" id="orderBuySalerExpressId" value="${orderBuySalerExpress.dbid }">
	<input type="hidden" name="approvalStatus" id="approvalStatus" value="">
	<div class="frmTitle" onclick="showOrHiden('contactTable')">结算单</div>
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
						<tr >
							<td style="text-align: center;">
								1
							</td>
							<td style="text-align: center;">车辆</td>
							<td >
								${orderBuySalerExpress.carStatementPrice }
							<td>
								${orderBuySalerExpress.carBuyPrice}
							</td>
							<td style="text-align: center;">
								${orderBuySalerExpress.carStatementNote }
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								2
							</td>
							<td style="text-align: center;">装饰</td>
							<td >
								${orderBuySalerExpress.decorePrice }
							</td>
							<td>
								${orderBuySalerExpress.decoreCostPrice }
							</td>
							<td style="text-align: center;">
								${orderBuySalerExpress.decoreNote }
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								3
							</td>
							<td style="text-align: center;">金融</td>
							<td >
								${orderBuySalerExpress.finPrice }
							</td>
							<td>
								${orderBuySalerExpress.finCostPrice }
							</td>
							<td style="text-align: center;">
								${orderBuySalerExpress.finNote }
							</td>
						</tr>
						<tr >
							<td style="text-align: center;">
								4
							</td>
							<td style="text-align: center;">其他</td>
							<td >
								${orderBuySalerExpress.otherPrice }
							</td>
							<td>
								${orderBuySalerExpress.otherCostPrice }
							</td>
							<td style="text-align: center;">
								${orderBuySalerExpress.otherNote }
							</td>
						</tr>
					<tr height="32">
						<td class="formTableTdLeft">备注:&nbsp;</td>
						<td colspan="4">
							${orderBuySalerExpress.note }
						</td>
					</tr>
					<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="5" style="text-align: right;padding-right: 12px;">总计：<span style="font-size: 20px;color: red;margin:0 5px;" id="totalPriceText">${orderBuySalerExpress.totalAmountPrice }</span>元</td>
					</tr>
				</tbody>
			</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">审批意见</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px">
				<tr height="32">
				<td class="formTableTdLeft">审批意见:&nbsp;</td>
				<td colspan="3">
					<textarea  name="sug" id=sug title="内容简介"  class="largeXX text" style="height: 60px;width: 92%;" checkType="string,2" tip="审批意见"></textarea>
				</td>
			</tr>
		</table>
<div class="formButton">
	<a id="submit" class="but butSave" href="javascript:void(-1)" onclick="$('#approvalStatus').val(2);$.utile.submitAjaxForm('frmId','${ctx}/orderBuySalerExpress/saveApproval')">
		同意
	</a>
	<a id="submit" class="but butSave" href="javascript:void(-1)" onclick="$('#approvalStatus').val(3);$.utile.submitAjaxForm('frmId','${ctx}/orderBuySalerExpress/saveApproval')">
		驳回
	</a>
	<a class="but butCancle" onclick="window.history.go(-1)">返回</a>
</div>
</form>	
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
</script>
</html>
