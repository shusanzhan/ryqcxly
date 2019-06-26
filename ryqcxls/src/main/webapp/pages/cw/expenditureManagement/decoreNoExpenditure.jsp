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
</style>
<title>支出</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashDecore/queryList'">预收收款列表</a>-
<a href="#">车辆成本支出</a>
</div>
<div class="line"></div>
 <div class="frmContent">
 <div class="frmTitle" onclick="showOrHiden('contactTable')">基本信息</div>
<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height = "42px">
		<td style="width:20%">装饰出库单号：&nbsp;</td>
					<td style="width:30%">
						<input type="text" name="outNo" id="outNo"  class="largeX text"  checkType="string,1,50" tip="请输入装饰出库单号" onfocus="autoCarCost('vinCode')"></input>
						<span style="color: red">*</span>
					</td>
			<td style="width:20%">客户姓名：&nbsp;</td>
			<td style="width:30%" id="custTel">		
				<input type="text" name="carName" id="carName"  class="largeX text"  checkType="string,1,50" readonly="readonly"></input>
			</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">电话号码：&nbsp;</td>
					<td style="width:30%">
						<input type="text" name="finName" id="finName"  class="largeX text"  checkType="string,1,50"  readonly="readonly"></input>
					</td>
			<td style="width:20%">装饰成本：&nbsp;</td>
			<td style="width:30%" id="custTel">		
				<input type="text" name="finCarCost" id="surplusAmount"  class="largeX text"  checkType="string,1,50"  readonly="readonly"></input>
			</td>
	</tr>
</table> 
</div>
	<div class="frmContent">
	<div class="frmTitle" onclick="showOrHiden('contactTable')">支出操作</div>
	<form action="" name="frmId" id="frmId" >
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">	
	<tr height = "42">
		<td style="width:20%">支出单号：&nbsp;</td>
			<td style="width:30%">
					<input type="text" name="orderNo" id="oderNo"  class="largeX text"  checkType="string,1,50" tip="请填写收银号"></input>
					<input type="hidden" name="dbid" id="dbid">
					<span style="color: red">*</span>
			</td>
			<td style="width:20%">支出日期：&nbsp;</td>
			<td style="width:30%">
					<input type="text"  name="expenditureDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" id="expenditureDate"  class="largeX text"  checkType="string,1,50" tip="收款日期"></input>
					<span style="color: red">*</span>
			</td>
	</tr>
	<tr>
			<td style="width:20%">支出方式：&nbsp;</td>
			<td style="width:30%">
					<c:forEach var="ChildPayType" items="${childPayType}">
					<!-- checkType="checkBox" -->
					<label for="payType${ChildPayType.dbid }">${ChildPayType.name }</label><input type='checkbox' name="payType" id="payType${ChildPayType.dbid }"  value="${ChildPayType.dbid }" onclick="payMent('#pt${ChildPayType.dbid }')"    tip="支付方式至少选中一项"/>
					</c:forEach>
				</td>
				<td style="width:20%">支出金额：&nbsp;</td>
			<td style="width:30%">
					<input type="text"  name="expenditureMoney" id="expenditureMoney"  class="largeX text"  checkType="string,1,50" tip="请填写收据号" readonly="readonly" ></input>
					<span style="color: red">*</span>
			</td>
	</tr>
	<tr  style="display:none" id="zf">
				<td colspan="4" >
				<table>
					<tr>
						<c:forEach var="ChildPayType" items="${childPayType }">
							<td style="display:none" id="pt${ChildPayType.dbid }" >${ChildPayType.name }:&nbsp;<input type="text" name="${ChildPayType.engName }"   onkeyup="totalAmount(this),collectionIsCorrect()" onfocus="totalAmount(this),collectionIsCorrect()" id="pt1${ChildPayType.dbid }" class="small text" title="${ChildPayType.name }" checkType="float,0" tip="支付宝金额不能为空，且为数字类型"></td>
						</c:forEach> 
					</tr>
					</table>
					</td>
			</tr> 
		<tr>
			<td style="width:20%">支款人：&nbsp;</td>
			<td style="width:30%">
					<input type="text"  name="expenditurePayee" id="payee"  class="largeX text" value="${sessionScope.user.realName }"  readonly="readonly"></input>
			</td>
			<td style="width:20%">经办人：&nbsp;</td>
			<td style="width:30%">
					<input type="text"  name="expenditureAgent" id="agent"  class="largeX text" value="${sessionScope.user.realName }" readonly="readonly"></input>
			</td>
		</tr>
		<tr>
			<td style="width:20%">制单人：&nbsp;</td>
			<td style="width:30%">
					<input type="text"  name="expenditureSinglePerson" id="singlePerson"  class="largeX text" value="${sessionScope.user.realName }"  readonly="readonly"></input>
			</td>
		</tr>
		<tr>
			<td >备注：&nbsp;</td>
			<td colspan="4">
					<textarea  name="remark" id="remark"  class="largeX text" style="height: 120px;width: 95%;">${orderContractExpenses.note }</textarea>
			</td>
		</tr>	
	</table>
	</form>
	</div>
	<div class="formButton">
		<a href="javascript:void(-1)"	 id="correct"  onclick="$.utile.submitFrm('frmId','${ctx}/expenditureManagement/saveCarCostExpenditure')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <!-- <a id="error" class="but butSave" style="color:gray;" readonly="readonly" tip="请选择支出方式！"> 保&nbsp;&nbsp;存</a> -->
	    <a href="javascript:void(-1)"	onclick="window.historry.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</body>
