<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
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
<title>问题管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">问题管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/quest/edit'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/quest/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/quest/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>类型：</label></td>
  				<td>
  					<select class="text midea" id="questBigTypeId" name="questBigTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="questBigType" items="${questBigTypes }">
							<option value="${questBigType.dbid }" ${param.questBigTypeId==questBigType.dbid?'selected="selected"':'' } >${questBigType.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>标题：</label></td>
  				<td><input type="text" id="title" name="title" class="text midea" value="${param.title}"></input></td>
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
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span1">品牌</td>
			<td class="span1">题干</td>
			<td class="span1">编号</td>
			<td class="span1">题型</td>
			<td class="span2">区分题干</td>
			<td class="span2">类型</td>
			<td class="span2">排序</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="quest" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${quest.dbid }"/></td>
			<td >${quest.brand.name} </td>
			<td style="text-align: left;">${quest.content} </td>
			<td>${quest.no }</td>
			<td>${quest.checkType }</td>
			<td>
				<c:if test="${quest.isBetweenNetOne==1 }">
					否
				</c:if>
				<c:if test="${quest.isBetweenNetOne==2 }">
					是
				</c:if>
			</td>
			<td>${quest.questBigType.name} </td>
			<td>${quest.orderNum} </td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/quest/edit?dbid=${quest.dbid}'">编辑</a>
				<a href="#" class="aedit"
				onclick="$.utile.deleteById('${ctx }/quest/delete?dbids=${quest.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>