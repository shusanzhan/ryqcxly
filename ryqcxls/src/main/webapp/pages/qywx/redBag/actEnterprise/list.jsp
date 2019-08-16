<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>红包活动</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">红包活动</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/actEnterprise/edit'">添加</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" actEnterpriseion="${ctx}/actEnterprise/queryList" metdod="get">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">名称</td>
			<td class="span2">红包类型</td>
			<td class="span3">红包祝福语</td>
			<td class="span3">红包备注</td>
			<td class="span2">领导发放状态</td>
			<td class="span2">启用状态</td>
			<td class="span2">备注</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="actEnterprise" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${actEnterprise.dbid }"/></td>
			<td>${actEnterprise.name }</td>
			<td>${actEnterprise.act.name }</td>
			<td style="text-align: left;">${actEnterprise.wishing }</td>
			<td style="text-align: left;">${actEnterprise.remark }</td>
			<td>
				<c:if test="${actEnterprise.levelStatus==1 }">
					<span style="color: green;">发放</span>
				</c:if>
				<c:if test="${actEnterprise.levelStatus==2 }">
					<span style="color: red">停发放</span>
				</c:if>
			</td>
			<td>
				<c:if test="${actEnterprise.ssStatus==1 }">
					<span style="color: green;">启用</span>
				</c:if>
				<c:if test="${actEnterprise.ssStatus==2 }">
					<span style="color: red">停用</span>
				</c:if>
			</td>
			<td style="text-align: left;">${actEnterprise.note} </td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/actEnterprise/edit?dbid=${actEnterprise.dbid}'">编辑</a>|
				<a href="#" class="aedit" onclick="$.utile.deleteById('${ctx }/actEnterprise/delete?dbids=${actEnterprise.dbid}')">删除</a>|
				<c:if test="${actEnterprise.ssStatus==1}">
					<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/actEnterprise/stopOrStart?dbid=${actEnterprise.dbid}','searchPageForm','您确定【${actEnterprise.name}】停用该活动吗')">停用</a>
				</c:if>
				<c:if test="${actEnterprise.ssStatus==2}">
					<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/actEnterprise/stopOrStart?dbid=${actEnterprise.dbid}','searchPageForm','您确定【${actEnterprise.name}】启用该活动吗')">启用</a>
				</c:if>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../../commons/commonPagination.jsp" %>
</div>
</body>
</html>