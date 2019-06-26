<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>设置微信提示接收人</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1)" class="current">微信提示</a>
</div>
<div class="line"></div>
<div class="frmContent" >
<form action="" id="frmId" name="frmId" target="_self">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
	<tr id="single" height="42">
		<td class="formTableTdLeft">用户ID:&nbsp;</td>
		<td colspan="">
			<input type="hidden" name="wechatRecvier.dbid" id="dbid" value="${wechatRecvier.dbid }" class="largeX text">
			<input type="hidden" name="userDbid" id="userDbid" value="" class="largeX text">
			<input type="text" name="userId" id="userId" value="" class="largeX text" title="用户ID" onfocus="autoUser('userId')" checkType="string,1,50" tip="用户ID不能为空">
			<span style="color: red;">*</span>
		</td>
	</tr>
	<tr id="single" height="42">
		<td class="formTableTdLeft">姓名:&nbsp;</td>
		<td colspan="">
			<input type="text" name="realName" id="realName" value="" class="largeX text" title="姓名" checkType="string,1,50" tip="姓名不能为空">
			<span style="color: red;">*</span>
		</td>
	</tr>
	<tr id="single" height="42">
		<td class="formTableTdLeft">电话:&nbsp;</td>
		<td colspan="">
			<input type="text" name="mobilePhone" id="mobilePhone" value="" class="largeX text"  checkType="string,1,50" tip="联系电话不能为空">
			<span style="color: red;">*</span>
		</td>
	</tr>
</table>
<div class="formButton">
		<a class="but butSave" href="javascript:void(-1)"  onclick="$.utile.submitAjaxForm('frmId','${ctx}/agentRecvier/save')">保存</a>
		<a class="but butCancle" onclick="window.history.go(-1)">返回</a>
</div>
</form>
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
function autoUser(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/user/ajaxUser",{
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
		       return "<span>用户Id："+row.userId+"&nbsp;&nbsp;&nbsp;名称："+row.name+"&nbsp;&nbsp;</span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect2);
	//计算总金额
}

function onRecordSelect2(event, data, formatted) {
		$("#realName").val(data.name);
		$("#userDbid").val(data.dbid);
		$("#userId").val(data.userId);
		$("#mobilePhone").val(data.mobilePhone);
}
</script>
</html>
