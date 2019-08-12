<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>转单操作</title>
</head>
<body class="bodycolor" style="">
	<div class="location">
       	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
       	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/turnCustomerRecord/queryList'">转单操作</a>
	</div>
	<div class="line"></div>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" value="0" name="type" id="type">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="32">
				<td class="formTableTdLeft" >原销售人员:&nbsp;</td>
				<td>
					<input type="hidden" name="reBussiStaffId" id="reBussiStaffId" value="">
					<input type="text" class="text large" name="reBussiStaff" id="reBussiStaff" value="" onfocus="autoByReUser('reBussiStaffId','reBussiStaff')" placeholder="请选择原来销售人员！" tip="请选择原来销售人员！" checkType="string,1">
				</td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft" >转单客户:&nbsp;</td>
				<td>
					<input type="hidden" id="customerIds" name="customerIds">
					<textarea readonly="readonly" class="text largeXX textarea "  name="customerNames" id="customerNames"	value="" checkType="string,1" tip="请选择转单客户"></textarea>
					<a href="javascript:void(-1)" onclick="customerSelect('customerIds','customerNames',$('#reBussiStaffId').val())">选择转单客户</a>
				</td>
			</tr>
			<tr height="42">
			    <td class="formTableTdLeft" >目标销售人员:&nbsp;</td>
				<td >
					<input type="hidden" name="tarBussiStaffId" id="tarBussiStaffId" value="">
					<input type="text" class="text large" name="tarBussiStaff" id="tarBussiStaff" value="" onfocus="autoByReUser('tarBussiStaffId','tarBussiStaff')" placeholder="请选择目标销售人员！" tip="请选择目标销售人员！" checkType="string,1">
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >备注信息:&nbsp;</td>
				<td colspan="1">
					<textarea class="text largeXX textarea "  name="note" id="note"	value="" ></textarea>
				</td>
			</tr>
		</table>
		</form>
		<div class="formButton">
			<a href="javascript:void()"	onclick="$('#type').val(0);$.utile.submitAjaxForm('frmId','${ctx}/turnCustomerRecord/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
			<a href="javascript:void()"	onclick="$('#type').val(1);$.utile.submitAjaxForm('frmId','${ctx}/turnCustomerRecord/save')"	class="but butSave">保存并继续</a> 
		    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
		</div>
	</div>
</body>
<script type="text/javascript">
function autoByReUser(reBussiStaffId,reBussiStaff){
		$("#"+reBussiStaff).autocomplete("${ctx}/userBussi/ajaxUser?",{
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
		       return "<span>"+row.name+"&nbsp;&nbsp;  </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
	});	
	$("#"+reBussiStaff).result(function(event, data, formatted){
		$("#"+reBussiStaffId).val(data.dbid);
		$("#"+reBussiStaff).val(data.name);
	});
}

	
function ajaxCustomer(dbid){
	window.location.href="${ctx}/turnCustomerRecord/add?dbid="+dbid;
}
</script>
</html>