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
.frmContent form table tr td {
    padding-left: 5px;
}
.cust{
	padding: 5px 8px;
	border: 1px solid #01AAED;
	color: #01AAED;
	border-radius: 14px;
	margin-right: 5px;
	margin-bottom: 5px;
	margin-top: 5px; 
	display: inline-block;
}
.cust1{
	padding: 5px 8px;
	border: 1px solid orange;
	color: black;
	border-radius: 14px;
	margin-right: 5px;
	margin-bottom: 5px;
	margin-top: 5px; 
	display: inline-block;
	background-color:orange;
}
.dis{
	background-color:yellow;
}
</style>
<title>工厂返利批量录入</title>
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/rebateManagement/rebateEntryEntrance'">工厂返利录入</a>-
	<c:if test="${type eq 1}">
			<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/rebateManagement/queryPresaleEntreyList'">工厂售前返利录入列表</a>-
		</c:if>
		<c:if test="${type eq 2}">
			<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/rebateManagement/queryAfterEntryList'">工厂售后返利录入列表</a>-
		</c:if>
	<%-- <a href="javascript:void(-1);" onclick="window.location.href='${ctx}/rebateManagement/optionRebateType'">返利项目选择-</a> --%>
	<a href="javascript:void(-1);" onclick="javascript:void(-1);">批量录入</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId1" id="frmId1" >
	<input type="hidden" name="rebatePD" id="rebatePD" value="1">
	<div class="frmTitle" onclick="showOrHiden('contactTable')">待录入车辆返利</div>
	<div>
		<c:forEach var="factoryOrder" items="${factoryOrders }" >
			<span class="cust" style="">${factoryOrder.vinCode }【工厂指导价（￥${factoryOrder.factoryPrice}）】
			</span>
			<input type="hidden" name="factoryOrderId" value="${factoryOrder.dbid}">
		</c:forEach>
		<a href="javascript:void(-1)"	 onclick="chooseCar()" class="cust1">选择车辆</a> 
	</div>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">返利项目</div>
	<div>
		<c:forEach var="childrenRebateType" items="${childrenRebateTypes }" >
			<span class="cust" style="">${childrenRebateType.name }
			</span>
			<input type="hidden" name="childrenRebateTypeDbid" value="${childrenRebateType.dbid}">
		</c:forEach>
		<a href="javascript:void(-1)"	 onclick="chooseRebate()" class="cust1">选择返利项目</a> 
	</div>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">返利录入</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:98%">
		<c:forEach var="childrenRebateType" items="${childrenRebateTypes }">
			<tr height="42">
				<td class="formTableTdLeft" width="20%" >${childrenRebateType.name}比例:&nbsp;</td>
				<td width="30%">
					<input type="text" name="rebateRatio" class="largeX text" id="rebateRatio"  checkType="float,0" canEmpty="Y"  onblur="judge(this)">%
					<input type="hidden" name="name" value="${childrenRebateType.name }">
					<input type="hidden" name="id" value="${childrenRebateType.dbid }">
				</td>
				<td class="formTableTdLeft" width="20%">${childrenRebateType.name}金额:&nbsp;</td>
				<td width="30%">
					<input type="text" name="rebateMoney" class="largeX text" checkType="float,0"  canEmpty="Y"  id="rebateMoney" >元<br><span style="color:red">(工厂指导价*返利比例%)</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">付款期限:&nbsp;</td>
				<td id="carModelLabel"  colspan="3">
					<input type="text" name="rebateTerm" class="largeX text" checkType="integer,0" canEmpty="Y" id="rebateTerm" >天
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="formButton">
		<a id="correct" href="javascript:void(-1)"	 onclick="$.utile.submitFrm('frmId1','${ctx}/rebateManagement/saveFactoryRebate')"	class="but butSave">保存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
