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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<title>绑定客户</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="dbid" id="dbid" value="${customerRecord.dbid}">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 20px;">
			<tbody  >
				<tr  height="42" >
					<td class="formTableTdLeft">登记时间:&nbsp;</td>
					<td >
						<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/> 
					</td>
					<td class="formTableTdLeft">进店时间:&nbsp;</td>
					<td id="carModelLabel">
						${customerRecord.comeInTime}
					</td>
				</tr>
				<tr  height="42" >
					<td class="formTableTdLeft">类型:&nbsp;</td>
					<td >
						${customerRecord.customerType.name }
					</td>
					<td class="formTableTdLeft">随行人数:&nbsp;</td>
					<td id="carModelLabel">
						${customerRecord.customerNum}人
					</td>
				</tr>
				<tr  height="42" >
					<td class="formTableTdLeft">客户电话：</td>
					<td style="width: 240px;">
						<input  type="hidden"  class="largeX text" id="customerId" name="customerId" >
						<input  type="text"  class="largeX text" id="name" name="name"   value="" onfocus="autoCustomer('name')" placeholder="请输入联系电话">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerRecord/saveBindCustomer')"	class="but butSave">保存</a>
		<a  href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取消</a>  
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function autoCustomer(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/customerRecord/ajaxUserCustomer",{
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
				return "<span>客户姓名："+row.name+"&nbsp;&nbsp;&nbsp;联系电话："+row.mobilePhone+"&nbsp;&nbsp;销售顾问："+row.salerName+"</span>";   
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
	$("#saler").val(data.salerName);
	$("#salerId").val(data.salerId);
	$("#mobilePhone").val(data.mobilePhone);
	$("#name").val(data.name);
	$("#customerId").val(data.dbid);
}
</script>
</html>