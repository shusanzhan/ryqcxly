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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>会员</title>
</head>
<body class="bodycolor">
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="memberId" id="memberId" value="${member.dbid }">
		<input type="hidden" name="customerId" id="customerId" value="">
		<input type="hidden" name="memberCarInfo.dbid" id="dbid" value="">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">客户信息快查:&nbsp;</td>
				<td  ><input type="text" name="name1" id="name1"
					value="" class="large text" title="名称" placeholder="请输入客户姓名或电话"	onfocus="autoCustomer('name1')">
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">客户信息快查:&nbsp;</td>
				<td>
					<select id="useCarAreaId" name="useCarAreaId" class="large text" checkType="integer,1">
						${useCarArea }
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车主姓名:&nbsp;</td>
				<td ><input type="text"  name="memberCarInfo.name" id="name" value="" class="large text" title="车主姓名" placeholder="请输入车主姓名" title="客户姓名"	checkType="string,1" tip="车主姓名不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">手机号:&nbsp;</td>
				<td ><input type="text"  name="memberCarInfo.mobilePhone" id="mobilePhone"	 class="large text" placeholder="请输入常用手机号" title="常用手机号"	checkType="mobilePhone" tip="常用手机号不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td ><input type="text"  name="memberCarInfo.car" id="car"	value="" class="large text" title="车型" placeholder="请输入车型" 	checkType="string,1" tip="车型不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">vin码:&nbsp;</td>
				<td ><input type="text"  name="memberCarInfo.vinCode" id="vinCode"	value="" class="large text" title="vin码"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td ><input type="text" name="memberCarInfo.carPlate" id="carPlate"	value="" class="large text"   title="车牌号"	></td>
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td ><input type="text" name="memberCarInfo.note" id="note"	value="" class="large text"   title="备注"	></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/member/saveAuth')"	class="but butSave">认证</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
<c:if test="${empty(memberCarInfos)||fn:length(memberCarInfos)<=0 }" var="status">
	<div class="alert alert-error">无认证车主信息</div>
</c:if>
<c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">姓名</td>
			<td class="span2">联系电话</td>
			<td class="span2">车牌</td>
			<td class="span2">车架号</td>
			<td class="span4">备注</td>
			<td class="span4">操作</td>
		</tr>
	</thead>
	<c:forEach var="memberCarInfo" items="${memberCarInfos }">
		<tr height="32" align="center">
			<td>
				${memberCarInfo.name }	
			</td>
			<td>
				${memberCarInfo.mobilePhone }	
			</td>
			<td>
				${memberCarInfo.carPlate }	
			</td>
			<td>
				${memberCarInfo.vinCode }	
			</td>
			<td>
				${memberCarInfo.note }	
			</td>
			<td>
				<a href="javasrcipt:void(-1)" onclick="ajaxMemberCarInfo(${memberCarInfo.dbid})">编辑</a>
			</td>
		</tr>
	</c:forEach>
</table>	
</c:if>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function autoCustomer(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/member/autoCustomer",{
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;联系电话： "+row.mobilePhone+"&nbsp;&nbsp;身份证："+row.icard+"&nbsp;&nbsp;车系："+row.carSeriyName+"&nbsp;&nbsp; </span>";   
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
		$("#customerId").val(data.customerId);
		$("#name").val(data.name);
		$("#name1").val(data.name);
		$("#mobilePhone").val(data.mobilePhone);
		$("#car").val(data.car);
		$("#vinCode").val(data.vinCode);
		$("#carPlate").val(data.carPlate);
}
function ajaxMemberCarInfo(dbid){
	$.post('${ctx}/member/ajaxMemberCarInfo?memberCarInfoId='+dbid+"&date="+new Date(),{},function(data){
		$("#customerId").val(data.customerId);
		$("#name").val(data.name);
		$("#mobilePhone").val(data.mobilePhone);
		$("#car").val(data.car);
		$("#vinCode").val(data.vinCode);
		$("#carPlate").val(data.carPlate);
		$("#note").val(data.note);
		$("#dbid").val(data.dbid);
	})
}
</script>
</html>