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
<title>金融收银</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashFinance/queryList'">金融收银</a>-
		<a href="javascript:void(-1);" onclick="javascript:void(-1);">贴息收银</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<form action="" name="frmId" id="frmId" >
		<input type="hidden" name="finCustomerId" value="${finCustomer.dbid }">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">贷款人信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">申请人:&nbsp;</td>
				<td style="width:30%">${finCustomer.name }</td>
				<td class="formTableTdLeft" style="width:20%">申请人电话:&nbsp;</td>
				<td style="width:30%">${finCustomer.mobilePhone }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">身份证号:&nbsp;</td>
				<td style="width:30%">${finCustomer.icard }</td>
				<td class="formTableTdLeft" style="width:20%">地址:&nbsp;</td>
				<td style="width:30%">
					${finCustomer.address }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">共申人:&nbsp;</td>
				<td style="width:30%">${finCustomer.commName }</td>
				<td class="formTableTdLeft" style="width:20%">共申人电话:&nbsp;</td>
				<td style="width:30%">${finCustomer.commMobilePhone }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">车型:&nbsp;</td>
				<td style="width:30%">
					${finCustomer.carSeriyName }
				</td>
				<td class="formTableTdLeft" style="width:20%">销售员:&nbsp;</td>
				<td style="width:30%">${finCustomer.saler }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">销售员电话:&nbsp;</td>
				<td style="width:30%">${finCustomer.salerPhone }</td>
				<td class="formTableTdLeft" style="width:20%">车辆销售商：</td>
				<td  colspan="3">
					${finCustomer.distributor.name }
				</td>
			</tr>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">贷款费用</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
		 <tr height="42">
				<td class="formTableTdLeft" style="width:20%">车价:&nbsp;</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.carPrice}</td>
				<td class="formTableTdLeft" style="width:20%">开票价:&nbsp;</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.kaiPiaoPrice }</td>
			</tr> 
		<tr height="42">
				<td class="formTableTdLeft" style="width:20%">贷款金额:&nbsp;</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.loanPrice }</td>
				<td class="formTableTdLeft" style="width:20%">贷款产品:&nbsp;</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.finProduct.name}</td>
		</tr> 
		<tr>
			<td class="formTableTdLeft" style="width:20%">手续费:&nbsp;</td>
			<td >
				${finCustomer.finCustomerLoan.countFee}
			</td>
			<td class="formTableTdLeft" style="width:20%">贴息金额:&nbsp;</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">${finCustomer.finCustomerLoan.discountMony}</span>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft" style="width:20%">实际利息:&nbsp;</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">${finCustomer.finCustomerLoan.actDiscountPrice}</span>
			</td>
			<td class="formTableTdLeft" style="width:20%">公司贴息:&nbsp;</td>
			<td style="text-align:lcenter;">
				${finCustomer.finCustomerLoan.companyDiscountPrice}
			</td>
		</tr>
		<tr height="42">
			<td class="formTableTdLeft" style="width:20%">销售收取贴息：&nbsp;</td>
			<td 	colspan="3">
				${finCustomer.finCustomerLoan.salerDiscountPrice}
			</td>
		</tr>
		<%-- <tr height="42">
			<td class="formTableTdLeft" style="width:20%">放款时间：&nbsp;</td>
			<td >
				${finCustomer.loanDate}
			</td>
			<td class="formTableTdLeft" style="width:20%">应收总额：&nbsp;</td>
			<td colspan="1" id="amountCollected" style="color: red;font-size: 18px;">${finCustomer.finCustomerLoan.loanPrice}</td>
		</tr> --%>
		</table>	
	<div class="frmTitle" onclick="showOrHiden('contactTable')">收银操作</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:98%">
		<tr height = "42">
			<td class="formTableTdLeft">收款日期：&nbsp;</td>
			<td>
					<input type="text"  name="cashier.cashierTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value='<fmt:formatDate value="${now }"/>'  id ="cashierTime"  class="largeX text"  checkType="string,1,50" tip="收款日期"></input>
					<span style="color: red">*</span>
					<input type="hidden" name="countMoney" id="countMoney">
			</td>
			<td class="formTableTdLeft">收据号：&nbsp;</td>
			<td>
					<input type="text"  name="cashier.receiptNumber" id="receiptNumber"  class="largeX text"  checkType="string,1,50" tip="请填写收据号"></input>
					<span style="color: red">*</span>
			</td>
	</tr>
		<tr>
		<td class="formTableTdLeft">实收总额：&nbsp;</td>
			<td >
					<input type="text"  name="cashier.amountCollected"  id="totalMoney"  class="largeX text"  value="${finCustomer.finCustomerLoan.discountMony}" onkeyup="totalCollection();$('#openBillingMoney').val(this.value),collectionIsCorrect1(this)" onfocus="totalCollection(),collectionIsCorrect1(this)" checkType="float,0" tip="实收总额不能为空，且为数字类型"></input>
					<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft">发票类型：&nbsp;</td>
			<td>
				<select id="childBillingTypeId" name="childBillingTypeId" class="largeX text" checkType="integer,1" tip="发票类型不能为空">
					<option value="">请先选择...</option>
						<c:forEach var="childBilling" items="${childBilling }">
							<option value="${childBilling.dbid }" >${childBilling.name }</option>
						</c:forEach>
				</select>
				<span style="color: red">*</span>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">开票类型：&nbsp;</td>
			<td>
				<select id="childBillingTypeId" name="openBillingTypeId" class="largeX text" checkType="integer,1" tip="开票类型不能为空">
					<option value="">请先选择...</option>
						<c:forEach var="openBillingType" items="${openBillingType }">
							<option value="${openBillingType.dbid }" >${openBillingType.name }</option>
						</c:forEach>
				</select>
				<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft">开票金额：&nbsp;</td>
			<td>
				<input type="text"  name="cashier.openBillingMoney" id="openBillingMoney"  class="largeX text" style="color: red;" checkType="float,0" tip="请填写开票金额"></input>
				<span style="color: red">*</span>
			</td>
		</tr>
		<tr>
			<td class="formTableTdRight" style="font-size: 18px;">支付方式：&nbsp;</td>
			<td colspan="3" style="font-size: 18px;line-height: 40px;">
				<c:forEach var="ChildPayType" items="${childPayType}">
					<label for="payType${ChildPayType.dbid }"><input type='checkbox' name="payType" id="payType${ChildPayType.dbid }" value="${ChildPayType.dbid }" onclick="payMent('#pt${ChildPayType.dbid }')"    tip="支付方式至少选中一项"/>${ChildPayType.name }</label>
				</c:forEach>
			</td>
		</tr>
		<tr  style="display:none" id="zf">
				<td >
					支付方式
				</td>
				<td colspan="3">
					<c:forEach var="ChildPayType" items="${childPayType }">
						<span  style="display:none" id="pt${ChildPayType.dbid }" >${ChildPayType.name }：&nbsp;<input type="text" name="${ChildPayType.engName }"  onkeyup="totalAmount(this),collectionIsCorrect(this)" onfocus="totalAmount(this),collectionIsCorrect(this)" id="pt1${ChildPayType.dbid }" class="small text" title="${ChildPayType.name }" checkType="float,0" tip="支付宝金额不能为空，且为数字类型"></span>
					</c:forEach> 
				</td>
			</tr>
			
		<tr>	
			<td class="formTableTdLeft">摘要：&nbsp;</td>
			<td>
					<input type="text"  name="cashier.abstract_" id="abstract_"  class="largeX text" ></input>
			</td>
			<td >备注：&nbsp;</td>
			<td >
					<input  name="cashier.cashRemark" id="cashRemark"  class="largeX text"  value="${orderContractExpenses.note }"></input>
			</td>
		</tr>
	</table>
	<div class="formButton">
		<a id="correct" href="javascript:void(-1)"	 onclick="$.utile.submitFrm('frmId','${ctx}/cashFinance/cashDiscount')"	class="but butSave dis">确定收银（￥${finCustomer.finCustomerLoan.discountMony}）</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
	<br>
	<br>
	<br>
