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
<title>车型颜色管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车型颜色管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/carColor/add'">添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/carColor/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/carColor/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>车系：</label></td>
  				<td>
  					<select id="carSeriesId" name="carSeriesId"  class="text midea" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriesId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
				</td>
  				<td><label>名称：</label></td>
  				<td>
  					<input type="text" class="text midea" id="name" name="name" value="${param.name }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">车系</td>
			<td class="span2">名称</td>
			<td class="span4">备注</td>
			<td class="span4">启用状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="carColor" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${carColor.dbid }"/></td>
			<td>${carColor.carseries.name }</td>
			<td>${carColor.name }</td>
			<td style="text-align: left;">${carColor.note} </td>
			<td>
				<c:if test="${carColor.status==1}">
					<span style="color: green;">启用</span>
				</c:if>
				<c:if test="${carColor.status==2}">
					<span style="color: red;">停用</span>
				</c:if>
			</td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/carColor/edit?dbid=${carColor.dbid}'">编辑</a>
				|
				<c:if test="${carColor.status==1}">
					<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/carColor/stopOrStart?dbid=${carColor.dbid}','searchPageForm','您确定【${carColor.name}】停用该车系吗')">停用</a>
				</c:if>
				<c:if test="${carColor.status==2}">
					<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/carColor/stopOrStart?dbid=${carColor.dbid}','searchPageForm','您确定【${carColor.name}】启用该车系吗')">启用</a>
				</c:if>|
				<a href="#" class="aedit"
				onclick="$.utile.deleteById('${ctx }/carColor/delete?dbids=${carColor.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
</html>