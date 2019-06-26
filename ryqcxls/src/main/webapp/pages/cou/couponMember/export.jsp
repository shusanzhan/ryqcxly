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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>导出优惠券</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/couponMember/queryList'">优惠券管理</a>-
<a href="javascript:void(-1);">
	导出优惠券
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<div class="alert alert-info">
			<strong>提示:</strong> 请先选择导出数据条件。
	</div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="couponMember.dbid" id="dbid" value="${couponMember.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">选择优惠券类型:&nbsp;</td>
				<td>
					<select id="couponMemberTemplateId" name="couponMemberTemplateId" class="large text" onchange="ajaxCouponMemberTemplate(this.value)" >
						<option>请选择优惠券...</option>
						<c:forEach var="couponMemberTemplate" items="${couponMemberTemplates }">
							<option value="${couponMemberTemplate.dbid }" ${couponMember.couponMemberTemplate.dbid==couponMemberTemplate.dbid?'selected="selected"':'' } >${couponMemberTemplate.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft">创建时间：&nbsp;</td>
				<td >
					<input type="text" class="midea text" name="startTime" id="startTime" readonly="readonly"  onFocus="WdatePicker()"  value="${couponMember.startTime }" />~
					<input type="text" class="midea text" name="endTime" id="endTime" readonly="readonly"  onFocus="WdatePicker()"  value="${couponMember.startTime }" />
				</td>
			</tr>
			<tr>
				<td>是否使用：</td>
				<td>
					<select class="text large" id="isUse" name="isUse" onchange="$('#searchPageForm')[0].submit()">
						<option value="-1">请选择...</option>
						<option value="0" ${param.isUse==0?'selected="selected"':'' }>未使用</option>
						<option value="1" ${param.isUse==1?'selected="selected"':'' }>使用</option>
					</select>
				</td>
				<td class="formTableTdLeft">使用时间：&nbsp;</td>
				<td >
					<input type="text" class="midea text" name="useStartTime" id="useStartTime" readonly="readonly"  onFocus="WdatePicker()"   />
					~
					<input type="text" class="midea text" name="useEndTime" id="useEndTime" readonly="readonly"  onFocus="WdatePicker()"  />
				</td>
			</tr>
			<tr>
				<td>优惠类型：</td>
				<td>
					<select class="text large" id="type" name="type" >
						<option value="">请选择...</option>
						<option value="1" ${param.type==1?'selected="selected"':'' }>折扣券</option>
						<option value="2" ${param.type==2?'selected="selected"':'' }>代金券</option>
					</select>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="exportExcel('frmId')"	class="but butSave">导出EXCEL</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/couponMember/exportExcel?'+params;
 }
</script>
</html>