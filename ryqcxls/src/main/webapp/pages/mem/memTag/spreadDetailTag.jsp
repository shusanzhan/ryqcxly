<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>会员标签</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx }/widgets/select2/css/select2.min.css">
<link rel="stylesheet" href="${ctx }/widgets/artDialogMaster/css/ui-dialog.css">
<script src="${ctx }/widgets/artDialogMaster/lib/jquery-1.10.2.js"></script>
<script src="${ctx }/widgets/artDialogMaster/dist/dialog-min.js"></script>
<script src="${ctx }/pages/weixin/gzUserInfo/gzUserInfo.js?date=${now}"></script>
<script type="text/javascript" src="${ctx }/widgets/select2/js/select2.min.js"></script>
<style type="text/css">
	.select2-container--default .select2-results > .select2-results__options{
		max-height: 120px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="spreadDetailId" id="spreadDetailId" value="${spreadDetail.dbid }">
		<select class="js-example-basic-multiple text" multiple="multiple" style="width: 400px;" id="memTagIds" name="memTagIds">
			<c:forEach var="memTag" items="${memTags }">
				<c:set var="status" value="false"></c:set>
				<c:forEach var="tagId" items="${tagIds }">
					<c:if test="${memTag.dbid==tagId }">
						<c:set var="status" value="true"></c:set>
					</c:if>
				</c:forEach>
				<c:if test="${status==true }">
					<option value="${memTag.dbid }" selected="selected">${memTag.name }</option>
				</c:if>
				<c:if test="${status==false }">
					<option value="${memTag.dbid }">${memTag.name }</option>
				</c:if>
			</c:forEach>
		</select>
	</form>
</body>

<script type="text/javascript">
$(document).ready(function(){
	$(".js-example-basic-multiple").select2({ placeholder: "请选择会员标签"});
})
</script>
</html>
