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
<title>车辆入库</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/factoryOrder/queryList'">车辆入库</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(factoryOrder) }">入库添加</c:if>
	<c:if test="${!empty(factoryOrder) }">编辑库存</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="factoryOrder.dbid" id="dbid" value="${factoryOrder.dbid }">
		<input type="hidden" name="directType" id="directType" value="${param.directType }">
		<input type="hidden" name="customerId" id="customerId" value="${param.customerId }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td id="carModelLabel">
						<select id="brandId" name="brandId" class="small text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${factoryOrder.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
						<select id="carSeriyId" name="carSeriyId" class="small text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${factoryOrder.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							</c:forEach>
						</select>
						<select id="carModelId" name="carModelId" class="small text" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }" ${factoryOrder.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
							</c:forEach>
						</select>
					</td>
					<td class="formTableTdLeft">购车颜色:&nbsp;</td>
					<td id="carColorLable">
						<select id="carColor" name="carColor" class="midea text"  checkType="integer,1">
							<option value="0">请选择...</option>
							<c:forEach var="carColor" items="${carColors }">
								<option value="${carColor.dbid }" ${factoryOrder.carColor.dbid==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
							</c:forEach>
						</select>
						<span style="color: red">*</span>
					</td>
			</tr>
			<c:if test="${empty(factoryOrder) }">
				<tr height="42">
					<td class="formTableTdLeft">vin码:&nbsp;</td>
					<td ><input type="text" name="factoryOrder.vinCode" id="vinCode"
						value="${factoryOrder.vinCode }" class="largeX text" title="vin码"	checkType="string,17,17" tip="vin码不能为空,且为17位"><span style="color: red;">*</span></td>
					<td class="formTableTdLeft">工厂订单日期:&nbsp;</td>
					<td >
					<input type="text" readonly="readonly" name="factoryOrder.factoryOrderDate" id="factoryOrderDate"
						value="${factoryOrder.factoryOrderDate }" class="largeX text" title="工厂订单日期" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'});"	checkType="string,1,50" tip="工厂订单日期不能为空"><span style="color: red;">*</span></td>
				</tr>
			</c:if>
			<c:if test="${!empty(factoryOrder) }">
				<tr height="42">
					<td class="formTableTdLeft">vin码:&nbsp;</td>
					<td ><input type="text" readonly="readonly" name="factoryOrder.vinCode" id="vinCode"
						value="${factoryOrder.vinCode }" class="largeX text" title="vin码"	checkType="string,17,17" tip="vin码不能为空,且为17位"><span style="color: red;">*</span></td>
					<td class="formTableTdLeft">工厂订单日期:&nbsp;</td>
					<td ><input type="text" readonly="readonly" name="factoryOrder.factoryOrderDate" id="factoryOrderDate"
						value="${factoryOrder.factoryOrderDate }" class="largeX text" title="工厂订单日期" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'});"	checkType="string,1,50" tip="工厂订单日期不能为空"><span style="color: red;">*</span></td>
				</tr>
			</c:if>
			<tr height="42">
				<td class="formTableTdLeft">工厂指导价${factoryOrder.factoryRebateState }:&nbsp;</td>
				<td ><input type="text" name="factoryOrder.factoryPrice" id="factoryPrice" ${(factoryOrder.factoryRebateState>1||empty(factoryOrder.factoryRebateState))?'':'readonly="readonly"'} value="${factoryOrder.factoryPrice }" class="largeX text" title="工厂指导价" onblur="addZero('factoryPrice',this.value)" checkType="string,1,50" tip="工厂指导价不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">单车成本:&nbsp;</td>
				<td ><input type="text" name="factoryOrder.purchasePrice" id="purchasePrice"
					value="${factoryOrder.purchasePrice }" class="largeX text" title="单车成本价" onblur="addZero('purchasePrice',this.value)" checkType="string,1,50" tip="单车成本价不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">订单性质:&nbsp;</td>
				<td>
					<select name="factoryOrder.orderAttr" id="orderAttr" class="largeX text" checkType="string,1" tip="请选择单性质">
						<option value="">请选择...</option>
						<option value="寄售订单"  ${factoryOrder.orderAttr=='寄售订单'?'selected="selected"':'' }>寄售订单</option>
						<option value="金融贷款"  ${factoryOrder.orderAttr=='金融贷款'?'selected="selected"':'' }>金融贷款</option>
						<option value="自有资金" ${factoryOrder.orderAttr=='自有资金'?'selected="selected"':'' }>自有资金</option>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">订单种类:&nbsp;</td>
				<td >
					<select name="factoryOrder.orderType" id="orderType" class="largeX text" checkType="string,1" tip="请选择惠民政策">
						<option value="">请选择...</option>
						<option value="手工订单" ${factoryOrder.orderType=='手工订单'?'selected="selected"':'' } >手工订单</option>
						<option value="周订单" ${factoryOrder.orderType=='周订单'?'selected="selected"':'' } >周订单</option>
						<option value=" 增补订单"  ${factoryOrder.orderType==' 增补订单'?'selected="selected"':'' }> 增补订单</option>
						<option value="大客户订单"  ${factoryOrder.orderType=='大客户订单'?'selected="selected"':'' }>大客户订单</option>
						<option value="中转库冲账订单"  ${factoryOrder.orderType=='中转库冲账订单'?'selected="selected"':'' }>中转库冲账订单</option>
						<option value="试乘试驾订单"  ${factoryOrder.orderType=='试乘试驾订单'?'selected="selected"':'' }>试乘试驾订单</option>
						<option value="经销商买卖订单"  ${factoryOrder.orderType=='经销商买卖订单'?'selected="selected"':'' }>经销商买卖订单</option>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">公告车型:&nbsp;</td>
				<td colspan="">
				<input type="text"  name="factoryOrder.sqrNo" id="sqrNo"
					 class="largeX text " title="" value="${factoryOrder.sqrNo}"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">惠民:&nbsp;</td>
				<td >
					<select name="factoryOrder.huimin" id="huimin" class="largeX text" checkType="string,1" tip="请选择惠民政策">
						<option value="">请选择...</option>
						<option value="惠民" ${factoryOrder.huimin=='惠民'?'selected="selected"':'' } >惠民</option>
						<option value="非惠民"  ${factoryOrder.huimin=='非惠民'?'selected="selected"':'' }>非惠民</option>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">惠民金额:&nbsp;</td>
				<td colspan="">
				<input type="text"  name="factoryOrder.huiminMoney" id="huiminMoney" class="largeX text " title="" value="${factoryOrder.huiminMoney}"	></td>
				<td class="formTableTdLeft">直发:&nbsp;</td>
				<td colspan="">
				<input type="text"  name="factoryOrder.directDeliver" id="directDeliver"
					 class="largeX text " title="" value="${factoryOrder.directDeliver}"	checkType="string,1,500" tip="请填写直发数据"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">执行价:&nbsp;</td>
				<td ><input type="text" name="factoryOrder.marketPrice" id="marketPrice"
					value="${factoryOrder.marketPrice }" class="largeX text" title="执行价"	onblur="addZero('marketPrice',this.value)" checkType="string,1,50" tip="执行价不能为空，且为15位"><span style="color: red;">*请核实车辆入库价格</span></td>
				<td class="formTableTdLeft">原始进货商:&nbsp;</td>
				<td >
					<c:if test="${empty(factoryOrder) }">
						<select  id="sourceCompanyId" name="sourceCompanyId" class="largeX text" checkType="integer,1" tip="请选择原始进货商">
							<option value="-1">请选择...</option>
							<c:forEach var="enterprise" items="${enterprises }">
								<option value="${enterprise.dbid }" ${enterprise.dbid==enter.dbid?'selected="selected"':'' } >${enterprise.name }</option>
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${factoryOrder.carStatus==1 }">
						<select  id="sourceCompanyId" name="sourceCompanyId" class="largeX text" checkType="integer,1" tip="请选择原始进货商">
							<option value="-1">请选择...</option>
							<c:forEach var="enterprise" items="${enterprises }">
								<option value="${enterprise.dbid }" ${enterprise.dbid==factoryOrder.sourceCompany.dbid?'selected="selected"':'' } >${enterprise.name }</option>
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${factoryOrder.carStatus>1 }">
						<input type="hidden" id="sourceCompanyId" name="sourceCompanyId" value="${factoryOrder.sourceCompany.dbid }" readonly="readonly">
						<input type="text" value="${factoryOrder.sourceCompany.name}" class="largeX text" >
					</c:if>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车辆来源:&nbsp;</td>
				<td>
					<select  id="carFromId" name="carFromId" class="largeX text" checkType="integer,1" tip="请选择车辆来源">
							<option value="-1">请选择...</option>
							<c:forEach var="carFrom" items="${carFroms }">
								<option value="${carFrom.dbid }" ${carFrom.dbid==factoryOrder.carFrom.dbid?'selected="selected"':'' } >${carFrom.name }</option>
							</c:forEach>
						</select>
				</td>
			</tr>
			<tr height="42">
			<td class="formTableTdLeft">物料号:&nbsp;</td>
				<td ><input type="text" name="factoryOrder.materialNumber" id="materialNumber"
					value="${factoryOrder.materialNumber }" class="largeX text" title="物料号"	 ><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">物料描述:&nbsp;</td>
				<td colspan="">
				<textarea  name="factoryOrder.materialDes" id="materialDes"
					 class="largeX text textarea" title="物料描述"	checkType="string,1,500" tip="物料描述不能为空" style="width: 85%">${factoryOrder.materialDes }</textarea><span style="color: red;">*</span></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/factoryOrder/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
	//金额数据输入完成后添加.00
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
	}
</script>
</html>