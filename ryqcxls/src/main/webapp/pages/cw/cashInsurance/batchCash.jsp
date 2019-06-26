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
.dis{
	color:#DCDCDC;
}
</style>
<title>保险批量收银</title>
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashInsurance/queryList'">保险收银</a>-
	<a href="javascript:void(-1);" onclick="javascript:void(-1);">批量收银</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId1" id="frmId1" >
	<input type="hidden" id="countMoney" name="countMoney">
	<div class="frmTitle" onclick="showOrHiden('contactTable')">待批量收银客户</div>
	<div>
	<c:set value="0" var="totalMoney"></c:set>
		<c:forEach var="insuranceRecord" items="${insuranceRecords }" >
			<span class="cust" style="">${insuranceRecord.insCustomer.name }【￥${insuranceRecord.rebateMoney }】</span>
			<c:set value="${insuranceRecord.rebateMoney+totalMoney }" var="totalMoney"></c:set>
			<input type="hidden" name="insuranceRecordId" value="${insuranceRecord.dbid}">
		</c:forEach>
		<span class="cust">总金额:<i style="font-size: 18px;color: red;">
			￥<fmt:formatNumber value="${totalMoney}" pattern="#.00"></fmt:formatNumber>
		</i></span>
	</div>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">收银操作</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:98%">
		<tr height = "42">
		<td class="formTableTdLeft">收款日期：&nbsp;</td>
		<td>
			<input type="text"  name="cashier.cashierTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" id="settlementDate" value='<fmt:formatDate value="${now }"/>' class="largeX text"  checkType="string,1,50" tip="收款日期"></input>
			<span style="color: red">*</span>
			<input type="hidden" name="dbids" id="dbids"> 
		</td>
		<td class="formTableTdLeft">收据号：&nbsp;</td>
		<td>
			<input type="text" name="cashier.receiptNumber"  id="receiptNumber"  class="largeX text" ></input>
			<span style="color: red">*</span>
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft">应收总额：&nbsp;</td>
		<td>
			<input type="text"  readonly="readonly" id="amountCollected"  value="<fmt:formatNumber value="${totalMoney}" pattern="#.00"></fmt:formatNumber>" class="largeX text" ></input>
			<span style="color: red">*</span>
		</td>
		<td class="formTableTdLeft">实收总额：&nbsp;</td>
			<td>
					<input type="text"  name="cashier.amountCollected"  onkeyup="collectionIsCorrect1(this)"  onfocus="collectionIsCorrect1(this)"  id="totalMoney"   class="largeX text" value="<fmt:formatNumber value="${totalMoney}" pattern="#.00"></fmt:formatNumber>" checkType="float,0" tip="实收总额不能为空，且为数字类型"></input>
					<span style="color: red">*</span>
			</td>
	</tr>
		<tr>
			<td class="formTableTdLeft" style="font-size: 18px;">支付方式：&nbsp;</td>
			<td style="font-size: 18px;line-height: 40px;" colspan="3">
					<c:forEach var="ChildPayType" items="${childPayType}">
						<label for="payType${ChildPayType.dbid }"><input type='checkbox' name="payType" id="payType${ChildPayType.dbid }" value="${ChildPayType.dbid }" onclick="payMent('#pt${ChildPayType.dbid }')"    tip="支付方式至少选中一项"/>${ChildPayType.name }</label>
					</c:forEach>
				</td>
				<span style="color: red">*</span>
		</tr>
		<tr  style="display:none" id="zf">
				<td class="formTableTdLeft" style="font-size: 18px;">支付方式：&nbsp;</td>
				<td colspan="3"  id="payType">
					<c:forEach var="ChildPayType" items="${childPayType }">
						<span  style="display:none" id="pt${ChildPayType.dbid }" >${ChildPayType.name }:&nbsp;<input type="text" name="${ChildPayType.engName }"  onkeyup="totalAmount(this),collectionIsCorrect(this)" onfocus="totalAmount(this),collectionIsCorrect(this)" id="pt1${ChildPayType.dbid }" class="small text" title="${ChildPayType.name }" checkType="float,0" tip="支付宝金额不能为空，且为数字类型"></span>
					</c:forEach>
				<td> 
			</tr>
			<tr>
			<td class="formTableTdLeft">票据类型：&nbsp;</td>
			<td>
					<select id="childBillingType" name="childBillingTypeId" class="large text" >
						<option value="">请先选择...</option>
							<c:forEach var="childBilling" items="${childBilling }">
								<option value="${childBilling.dbid }" >${childBilling.name }</option>
							</c:forEach>
					</select>
					<span style="color: red">*</span>
				</td>
			<td class="formTableTdLeft">开票金额：&nbsp;</td>
			<td>
					<input type="text"  name="cashier.openBillingMoney" id="invoiceValue"  class="largeX text" style="color: red;" checkType="float,0" tip="请填写开票金额"></input>
					<span style="color: red">*</span>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">开票类型：&nbsp;</td>
			<td>
				<select id="openBillingType" name="openBillingTypeId" class="large text" >
					<option value="">请选择</option>
					<c:forEach var="openBillingType" items="${openBillingType }">
						<option value="${openBillingType.dbid}">${openBillingType.name }</option>
					</c:forEach>
					<span style="color: red">*</span>
				</select>
				</td>
			<td class="formTableTdLeft">收款人：&nbsp;</td>
			<td>
					<input type="text"  name="cashier.payee" id="payee"  class="largeX text" value="${sessionScope.user.realName }"  readonly="readonly"></input>
					<span style="color: red">*</span>
			</td>
		</tr>
		<tr>
			<td >摘要：&nbsp;</td>
			<td>
				<input type="text" name="cashier.abstract_" id="abstract_" class="largeX text" >
			</td>
			<td >备注：&nbsp;</td>
			<td>
					<textarea  name="cashier.cashRemark" id="cashRemark"  class="largeX text" style="width: 95%;"></textarea>
			</td>
		</tr>
	</table>
	<div class="formButton">
		<a id="correct" href="javascript:void(-1)"	 onclick="$.utile.submitFrm('frmId1','${ctx}/cashInsurance/saveBatchCash')"	class="but butSave dis">确定收银（￥<fmt:formatNumber value="${totalMoney}" pattern="#.00"></fmt:formatNumber>）</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
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
function collectionIsCorrect1(ss){
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
	var invoiceValue = $("#invoiceValue").val();
	var actureMoney = $("#actureMoney").val();
	var payType = document.getElementsByName("payType");
	var flag = false;
	if (validata == true) {
		 var attr=$("#correct").attr("class");
		  if(attr.indexOf("dis")>0){
			 return false;
		  }
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