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
</style>
<title>保险返利收银明细</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashInsurance/queryCashierList'">保险返利明细</a>-
<a href="#">明细</a>
</div>
<div class="line"></div>
 <div class="frmContent">
<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">客户信息</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">姓名：&nbsp;</td>
		<td style="width:30%;color:green;font-size:20px" >
				${insuranceRecord.insCustomer.name }
		<td>电话号码：&nbsp;</td>
		<td >
				${insuranceRecord.insCustomer.mobilePhone}
		</td>
	</tr>
</table> 
</div>
<div class="frmContent">
		<form action="" name="frmId1" id="frmId1" >
		<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
			<tr height="40" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="100%" colspan="4" style="">保险信息</td>
			</tr>
				<tr height="40">
					<td style="width:20%">购买日期:</td>
					<td style="width:30%">${insuranceRecord.buyDate}</td>	
					<td style="width:20%">起保日期:</td>
					<td style="width:30%">${insuranceRecord.beginDate}</td>					
				</tr>
				<tr height="40">
					<td style="width:20%">脱保日期:</td>
					<td style="width:30%">${insuranceRecord.endDate}</td>	
					<td style="width:20%">出单公司:</td>
					<td style="width:30%">${insuranceRecord.insuranceCompany.name}</td>					
				</tr>
				<tr height="40">
					<td style="width:20%">交强险项目:</td>
					<td style="width:30%">${insuranceRecord.strongRisk}</td>	
					<td style="width:20%">交强险金额:</td>
					<td style="width:30%">${insuranceRecord.strongRiskPrice}</td>					
				</tr>
				<tr height="40">
					<td style="width:20%">商业险项目:</td>
					<td style="width:30%">${insuranceRecord.busiRisk}</td>	
					<td style="width:20%">商业险金额:</td>
					<td style="width:30%">${insuranceRecord.busiRiskPrice}</td>					
				</tr>
				<tr height="40">
					<td style="width:20%">强制险返利金额:</td>
					<td style="width:30%">${insuranceRecord.strongRiskRebateMoney}</td>	
					<td style="width:20%">商业险返利金额:</td>
					<td style="width:30%">${insuranceRecord.busiRiskRebateMoney}</td>					
				</tr>
				<tr height="40">
					<td style="width:20%">返利总金额:</td>
					<td style="width:30%">${insuranceRecord.rebateMoney}</td>	
					<td style="width:20%">客户附件权益:</td>
					<td style="width:30%">${insuranceRecord.incidentalInterestMoney}</td>					
				</tr>
				<tr height="40">
					<td style="width:20%">保险记录 类型:</td>
					<td style="width:30%">
						<c:choose>
					<c:when test="${insuranceRecord.insType eq 1}">
						保有客户购买
					</c:when>
					<c:when test="${insuranceRecord.insType eq 2}">
						保有客户续保
					</c:when>
					<c:when test="${insuranceRecord.insType eq 3}">
						外来客户购买
					</c:when>
					<c:when test="${insuranceRecord.insType eq 4}">
						外来客户续保
					</c:when>
				</c:choose>
					</td>	
					<td style="width:20%">销售人员:</td>
					<td style="width:30%">${insuranceRecord.saler}</td>					
				</tr>
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">收费信息</td>
					</tr>
					<tr height="42">
						<td class="formTableTdLeft" style="width:20%" >收据号:&nbsp;</td>
						<td style="width:30%">
							${cashier.receiptNumber}
						</td>
						<td class="formTableTdLeft" style="width:20%" >订单号:&nbsp;</td>
						<td style="width:30%">
							${cashier.orderNo}
						</td>
					</tr>
					<tr height="42">
						<td class="formTableTdLeft" style="width:20%">收款金额:&nbsp;</td>
						<td style="width:30%">
							<span style="color: red;">
								<c:if test="${empty cashier.amountCollected}">
									0.0
								</c:if>
								<c:if test="${!empty cashier.amountCollected}">
									${cashier.amountCollected}
								</c:if>
							</span>
						</td>
						<td class="formTableTdLeft">开票金额:&nbsp;</td>
						<td>
							<span style="color: red;">
								<c:if test="${empty cashier.openBillingMoney}">
									0.0
								</c:if>
								<c:if test="${!empty cashier.openBillingMoney}">
									${cashier.openBillingMoney}
								</c:if>
							</span>
						</td>
					</tr>	
					<tr height="42">
						<td class="formTableTdLeft" style="width:20%">开票类型:&nbsp;</td>
						<td style="width:30%">
							<c:if test="${empty(cashier.openBillingType) }">
								无
							</c:if>
							${cashier.openBillingType.name }
						</td>
						<td class="formTableTdLeft" style="width:20%">发票类型:&nbsp;</td>
						<td style="width:30%">
							${cashier.childBillingType.name }
						</td>
					</tr>
					<tr height = "42">
						<td class="formTableTdLeft">收银时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${cashier.cashierTime}"/> 
						</td>
						<td class="formTableTdLeft">收款人:&nbsp;</td>
						<td>
							${cashier.payee}
						</td>
					</tr>
					<tr height = "42">
						<td class="formTableTdLeft">创建时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${cashier.createTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
						</td>
						<td class="formTableTdLeft">修改时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${cashier.modifyTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
						</td>
					</tr>
				<tr>
					<td class="formTableTdLeft">支付方式:&nbsp;</td>
						<td colspan="3">
							<c:forEach var="paymentTypeAndMoney" items="${paymentTypeAndMoneys }">
								${paymentTypeAndMoney.childPayTypeName }：<span style="color: red">${paymentTypeAndMoney.receiveMoney }</span>&#12288;
							</c:forEach>
						</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">收银客户:&nbsp;</td>
					<td colspan="3">
						<c:forEach var="customerName" items="${customerNames }" >
							<span class="cust" style="">${customerName}</span>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">摘要:&nbsp;</td>
						<td colspan="3">
							<c:if test="${empty cashier.abstract_}">
								无
							</c:if>
							<c:if test="${!empty cashier.abstract_}">
								${cashier.abstract_ }
							</c:if>
						</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">备注:&nbsp;</td>
						<td colspan="3">
							<c:if test="${empty cashier.cashRemark}">
								无
							</c:if>
							<c:if test="${!empty cashier.cashRemark}">
								${cashier.cashRemark }
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