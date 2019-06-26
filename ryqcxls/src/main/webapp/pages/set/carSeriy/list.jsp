<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>车系管理</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车系管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="${ctx }/carSeriy/add?parentMenu=1">添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/carSeriy/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/carSeriy/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td>品牌：</td>
				<td>
					<select id="brandId" name="brandId" class="text midea" onchange="$('#searchPageForm')[0].submit()">
						<option value="-1">请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
				</td>
				<td>车系名称：</td>
				<td><input type="text" class="text midea"  id="name" name="name" value="${param.name}" ></input></td>
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
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead class="TableHeader">
		<tr>
			<td class="sn">
					<input type="checkbox" name="title-table-checkbox" id="title-table-checkbox"  onclick="selectAll(this,'id')">
			</td>
			<td class="span3">名称</td>
			<td  class="span3">简称</td>
			<td class="span2">品牌</td>
			<td class="span2">指导价</td>
			<td class="span1">排序</td>
			<td class="span1">启用状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="carSeriy">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${carSeriy.dbid }">
				</td>
				<td style="text-align: left;">${carSeriy.name }</td>
				<td >${carSeriy.introduction }</td>
				<td >${carSeriy.brand.name }</td>
				<td >${carSeriy.priceFrom }</td>
				<td>${carSeriy.orderNum }</td>
				<td>
					<c:if test="${carSeriy.status==1}">
						<span style="color: green;">启用</span>
					</c:if>
					<c:if test="${carSeriy.status==2}">
						<span style="color: red;">停用</span>
					</c:if>
				</td>
				<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/carSeriy/edit?dbid=${carSeriy.dbid}&parentMenu=1'">编辑</a> | 
				<c:if test="${carSeriy.status==1}">
					<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/carSeriy/stopOrStart?dbid=${carSeriy.dbid}','searchPageForm','您确定【${carSeriy.name}】停用该车系吗')">停用</a>
				</c:if>
				<c:if test="${carSeriy.status==2}">
					<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/carSeriy/stopOrStart?dbid=${carSeriy.dbid}','searchPageForm','您确定【${carSeriy.name}】启用该车系吗')">启用</a>
				</c:if>|
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/carSeriy/delete?dbids=${carSeriy.dbid}','searchPageForm')" title="删除">删除</a>
				|<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/carSeriyImage/carSeriyImages?carSeriyId=${carSeriy.dbid}&parentMenu=1'">添加图片</a>
				</td> 
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
