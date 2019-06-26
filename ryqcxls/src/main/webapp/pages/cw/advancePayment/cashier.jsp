<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css?=1" type="text/css" rel="stylesheet"/>
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
.dis{
	color:#DCDCDC;
}
</style>
<title>预收收银</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/advancePayment/queryList'">预收收银</a>-
		<a href="javascript:void(-1);" onclick="">收银</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">基础信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">客户姓名:&nbsp;
					<input type="hidden" name="advancePaymentId" id="dbid" value="${advancePayment.dbid}">
				</td>
				<td style="width:30%"><input type="text" readonly="readonly"  name="advancePayment.custName" id="custName"  value="${advancePayment.custName }" class="large text" title="名字" ></td>
				<td class="formTableTdLeft" style="width:20%">电话号码:&nbsp;</td>
				<td style="width:30%"><input type="text" name="advancePayment.custTel" id="custTel" readonly="readonly"
					value="${advancePayment.custTel }" class="large text" title="电话号码"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">创建来源:&nbsp;</td>
				<td id="finProductIdTr">
					<select id="createSource" name="advancePaymentCreateSource" class="large text" disabled="disabled">
						<option value="0">请选择...</option>		
						<c:choose>
							<c:when test="${ advancePayment.createSource eq 1}">
								<option value="1"  selected>订单创建</option>
							</c:when>
							<c:otherwise>
								<option value="1" >订单创建</option>
							</c:otherwise>
						</c:choose>	
							<c:choose>
							<c:when test="${ advancePayment.createSource eq 2}">
								<option value="2"  selected>收款创建</option>
							</c:when>
							<c:otherwise>
								<option value="2" >收款创建</option>
							</c:otherwise>
						</c:choose>				
					</select> 
				<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">客户类型:&nbsp;</td>
				<td id="finProductItemTr">
					<select id="custType" name="advancePaymentCustType" class="large text"  disabled="disabled">
						<option value="0">请先选择...</option>
							<option value="1" ${advancePayment.custType==1?'selected="selected"':'' } >展厅（网销）客户</option>			
							<option value="2" ${advancePayment.custType==2?'selected="selected"':'' }>二网</option>			
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">收款类别:&nbsp;</td>
				<td id="finProductIdTr" colspan="3">
					<select id="advanceTypeId" name="advancePaymentAdvanceTypeId" class="large text" disabled="disabled">
						<option value="">请先选择...</option>
						<c:forEach items="${receivablesType }" var="receivablesType">
							<c:choose>
								<c:when test="${receivablesType.dbid eq  advancePayment.childReceivablesType.dbid}">
									<option value="${receivablesType.dbid }"  selected>${receivablesType.name }</option>
								</c:when>
								<c:otherwise>
									<option value="${receivablesType.dbid }" >${receivablesType.name }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			</table>
			
			<div class="frmTitle" onclick="showOrHiden('contactTable')">收银操作</div>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
				<tr>
				<td class="formTableTdLeft" style="width:20%">收款日期:&nbsp;</td>
				<td style="width:30%">
					<input class="text large" id="advanceTime" name="advancePaymentAdvanceTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value='<fmt:formatDate value="${now }"/>'  checkType="string,1,50"  tip="收款日期不能为空"><span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">本笔总额:&nbsp;</td>
				<td>
					<input readonly="readonly"  type="text" name="advancePaymentTotalMoney"  id="totalMoney" class="large text" title="本笔总额" checkType="float,0"  value="${advancePayment.totalMoney }" >
				</td>
			</tr>
				<tr>
				<td class="formTableTdLeft">收据号:&nbsp;</td>
				<td>
					<input  type="text" name="cashier.receiptNumber" id="receiptNumber" class="large text" title="收据号" checkType="string,1,50" tip="收据号不能为空">
					<span style="color: red">*</span>
				</td>
				<td class="formTableTdLeft">实收总额:&nbsp;</td>
				<td>
					<input type="text" name="advancePaymentActureMoney" value="${advancePayment.totalMoney }"  id="actureMoney" class="large text" title="实收总额" readonly="readonly" checkType="float,0" tip="实收总额不能为空，且为数字类型">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">票据类型:&nbsp;</td>
				<td id="finProductItemTr">
					<select id="childBillingTypeId" name="childBillingTypeId" class="large text" checkType="integer,1" tip="开票类型不能为空">
						<option value="">请先选择...</option>
						<c:forEach var="childBilling" items="${childBilling }">
							<option value="${childBilling.dbid }" >${childBilling.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>		
				<td class="formTableTdLeft" >开票金额:&nbsp;</td>
				<td id="monthSupPriceTr">
					<input type="text" name="cashier.openBillingMoney" id="openBillingMoney" style="color:red" class="large text" title="开票金额"  checkType="float,0" tip="开票金额不能为空,且只能为数字"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdRight" style="font-size: 18px;">支付方式:&nbsp;</td>
				<td colspan="3" style="font-size: 18px;line-height: 40px;">
					<c:forEach var="childPayType" items="${childPayType1}">
						<label for="payType${childPayType.dbid }"><input id="payType${childPayType.dbid }" type='checkbox' name="payType"  value="${childPayType.dbid }" onclick="payMent('#pt${childPayType.dbid }')"    tip="支付方式至少选中一项"/> ${childPayType.name }</label>
					</c:forEach>
				</td>
			</tr>
			<tr  style="display:none" id="zf">
				<td>
					客户支付方式：
				</td>
				<td colspan="3" >
					<c:forEach var="childPayType" items="${childPayType1 }">
						<span style="display:none" id="pt${childPayType.dbid }" >${childPayType.name }:&nbsp;<input type="text" name="${childPayType.engName }"   onkeyup="totalAmount(this),collectionIsCorrect(this)" onfocus="totalAmount(this),collectionIsCorrect(this)" id="pt1${childPayType.dbid }" class="small text" title="${childPayType.name }" checkType="float,0" tip="支付宝金额不能为空，且为数字类型"></span>
					</c:forEach> 
				</td>
			</tr> 
			<tr height="32">	
				<td class="formTableTdLeft">摘要:&nbsp;</td>
				<td colspan="">
					<input name="cashier.abstract_"  id="abstract_" title="摘要"  class="text large" ></input>
				</td>
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="">
					<input name="cashier.cashRemark"  id="cashRemark" title="备注"  class="text large" ></input>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" >销售人员：&nbsp;</td>
					<td id="yearSupPriceTr" >
						<input type="text"  readonly="readonly" name="salesManName" id="salesManName"	value="${advancePayment.salesManName }" class="large text" title="销售人员" >
					</td>
					<td class="formTableTdLeft">创建人：&nbsp;</td>
				<td>
					<input readonly="readonly"  type="text" name="creator" id="agent" class="large text" title="创建人" value="${advancePayment.creator}">
				</td>
			</tr>
		</table>
		
	</form>
	<div class="formButton">
		<a id="correct"  href="javascript:void(-1)" onclick="$.utile.submitFrm('frmId','${ctx}/advancePayment/saveCashier')" 	class="but butSave dis" >确定收银（￥${advancePayment.totalMoney }）</a>
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
//判断实收总额是否正确
function  collectionIsCorrect(s){
	var actureMoney = $("#actureMoney").val();
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
				var total = parseFloat($("#actureMoney").val())-parseFloat($(s).children().eq(0).val());
				$(s).children().eq(0).val("");
			}	
		}
	}else{
		$("#zf").hide();
		$(s).css("display","none");
		if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
			var total = parseFloat($("#actureMoney").val())-parseFloat($(s).children().eq(0).val());
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
		//$("#actureMoney").val(total);
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

function formatFloat(x) {
    var f_x = parseFloat(x);
    if (isNaN(f_x)) {
        return 0;
    }
    var f_x = Math.round(x * 100) / 100;
    var s_x = f_x.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    return s_x;
}

</script>
</html>