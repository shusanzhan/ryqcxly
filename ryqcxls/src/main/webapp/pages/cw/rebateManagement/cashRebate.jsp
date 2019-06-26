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
.dis{
	color:#DCDCDC;
}
</style>
<title>工厂返利收银</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/rebateManagement/queryUnCashList'">收银列表</a>-
		<a href="javascript:void(-1);" onclick="javascript:void(-1);">工厂返利收银</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<form action="" name="frmId" id="frmId" >
		<input type="hidden" name="factoryOrderId" id="factoryOrderId" value="${factoryOrder.dbid}">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">车辆信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%" >VIN码:&nbsp;</td>
				<td style="width:30%">
					${factoryOrder.vinCode }
				</td>
				<td class="formTableTdLeft" style="width:20%">车辆名称:&nbsp;</td>
				<td style="width:30%">
					${factoryOrder.carSeriy.name}${factoryOrder.carModel.name }${factoryOrder.carColor.name }
				</td>	
			</tr>
			<tr height="42">
				<td class="formTableLeft" style="width:20%">该笔返利总金额:&nbsp;</td>
				<td style="width:30%" colspan="4">
					<ystech:factoryRebateMoney factoryOrderId="${factoryOrder.dbid }"/>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableLeft" style="width:20%">该笔应收总金额:&nbsp;</td>
				<td style="width:30%" colspan="4">
					<ystech:factoryRebateUnCashMoney factoryOrderId="${factoryOrder.dbid}"/>
				</td>
			</tr>
		</table>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">收银操作</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:98%">
		<tr height = "42">
		<td class="formTableTdLeft" width="20%">收银日期：&nbsp;</td>
			<td width="30%">
					<input type="text"  name="cashier.cashierTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value='<fmt:formatDate value="${now }"/>'  id="writeOffDate"  class="largeX text"  checkType="string,1,50" tip="挂帐日期"></input>
					<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft" width="20%">收据号：&nbsp;</td>
			<td width="30%">
					<input type="text"  name="cashier.receiptNumber" id="receiptNumber"  class="largeX text"  checkType="string,1,50" tip="请填写收据号"></input>
					<span style="color: red">*</span>
			</td>
	</tr>
	 <c:forEach var="rebate" items="${factoryOrder.rebate }">
		<tr>
			<td class="formTableTdLeft">${rebate.name }金额：&nbsp;</td>
			<td>
				<input type="hidden" name="id" value="${rebate.dbid }">
				<input type="text" name="rebateMoney" id="rebateMoney" class="largeX text" readonly="readonly" value="${rebate.rebateMoney}" />已收${empty rebate.realRebateMoney ? 0.0:rebate.realRebateMoney}
				<%-- <input type="text" name="rebateMoney" id="rebateMoney" class="largeX text" readonly="readonly" value="${rebate.rebateState eq 2 ?'已收rebate.realRebateMoney':rebateMoney}" /> --%>
			</td>
			<td class="formTableTdLeft">${rebate.name }实收金额：&nbsp;</td>
			<td>
				<%-- <input type="text" name="realMoney" id="realMoney" class="largeX text" value="${rebate.rebateMoney-rebate.realRebateMoney}" /> --%>
				<input type="text" name="realMoney" id="realMoney"  class="largeX text"   value="${rebate.rebateState eq 3 ?rebate.rebateMoney:rebate.rebateMoney-rebate.realRebateMoney}"  ${rebate.rebateState eq 3?'readOnly':''} onkeyup="sumTotal()" onfocus="sumTotal()"></input>
			</td>
		</tr>
	</c:forEach> 
	<tr>
		<td style="width:20%">实收总额：&nbsp;</td>
			<td colspan="3">
					<input type="text"  name="cashier.amountCollected" value="${totalMoney }"  id="totalMoney"  class="largeX text" readonly="readonly"></input>
					<span style="color: red">*</span>
		</td>
	</tr>
	<tr>
			<td class="formTableTdRight" style="font-size:18px;">支付方式:&nbsp;</td>
			<td style="font-size:18px;line-height:40px;" colspan="3">
					<c:forEach var="ChildPayType" items="${childPayType}">
					<!-- checkType="checkBox" -->
					<label for="payType${ChildPayType.dbid }"><input type='checkbox' name="payType" id="payType${ChildPayType.dbid }"  value="${ChildPayType.dbid }" onclick="payMent('#pt${ChildPayType.dbid }')"    tip="支付方式至少选中一项"/>${ChildPayType.name }</label>
				</c:forEach>
		</td>
	</tr>
	<tr  style="display:none" id="zf">
				<td colspan="4" >
				<table>
					<tr>
						<c:forEach var="ChildPayType" items="${childPayType }">
							<td  style="display:none" id="pt${ChildPayType.dbid }" >${ChildPayType.name }:&nbsp;<input type="text" name="${ChildPayType.engName }"  onkeyup="totalAmount(this),collectionIsCorrect(this)" onfocus="totalAmount(this),collectionIsCorrect(this)" id="pt1${ChildPayType.dbid }" class="small text" title="${ChildPayType.name }" checkType="float,0" tip="支付宝金额不能为空，且为数字类型"></td>
						</c:forEach> 
					</tr>
					</table>
					</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">发票类型：&nbsp;</td>
			<td>
					<select id="childBillingType" name="childBillingTypeId" class="large text" >
						<option value="">请先选择...</option>
							<c:forEach var="childBilling" items="${childBilling }">
								<option value="${childBilling.dbid }" >${childBilling.name }</option>
							</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft">开票类型：&nbsp;</td>
			<td>
				<select id="openBillingType" name="openBillingTypeId" class="large text" >
					<option value="">请选择</option>
					<c:forEach var="openBillingType" items="${openBillingType }">
						<option value="${openBillingType.dbid}">${openBillingType.name }</option>
					</c:forEach>
				</select>
				</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">开票金额：&nbsp;</td>
			<td>
					<input type="text"  name="cashier.openBillingMoney" id="invoiceValue"  class="largeX text" style="color: red;" checkType="float,0" tip="请填写开票金额"></input>
					<span style="color: red">*</span>
			</td>
				<td class="formTableTdLeft">收银人：&nbsp;</td>
			<td>
					<input type="text"  name="cashier.payee" id="payee"  class="largeX text" value="${sessionScope.user.realName }"  readonly="readonly"></input>
			</td>
			</tr>
		<tr>
		<td class="formTableTdLeft">摘要：&nbsp;</td>
				<td>
					<input type="text" name="cashier.abstract_" id="abstract_"  class="largeX text" ></input>
			</td>
		<td class="formTableTdLeft">备注：&nbsp;</td>
			<td >
					<input type="text" name="cashier.cashRemark" id="cashRemark"  class="largeX text" ></input>
			</td>
	</tr>
	</table>
	<div class="formButton">
	  	<a href="javascript:void(-1)"	 id="correct" onclick="$.utile.submitFrm('frmId','${ctx}/rebateManagement/saveCash')"	class="but butSave dis">确定收银（￥${totalMoney }）</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
//计算实收总额
function sumTotal(){
	var name = $("input[name='realMoney']");
	var totalMoney = 0;
	for(var i=0;i<name.size();i++){
		if(isNaN(name.eq(i).val())==false && name.eq(i).val()!=null && name.eq(i).val()!=''){
			totalMoney = totalMoney + parseFloat(name.eq(i).val());
		}
	}
	$("#totalMoney").val(totalMoney);
}
//判断实收总额是否正确
function  collectionIsCorrect(s){
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
	var payType = document.getElementsByName("payType");
	var flag = false;
	if (validata == true) {
		 
		//支付方式至少选中一项
		  for(var i=0;i<payType.length;i++){
			if(payType[i].checked){
				flag = true;
				break;
			}
		 }
		  if(!flag){
			  alert("请选择支付方式！")
			 return false;
		}
		  var attr=$("#correct").attr("class");
		  if(attr.indexOf("dis")>0){
			 return false;
		  }
		window.top.art.dialog({
			content : '请确认费用信息无误，点击【确定】保存数据！',
			icon : 'question',
			width:"250px",
			height:"80px",
			window : 'top',
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.utile.submitAjaxForm(frmId,url);
			},
			cancel : true
		});
	}
}

</script>
</html>