<script type="text/javascript">
 //判断实收总额是否正确
function  collectionIsCorrect(){
	 //支出金额
	var expenditureMoney = $("#expenditureMoney").val();
	 //剩余金额
	var surplusAmount = $("#surplusAmount").val();
	if(expenditureMoney!=null && expenditureMoney!="" && surplusAmount!=null && surplusAmount!=""){
		if(parseFloat(surplusAmount)>0){
			if(parseFloat(expenditureMoney)<=parseFloat(surplusAmount)){
				$("#error").css("display","none");
				$("#correct").css("display","");
			}else{
				$("#error").css("display","");
				$("#correct").css("display","none");
				$("#error").attr("tip","支出金额大于可支出金额！");
				}
		}else{
			$("#error").css("display","");
			$("#correct").css("display","none");
			$("#error").arrt("tip","无可支出余额！");
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

function autoCarCost(id){
	 var id1 = "#" + id;
	$(id1).autocomplete("${ctx}/expenditureManagement/ajaxCarCost",{
		max:40,
		width:200,
		matchSubset:false,
		matchContains:true,
		dataType:"json",
		parse:function(data){
			var rows = [];
			for(var i=0;i<data.length;i++){
				rows[rows.length]={
						data:data[i]
				};
			}
			return rows;
		},
		formatItem:function(row,i,total){
			return "<span>VIN码："+row.vinCode+"&nbsp;&nbsp;&nbsp;车辆信息："+row.carSeriy+""+row.carModel+""+row.carColor+"</span>";
		},
		formatMatch:function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect11);
}
 function onRecordSelect11(event, data, formatted){
	$("#dbid").val(data.dbid);
	$("#vinCode").val(data.vinCode);
	var carName = data.carSeriy+data.carModel+data.carColor;
	$("#carName").val(carName);
	$("#finName").val(data.financeName);
	$("#surplusAmount").val(data.financePayMoney);
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
				var total = parseFloat($("#expenditureMoney").val())-parseFloat($(s).children().eq(0).val());
				$("#expenditureMoney").val(total);
				$(s).children().eq(0).val("");
			}	
		}
	}else{
		$("#zf").hide();
		$(s).css("display","none");
		if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
			var total = parseFloat($("#expenditureMoney").val())-parseFloat($(s).children().eq(0).val());
			$("#expenditureMoney").val(total);
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
		$("#expenditureMoney").val(total);
}
//表单提交时验证和弹出确认对话框
$.utile.submitFrm = function(frmId,url) {
	alert(123);
	var validata = validateForm(frmId);
	var invoiceValue = $("#invoiceValue").val();
	var totalMoney = $("#totalMoney").val();
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
		//防止开票金额大于实收金额
		  if(invoiceValue>totalMoney){
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