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
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
</style>
<title>工厂返利</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/factoryOrder/queryList'">车辆入库</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(rebateAndFinance) }">工厂返利添加</c:if>
	<c:if test="${!empty(rebateAndFinance) }">编辑工厂返利</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<%--  <input type="hidden" name="rebateAndFinance.factoryOrder.dbid" id="factoryOrder.dbid" value="${factoryOrder.dbid}"> --%>
		<input type="hidden" name="rebateAndFinance.vinCode" id="vinCode" value="${param.vinCode }">
		<input type="hidden" name="rebateAndFinance.dbid" id="dbid" value="${rebateAndFinance.dbid }">
		<input type="hidden" name="factoryOrderDbid" id="factoryOrderDbid" value="${factoryOrder.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">基本返利比例:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.basicRebate" class="largeX text" id="basicRebate" value="${rebateAndFinance.basicRebate}">%
					</td>
					<td class="formTableTdLeft">基本返利金额:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.basicRebateMoney" class="largeX text" id="basicRebateMoney" value="${rebateAndFinance.basicRebateMoney}">
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">广告返利比例:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.advertisingRebate" class="largeX text" id="advertisingRebate" value="${rebateAndFinance.advertisingRebate}">%
					</td>
					<td class="formTableTdLeft">广告返利金额:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.advertisingRebateMoney" class="largeX text" id="advertisingRebateMoney" value="${rebateAndFinance.advertisingRebateMoney}">
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">大客户返利比例:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.bigCustomerRebate" class="largeX text" id="bigCustomerRebate" value="${rebateAndFinance.bigCustomerRebate}">%
					</td>
					<td class="formTableTdLeft">大客户返利金额:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.bigCustomerRebateMoney" class="largeX text" id="bigCustomerRebateMoney" value="${rebateAndFinance.bigCustomerRebateMoney}">
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">建店返利比例:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.buildAshopRebate" class="largeX text" id="buildAshopRebate" vlaue="${rebateAndFinance.buildAshopRebate}">%
					</td>
					<td class="formTableTdLeft">建店返利金额:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.buildAshopRebateMoney" class="largeX text" id="buildAshopRebateMoney" value="${rebateAndFinance.buildAshopRebateMoney}">
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">月度返利比例:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.monthlyRebate" class="largeX text" id="monthlyRebate" value="${rebateAndFinance.monthlyRebate}">%
					</td>
					<td class="formTableTdLeft">月度返利金额:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.monthlyRebateMoney" class="largeX text" id="monthlyRebateMoney" value="${rebateAndFinance.monthlyRebateMoney }">
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">促销返利金额:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.promotionRebateMoney" class="largeX text" id="promotionRebateMoney" value="${rebateAndFinance.promotionRebateMoney}">
					</td>
					<td class="formTableTdLeft">实销返利金额:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.realSaleMoney" class="largeX text" id="realSaleMoney" value="${rebateAndFinance.realSaleMoney}">
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">置换返利金额:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.substitutionRebateMoney" class="largeX text" id="substitutionRebateMoney" value="${rebateAndFinance.substitutionRebateMoney}">
					</td>
					<td class="formTableTdLeft">金融返利金额:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.financeRebateMoney" class="largeX text" id="financeRebateMoney" value="${rebateAndFinance.financeRebateMoney}">
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">其他返利金额:&nbsp;</td>
				<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.otherRebateMoney" class="largeX text" id="otherRebateMoney" value="${rebateAndFinance.otherRebateMoney}">
					</td>
					<td class="formTableTdLeft">溢价:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.premium" class="largeX text" id="premium" value="${rebateAndFinance.premium}">
					</td>
			</tr>
			<tr height="42">
					<td class="formTableTdLeft">返利合计:&nbsp;</td>
					<td id="carColorLable">
						<input type="text" name="rebateAndFinance.totalRebate" class="largeX text" id="totalRebate" value="${rebateAndFinance.totalRebate}">
					</td>
					<td class="formTableTdLeft">操作人:&nbsp;</td>
					<td id="carModelLabel">
					<input type="text" name="rebateAndFinance.oparetor" class="largeX text" id="oparetor" value="${sessionScope.user.realName}" readonly="readonly">
					</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/factoryOrder/saveRebate')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
	/* //金额数据输入完成后添加.00
	function addZero(id,value){
		if(undefined!=value&&value!=''){
			if(value.indexOf(".0")<0){
				$("#"+id).val(value+".00");
			}
		}
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
	} */
</script>
</html>