</body>
<script type="text/javascript">
function totalCollection(){
	//实收总额
	var actureMoney = $("#totalMoney").val();
	var attr=$("#correct").attr("class");
	if(isNaN(actureMoney)==true){
		$("#correct").text("输入有误！");
	}else if(actureMoney==""||actureMoney==0){
		$("#correct").text("确定收银（￥0.0）");
	}else{
		$("#correct").text("确定收银（￥"+actureMoney+"）");
	}
	var total=0;
	var lis = $("#as").children();
	for(var i=0;i<lis.size();i++){
		if(lis.eq(i).children().eq(0).val()!=null && lis.eq(i).children().eq(0).val()!=''){
			total = total + parseFloat(lis.eq(i).children().eq(0).val()); 
		}
	}
	if(total!=actureMoney){
		$("#correct").addClass("dis");
	}else{
		$("#correct").removeClass("dis");
	}
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
				$(s).children().eq(0).val("");
			}	
		}
	}else{
		$("#zf").hide();
		$(s).css("display","none");
		if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
			var total = parseFloat($("#totalMoney").val())-parseFloat($(s).children().eq(0).val());
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
}
//表单提交时验证和弹出确认对话框
$.utile.submitFrm = function(frmId,url) {
	var validata = validateForm(frmId);
	var invoiceValue = $("#invoiceValue").val();
	var actureMoney = $("#totalMoney").val();
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
		//防止开票金额大于实收金额
		  if(invoiceValue>actureMoney){
			alert("开票金额大于实收金额，请核对！");
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