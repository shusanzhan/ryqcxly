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
function getCheckBoxMember() {
	var array = new Array();
	var arrayNames = new Array();
	var checkeds = $("input[type='checkbox'][name='id']");
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			array.push(checkbox.value);
			arrayNames.push($(checkbox).attr("tip"));
		}
	});
	$("#members").val(array.toString()+"|"+arrayNames.toString());
}
</script>
<title>会员管理</title>
</head>
<body class="bodycolor">
 <!--location end-->
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/memMember/memberSelect" metdod="post">
  		<input type="hidden" id="members" name="members">
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>会员级别：</label></td>
  				<td>
  					<select class="text midea" id="memberShipLevelId" name="memberShipLevelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="memberShipLevel" items="${memberShipLevels }">
							<option value="${memberShipLevel.dbid }" ${parem.memberShipLevelId==memberShipLevel.dbid?'selected="selected"':'' } >${memberShipLevel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text midea" value="${param.mobilePhone}"></input></td>
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
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id');getCheckBoxMember()" /></td>
			<td class="span2">姓名</td>
			<td class="span2">常用手机号</td>
		</tr>
	</thead>
	<c:forEach var="member" items="${members }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" tip="${member.name }" value="${member.dbid }" onclick="getCheckBoxMember()"/></td>
			<td>
					${member.name }
			</td>
			<td>${member.mobilePhone }</td>
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