function judge(s){
	var va= $(s).val();
	if(va!=null && va!=''){
		if(va>100 || va<=0){
			$("#rebatePD").val(2);
			alert("比例不正确，请调整！");
		}else{
			$("#rebatePD").val(1);
		}
	}
}
function chooseCar(){
	var factoryOrderIds = document.getElementsByName("factoryOrderId");
	var childrenRebateTypeDbids = document.getElementsByName("childrenRebateTypeDbid");
	var factoryOrderIds1 = "";
	var childrenRebateTypeDbids1 = "";
	for(var j=0;j<childrenRebateTypeDbids.length;j++){
		childrenRebateTypeDbids1 = childrenRebateTypeDbids1 + childrenRebateTypeDbids[j].value + ",";
	}
	for(var i=0;i<factoryOrderIds.length;i++){
		factoryOrderIds1 = factoryOrderIds1 + factoryOrderIds[i].value + ",";
	}
	//window.location.href="${ctx }/rebateManagement/queryChooseCarList?factoryOrderIds="+factoryOrderIds1+"&childRebateTypeDbids="+childrenRebateTypeDbids1;
	window.location.href="${ctx }/rebateManagement/queryChooseCarList?childRebateTypeDbids="+childrenRebateTypeDbids1;
	//window.location.href="${ctx }/rebateManagement/queryPresaleEntreyList";
}
function chooseRebate(){
	var factoryOrderIds = document.getElementsByName("factoryOrderId");
	var childrenRebateTypeDbids = document.getElementsByName("childrenRebateTypeDbid");
	var factoryOrderIds1 = "";
	var childrenRebateTypeDbids1 = "";
	for(var i=0;i<factoryOrderIds.length;i++){
		factoryOrderIds1 = factoryOrderIds1 + factoryOrderIds[i].value + ",";
	}
	for(var j=0;j<childrenRebateTypeDbids.length;j++){
		childrenRebateTypeDbids1 = childrenRebateTypeDbids1 + childrenRebateTypeDbids[j].value + ",";
	}
	window.location.href="${ctx }/rebateManagement/optionRebateType?factoryOrderIds="+factoryOrderIds1+"&childRebateTypeDbids="+childrenRebateTypeDbids1+"&type=2";
}
//判断实收总额是否正确
function  collectionIsCorrect(s){
	//实收总额
	var actureMoney = $("#totalMoney").val();
	var total=0;
	var lis = $(s).parent().siblings();
	for(var i=0;i<lis.size();i++){
		if(lis.eq(i).children().eq(0).val()!=null && lis.eq(i).children().eq(0).val()!=''){
			total = total + parseFloat(lis.eq(i).children().eq(0).val()); 
		}
	}
	if($(s).val()!=null && $(s).val()!=''){
		total = total + parseFloat($(s).val());
	}
	$("#correct").text("确定收银（￥"+total+"）");
	var attr=$("#correct").attr("class");
	if(parseFloat(actureMoney)==parseFloat(total)){
		$("#correct").removeClass("dis");
	}else{
		var attr=$("#correct").attr("class");
		if(attr.indexOf("dis")){
			$("#correct").addClass("dis");
		}
	}
	$("#countMoney").val(total);
}
function collectionIsCorrrect1(ss){
	var totalMoney = $(ss).val();
	var countMoney = $("#countMoney").val();
	if(parseFloat(totalMoney)==parseFloat(countMoney)){
		$("#correct").removeClass("dis");
	}else{
		var attr=$("#correct").attr("class");
		if(attr.indexOf("dis")){
			$("#correct").addClass("dis");
		}
	}
}
//支付方式的文本的显示和实收总额的计算
function payMent(s){	
	if($("input[type='checkbox']").is(':checked')){
		$("#zf").show();
		if($(s).css("display")=="none"){
			$(s).css("display","");
		}else{
			$(s).css("display","none");
			if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
				var total = parseFloat($("#totalMoney").val())-parseFloat($(s).children().eq(0).val());
				/* $("#totalMoney").val(total); */
				$(s).children().eq(0).val("");
			}	
		}
	}else{
		$("#zf").hide();
		$(s).css("display","none");
		if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
			var total = parseFloat($("#totalMoney").val())-parseFloat($(s).children().eq(0).val());
			/* $("#totalMoney").val(total); */
			$(s).children().eq(0).val("");
		}	
	}	
}
//计算实收总额
function totalAmount(s){
	var lis = $(s).parent().siblings();
	var total=0;
	for(var i=0;i<lis.size();i++){
		if(lis.eq(i).children().eq(0).val()!=null && lis.eq(i).children().eq(0).val()!=''){
			total = total + parseFloat(lis.eq(i).children().eq(0).val()); 
		}
	}
		if($(s).val()!=null && $(s).val()!=''){
			total = total + parseFloat($(s).val());
		}	
		/* $("#totalMoney").val(total); */
}
//表单提交时验证和弹出确认对话框
$.utile.submitFrm = function(frmId,url) {
	var validata = validateForm(frmId);
	var rebatePD = $("#rebatePD").val();
	if (validata == true) {
		if (rebatePD == 2) {
			alert("比例不正确，请调整！");
			return;
		}
	}
	$.utile.submitForm(frmId, url); 
}
</script>
</html>