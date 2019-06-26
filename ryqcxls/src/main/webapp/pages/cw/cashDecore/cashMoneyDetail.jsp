<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
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
.ac_results{
	width: 460px;
}
.dis{
	color:#DCDCDC;
}
</style>
<title>装饰收银明细</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashDecore/queryCashierList'">装饰明细</a>-
<a href="#">明细</a>
</div>
<div class="line"></div>
 <div class="frmContent">
<table border="0" align="center" cellpadding="0" cellspacing ="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">客户信息</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">姓名：&nbsp;</td>
		<td style="width:30%;color:green;font-size:20px" >
				${decoreOut.customerName }
		<td>电话号码：&nbsp;</td>
		<td >
				<c:if test="${empty decoreOut.mobilePhone }">
						无
				</c:if>
				<c:if test="${!empty decoreOut.mobilePhone }">
						${decoreOut.mobilePhone }
				</c:if>
		</td>
	</tr>
</table> 
</div>
 <div class="frmContent">
		<div id='te' style="width: 100%">
		<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="40" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 120px;text-align: center;">品名</th>
						<th style="width: 40px;text-align: center;">数量</th>
						<th style="width: 80px;text-align: center;">出库单</th>
						<th style="width: 60px;text-align: center;">销售单价</th>
						<th style="width: 60px;text-align: center;">小计</th>
						<th style="width: 140px;text-align: center;">备注</th>
				</tr>
					 <c:forEach var="decoreoutProduct"  items="${decoreOut.decoreoutProducts}">
							<tr height="40">
								<td  id="productName${decoreoutProduct.dbid}" >
									${decoreoutProduct.productName }
								</td>
								<td id="num${decoreoutProduct.dbid}" >
									${decoreoutProduct.num }
								</td>
								<td id="purchaseProductNo${decoreoutProduct.dbid}" >
									${decoreoutProduct.decoreOut.outNo}
								</td>
								<td id="price${decoreoutProduct.dbid}">
									${decoreoutProduct.price}
								</td>
								<td id="subtotal${decoreoutProduct.dbid}">
								
								</td>
								<td id="note${decoreoutProduct.dbid}">
									<c:if test="${empty decoreoutProduct.note}">
										无
									</c:if>
									<c:if test="${!empty decoreoutProduct.note}">
										${decoreoutProduct.note}
									</c:if>
								</td>
							</tr>
						</c:forEach>
						<tr height="40">
						<td >应收总额:</td>
						<td   id="acturePrice" colspan="6" style="color:red;font-size: 20px">
							${decoreOut.decoreSaleTotalPrce}
						</td>						
						</tr>
			</table>
		</div>
	</div>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" >
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">	
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">收银信息</td>
			</tr>
	<tr height = "42">
			<td style="width:20%">收款日期：&nbsp;</td>
			<td style="width:30%">
					${decoreOut.cashier.cashierTime}
			</td>
			<td style="width:20%">收据号：&nbsp;</td>
			<td style="width:30%">
					${decoreOut.cashier.receiptNumber}
			</td>
	</tr>
	<tr>
		<td style="width:20%">实收总额：&nbsp;</td>
			<td style="width:30%">
					${decoreOut.cashier.amountCollected}
			</td>
			<td style="width:20%">开票金额：&nbsp;</td>
			<td style="width:30%">
					${decoreOut.cashier.openBillingMoney}
			</td>
	</tr>
		<tr>		
			<td style="width:20%">发票类型：&nbsp;</td>
			<td style="width:30%">
					${decoreOut.cashier.childBillingType.name}
				</td>
			<td style="width:20%">开票类型：&nbsp;</td>
			<td style="width:30%">
				${decoreOut.cashier.openBillingType.name}
				</td>
		</tr>
			<tr>			
			<td style="width:20%">收款人：&nbsp;</td>
			<td>${decoreOut.cashier.payee}</td>
			<td style="width:20%">摘要：&nbsp;</td>
			<td style="width:30%">
					<c:if test="${empty decoreOut.cashier.abstract_}">
						无
					</c:if>
					<c:if test="${!empty decoreOut.cashier.abstract_}">
						${decoreOut.cashier.abstract_}
					</c:if>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">支付方式:&nbsp;</td>
				<td colspan="3">
					<c:forEach var="paymentTypeAndMoney" items="${payMentTypeAndMoneys }">
						${paymentTypeAndMoney.childPayTypeName }:<span style="color: red">${paymentTypeAndMoney.receiveMoney }</span>&#12288;
					</c:forEach>
				</td>
		</tr>
		<tr>		
			<td >备注：&nbsp;</td>
			<td colspan="4">
					<c:if test="${empty decoreOut.cashier.cashRemark}">
						无
					</c:if>
					<c:if test="${!empty decoreOut.cashier.cashRemark}">
						${decoreOut.cashier.cashRemark }
					</c:if>
			</td>
		</tr>
	</table>
	</form>
	</div>
	<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;回</a>
	</div>
</body>
<script type="text/javascript">
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
//由于数据库中没有存放每一项的总价，就在页面中计算
window.onload = function(){
	var er = $("[id^=subtotal]")
	for(var i=0;i<er.size();i++){
		var str= er.eq(i).attr("id");
		var id = str.replace(/[^0-9]/ig,"");
		var priceId = "price"+id;
		var numId = "num"+id;
		var subtotalId = "subtotal"+id;
		var price = $("#"+priceId+"").text();
		var num = $("#"+numId+"").text();
		if(price!=null && price>0 && num!=null && num>0){
			var sum = num * price;
			var subtotal = $("#"+subtotalId+"").text(sum);
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
	var totalMoney = $("#totalMoney").val();
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
		  if(invoiceValue>totalMoney){
			alert("开票金额大于实收金额，请核对！");
			return false;
		} 
		window.top.art.dialog({
			content : '请确认定单信息无误，点击【确定】保存数据！',
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