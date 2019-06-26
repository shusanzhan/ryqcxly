<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript">
/** 获取checkBox的value* */
function getCheckBoxsmsTemplate() {
	var array = new Array();
	var arrayNames = new Array();
	var checkeds = $("input[type='checkbox'][name='id']");
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			array.push(checkbox.value);
			arrayNames.push($(checkbox).attr("tip"));
		}
	});
	$("#smsTemplates").val(array.toString()+"|"+arrayNames.toString()+"专属顾问${sessionScope.user.realName}${sessionScope.user.mobilePhone}");
}
</script>
<title>会员管理</title>
</head>
<body class="bodycolor">
 <!--location end-->
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/smsTemplate/smsTemplateSelect" metdod="post">
  		<input type="hidden" id="smsTemplates" name="smsTemplates">
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>类型：</label></td>
  				<td>
 					<select class="text small" id="type" name="type" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.type==1?'selected="selected"':'' } >商务营销</option>
						<option value="2" ${param.type==2?'selected="selected"':'' } >日常祝福</option>
						<option value="3" ${param.type==3?'selected="selected"':'' } >生日祝福</option>
						<option value="4" ${param.type==4?'selected="selected"':'' } >节日祝福</option>
					</select>
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id');getCheckBoxsmsTemplate()" /></td>
			<td class="span2">名称</td>
			<td class="span2">类型</td>
			<td class="span2">内容</td>
		</tr>
	</thead>
	<c:forEach var="smsTemplate" items="${smsTemplates }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" tip="${smsTemplate.content }" value="${smsTemplate.dbid }" onclick="getCheckBoxsmsTemplate()"/></td>
			<td>
				${smsTemplate.name }
			</td>
			<td>
				<c:if test="${smsTemplate.type==1 }">商务营销</c:if>
				<c:if test="${smsTemplate.type==2 }">日常祝福</c:if>
				<c:if test="${smsTemplate.type==3 }">生日祝福</c:if>
				<c:if test="${smsTemplate.type==4 }">节日祝福</c:if>
			</td>
			<td style="text-align: left;">
				${smsTemplate.content }
			</td>
		</tr>
	</c:forEach>
</table>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>