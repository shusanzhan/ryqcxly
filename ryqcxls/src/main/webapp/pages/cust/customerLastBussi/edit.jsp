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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
	<div class="alert alert-error ">
		<strong>提示!</strong>成交客户系统将会把客户级别更改为O级，流失客户系统将会把客户级别更改为L级
	</div>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${not empty(customerLastBussi) }">
			<input type="hidden" name="customerId" value="${customerLastBussi.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerLastBussi) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
		<input type="hidden" name="customerLastBussi.dbid" id="dbid" value="${customerLastBussi.dbid }">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">结案情形:&nbsp;</td>
				<td colspan="1">
					<select id="lastResult" name="lastResult" class="largeX text" onchange="showHiden()" checkType="integer,1">
						<option value="0">请选择...</option>
						<option value="1" ${customer.lastResult==1?'selected="selected"':'' }>成交——购车</option>
						<option value="2" ${customer.lastResult==2?'selected="selected"':'' }>战败</option>
					</select>
					<span style="color: red">*</span>
				</td>
			</tr>
			<tbody id="customerFlowReasonTr" style="display: none;">
				<tr  height="42">
					<td class="formTableTdLeft">流失原因:&nbsp;</td>
					<td >
						<select id="customerFlowReasonId" name="customerFlowReasonId" class="largeX text"  >
							<option value="0">请选择...</option>
							<c:forEach var="customerFlowReason" items="${customerFlowReasons }">
								<option value="${customerFlowReason.dbid }" >${customerFlowReason.name }</option>
							</c:forEach>
						</select>
						<span style="color: red">*</span>
					</td>
				</tr>
			</tbody>
			<tbody id="contentTr" style="display: none;">
				<tr  height="42" >
					<td class="formTableTdLeft">购买车型:&nbsp;</td>
					<td id="carModelLabel">
						<select id="brandId" name="brandId" class="small text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${customerBussi.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
						<select id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${customerBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							</c:forEach>
						</select>
						<select id="carModelId" name="carModelId" class="mideaX text" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }" ${customerBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr  height="42">
					<td class="formTableTdLeft">购车颜色:&nbsp;</td>
					<td id="carColorLable">
						<select id="carColor" name="carColor" class="largeX text"  checkType="integer,1">
							<option value="0">请选择...</option>
							<c:forEach var="carColor" items="${carColors }">
								<option value="${carColor.dbid }" >${carColor.name }</option>
							</c:forEach>
						</select>
						<span style="color: red">*</span>
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">是否上牌:&nbsp;</td>
					<td colspan="1">
						<label><input type="checkbox" id="isCarPlate" name="customerLastBussi.isCarPlate" value="true" ${customerLastBussi.isCarPlate==true?'checked="checked"':'' } >&nbsp;&nbsp;是否上牌</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="checkbox" id="isBuySafe" name="customerLastBussi.isBuySafe" ${customerLastBussi.isBuySafe==true?'checked="checked"':'' }  value="true">&nbsp;&nbsp;是否购买保险</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="checkbox" id="isBoutique" name="customerLastBussi.isBoutique" ${customerLastBussi.isBoutique==true?'checked="checked"':'' }  value="true">&nbsp;&nbsp;是否加装精品</label>
					</td>
				</tr> 
			</tbody>
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="1">
					<textarea  name="customerLastBussi.note" id="note"	 class="textarea largeXX text"  title="" checkType="string,2" tip="请填写一点备注吧">${customerLastBussi.note }</textarea>	
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="if(validate1()){$.utile.submitAjaxForm('frmId','${ctx}/customerLastBussi/save')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a id="approvalButton" style="display: none;" href="javascript:void(-1)"	onclick="if(validate2()){$.utile.submitAjaxForm('frmId','${ctx}/customerLastBussi/save')}"	class="but butSave">提交经理审核</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取&nbsp;&nbsp;消</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function validate1(){
		var carseriyId=$("#carSeriyId").val();
		$("#carColor").attr("checkType","integer,1");
		if(null==carseriyId||carseriyId==""){
			alert("请选择意向车型！");
			$("#carSeriyId").focus();
			return false;
		}
		var carModelId=$("#carModelId").val();
		if(null==carModelId||carModelId==""){
			alert("请选择意向车型！");
			$("#carModelId").focus();
			return false;
		}
		return true;
	}
	function validate2(){
		var customerFlowReasonId=$("#customerFlowReasonId").val();
		if(null==customerFlowReasonId||customerFlowReasonId==""||customerFlowReasonId=="0"){
			alert("请选择流失原因！");
			return false;
		}
		var note=$("#note").val();
		$("#carColor").removeAttr("checkType");
		if(null==note||note==""){
			alert("请输入备注信息！");
			$("#note").focus();
			return false;
		}
		return true;
	}
	function showHiden(){
		var options=$("#lastResult option:selected");
		var value=options[0].value;
		if(value==1){
			$("#contentTr").show();
			$("#saveButton").show();
			$("#approvalButton").hide();
			$("#customerFlowReasonTr").hide();
			
		}else{
			$("#customerFlowReasonTr").show();
			$("#contentTr").hide();
			$("#saveButton").hide();
			$("#carColor").val("    ")
			$("#approvalButton").show();
		}
	}
	
	function ajaxCarSeriy(val){
		if(null==val||val==''){
			alert("请选择品牌");
			return false;
		}
		$("#carModelId").remove();
		$("#carSeriyId").remove();
		$.post("${ctx}/carSeriy/ajaxCarSeriyByStatus?brandId="+val+"&dateTime="+new Date(),{},function (data){
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
		$.post("${ctx}/carModel/ajaxCarModelBySeriyStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carModelLabel").append(data);
			}
		});
		$.post("${ctx}/carColor/ajaxCarColorStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carColorLable").append(data);
			}
		});
	}
</script>
</html>