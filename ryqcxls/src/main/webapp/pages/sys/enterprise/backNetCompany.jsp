<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx}/widgets/charscode.js"></script>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<style type="text/css">
	#areaLabel select {
		width: 93px;
}
</style>
<title>经销商</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">经销商</a>
</div>
<div class="line"></div>
<div class="alert alert-error">
	<strong>提示:</strong> 退网经销商【<span style="font-size: 20px;">${enterprise.name}</span>】,经销商退网将停用经销商所有用户，同时把所有客户资料转出到新经销商。
</div>
<div class="frmContent" style="margin-bottom: 50px;">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">简称:&nbsp;</td>
				<td>${enterprise.name }</td>
				<td class="formTableTdLeft">全称：</td>
				<td id="areaLabel">
					${enterprise.allName}
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">电话:&nbsp;</td>
				<td >${enterprise.phone }</td>
				<td class="formTableTdLeft">传真:&nbsp;</td>
				<td >${enterprise.fax }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">邮编:&nbsp;</td>
				<td >
					${enterprise.zipCode }
				</td>
				<td class="formTableTdLeft">地址:&nbsp;</td>
				<td >${enterprise.address }</td>
			</tr>
		</table>
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="enterpriseId" value="${enterprise.dbid }" id="enterpriseId">
		<input type="hidden" name="nextEnterpriseId" value="" id="nextEnterpriseId">
		<input type="hidden" name="redirectType" value="${param.redirectType }" id="redirectType">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">接受客户经销商:&nbsp;</td>
				<td >
				<input type="text" name="enterpriseName" id="enterpriseName"
					value="" class="largeX text" title="接受客户经销商"	checkType="string,1" onfocus="autoCompany('enterpriseName')"	 tip="接受客户经销商不能为空" placeholder='请输入接受客户经销商拼音'><span style="color: red;">*</span>
					接受退网经销商客户的目标经销商。
					</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
						<textarea cols="59" rows="10" id="content" name="content" style="width: 786px;height: 60px;">${enterprise.content }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="smt()"	class="but butSave">保存</a> 
		<a href="javascript:void(-1)"	onclick="window.history.go(-1)"	class="but butCancle">返回</a> 
	</div>
	</div>
</body>
<script type="text/javascript">
function autoCompany(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/enterprise/autoCompany",{
			max: 20,      
	        width: 130,    
	        matchSubset:false,   
	        matchContains: true,  
			dataType: "json",
			parse: function(data) {   
		    	var rows = [];      
		        for(var i=0; i<data.length; i++){      
		           rows[rows.length] = {       
		               data:data[i]       
		           };       
		        }       
		   		return rows;   
		    }, 
			formatItem: function(row, i, total) {   
		       return "<span>名称："+row.name+"&nbsp;&nbsp;&nbsp;&nbsp; </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect);
	//计算总金额
}

function onRecordSelect(event, data, formatted) {
	$("#nextEnterpriseId").val(data.companyId);
	$("#enterpriseName").val(data.name);
}
function valData(){
	var compnayId=$("#nextEnterpriseId").val();
	if(compnayId==''||compnayId==undefined||compnayId<0){
		alert("请输入接受客户经销商");
		$("#enterpriseName").focus();
		return false;
	}
	return true;
}
function smt(){
	if(valData()==true){
		if(confirm('确定将【${enterprise.name}退网吗？一旦操作将系统不可恢复。】')){
			$.utile.submitForm('frmId','${ctx}/enterprise/saveBackNetCompany')
		}
	}
}
</script>
</html>