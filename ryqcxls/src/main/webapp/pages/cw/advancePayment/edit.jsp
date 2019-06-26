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
<title>添加定金结算客户</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/advancePayment/queryList'">预收收银</a>-
		<c:if test="${empty(advancePayment) }">
			<a href="javascript:void(-1);" onclick="">添加预收客户</a>
		</c:if>
		<c:if test="${!empty(advancePayment) }">
			<a href="javascript:void(-1);" onclick="">编辑预收客户</a>
		</c:if>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="customerId" id="customerId" value="${advancePayment.custId }">
		<input type="hidden" name="advancePayment.dbid" id="dbid" value="${advancePayment.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr height="42">
				<td class="formTableTdLeft" >电话号码:&nbsp;</td>
				<td ><input type="text"  name="advancePayment.custTel" id="custTel" value="${advancePayment.custName }"  onfocus="autoCust('custTel')" placeholder="请输入客户电话号码" class="large text" title="名字"   checkType="string,1,11" tip="电话号码不能为空" /><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td ><input type="text" name="advancePayment.custName" id="custName" readonly="readonly"	value="${advancePayment.custName }" class="large text" title="客户姓名"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">收款类别:&nbsp;</td>
				<td id="finProductIdTr">
					<select id="childReceivablesTypeId" name="childReceivablesTypeId" class="large text" checkType="integer,1" tip="收款类别不能为空">
						<option value="">请先选择...</option>
						<c:forEach items="${childReceivablesTypes }" var="childReceivablesType">
							<option value="${childReceivablesType.dbid }" ${advancePayment.childReceivablesType.dbid==childReceivablesType.dbid?'selected="selected"':''} >${childReceivablesType.name }</option>
						</c:forEach>
					</select>
				<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">创建来源:&nbsp;</td>
				<td id="finProductIdTr">
					<select id="createSource" name="advancePayment.createSource" class="large text" checkType="string,1,50" tip="创建来源不能为空"  disabled="disabled">
						<option value="">请选择...</option>					
						<option value="1" >订单创建</option>
						<option value="2"  selected="selected">收款创建</option>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">客户类型:&nbsp;</td>
				<td id="finProductItemTr">
					<select id="custType" name="advancePayment.custType" class="large text" checkType="string,1,50" tip="客户类型不能为空">
						<option value="">请先选择...</option>
						<option value="1" ${advancePayment.custType==1?'selected="selected"':'' } >展厅（网销）客户</option>					
						<option value="2" ${advancePayment.custType==2?'selected="selected"':'' } >二网客户</option>		
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft" >本笔总额:&nbsp;</td>
				<td id="monthSupPriceTr">
					<input type="text" name="advancePayment.totalMoney" value="${advancePayment.totalMoney }" id="totalMoney" class="large text" title="本笔总额"  checkType="float,0" tip="本笔总额不能为空,且只能为数字"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" >销售人员：&nbsp;</td>
				<td id="yearSupPriceTr" >
					<input type="text"  readonly="readonly" name="salesman" id="salesman"  value="${advancePayment.salesManName }" class="large text" title="销售人员" >
				</td>
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea name="advancePayment.remarks" id="remarks"  title="备注"  class="large text" >${advancePayment.remarks }</textarea>
				</td>
			</tr>
		</table>
		
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitFrm('frmId','${ctx}/advancePayment/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
$.utile.submitFrm = function(frmId,url) {
	var validata = validateForm(frmId);
	if (validata == true) {
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
function autoCust(id){
	 var id1 = "#" + id;
	$(id1).autocomplete("${ctx}/advancePayment/ajaxCustomer",{
		max:20,
		width:130,
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
			return "<span>客户Id："+row.dbid +"&nbsp;&nbsp;&nbsp电话号码："+row.mobilePhone+"&nbsp;&nbsp;&nbsp;客户姓名："+row.name+"&nbsp;&nbsp;&nbsp;销售顾问："+row.salesman+"</span>";
		},
		formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		formatResult: function(row) {   
		       return row.name;   
		   }		
		});
	$(id1).result(onRecordSelect11);
}
 function onRecordSelect11(event, data, formatted){
	$("#custName").val(data.name);
	$("#customerId").val(data.dbid);
	$("#custTel").val(data.mobilePhone);
	$("#salesman").val(data.salesman);
	$("#salesmanId").val(data.salesmanId);
} 
</script>
</html>