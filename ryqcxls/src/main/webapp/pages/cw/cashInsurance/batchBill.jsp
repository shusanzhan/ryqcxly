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
<title>保险批量挂账</title>
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashInsurance/queryList'">保险收银</a>-
	<a href="javascript:void(-1);" onclick="javascript:void(-1);">批量挂账</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<form action="" name="frmId1" id="frmId1" >
		<input type="hidden" name="dbid" value="${finCustomer.dbid }">
	<div class="frmTitle" onclick="showOrHiden('contactTable')">待批量挂账客户</div>
	<div>
	<c:set value="0" var="totalMoney"></c:set>
	<c:forEach var="insuranceRecord" items="${insuranceRecords }" >
		<span class="cust" style="">${insuranceRecord.insCustomer.name }【￥${insuranceRecord.rebateMoney }】</span>
		<c:set value="${insuranceRecord.rebateMoney+totalMoney }" var="totalMoney"></c:set>
		<input type="hidden" name="id" value="${insuranceRecord.dbid}">
	</c:forEach>
		<span class="cust">总金额:<i style="font-size: 18px;color: red;">￥${totalMoney}</i></span>
	</div>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">挂账操作（批量描述）</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:98%">
		<tr height = "42">
		<td class="formTableTdLeft">挂账日期：&nbsp;</td>
		<td>
			<input type="text"  name="billDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" id="settlementDate" value='<fmt:formatDate value="${now }"/>' class="largeX text"  checkType="string,1,50" tip="收款日期"></input>
			<span style="color: red">*</span>
			<input type="hidden" name="dbids" id="dbids"> 
		</td>
		<td class="formTableTdLeft">挂账原因：&nbsp;</td>
		<td>
			<input type="text"  name="reason" id="reason"   class="largeX text" ></input>
			<span style="color: red">*</span>
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft">挂账人：&nbsp;</td>
		<td>
			<input type="text"  name="billPerson" id="billPerson"  class="largeX text"  value="${sessionScope.user.realName }" readonly="readonly"></input>
			<span style="color: red">*</span>
		</td>
		<td >备注：&nbsp;</td>
			<td>
					<textarea  name="n" id="note" name="note" class="largeX text" style="height: 50px;width: 95%;"></textarea>
			</td>
	</tr>
	</table>
	
	<div class="formButton">
		<a id="correct" href="javascript:void(-1)"	 onclick="$.utile.submitFrm('frmId1','${ctx}/cashInsurance/saveBatchBill')"	class="but butSave">确定挂账（￥${totalMoney }）</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
//表单提交时验证和弹出确认对话框
$.utile.submitFrm = function(frmId,url) {
	var validata = validateForm(frmId);
	var flag = false;
	if (validata == true) {
		  var checkList = new Array();
		  $("input[name='id']").each(function(){
				checkList.push($(this).val());
			});
		  $("#dbids").val(JSON.stringify(checkList));
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