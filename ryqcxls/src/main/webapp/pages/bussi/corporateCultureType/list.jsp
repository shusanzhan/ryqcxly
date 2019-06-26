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
<title>Banner设置</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">Banner设置</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/corporateCultureType/edit','添加Banner设置',560,360)">添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/corporateCultureType/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/corporateCultureType/queryList" metdod="get">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
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
				<td class="span2"></td>
				<td class="span2">名称</td>
				<td class="span2">创建时间</td>
				<td class="span2">修改时间</td>
				<td class="span2">版本</td>
				<td class="span2">类型</td>
				<td class="span1">排序</td>
				<td class="span4">备注</td>
				<td class="span2">操作</td>
			</tr>
		</thead>
		<c:forEach var="corporateCultureType" items="${page.result }">
			<tr height="32" align="center" style="height: 60px;">
				<td >
					<c:if test="${corporateCultureType.status==2 }">
						<input type='checkbox' name="id" id="id1" value="${corporateCultureType.dbid }"/>
					</c:if>
				</td>
				<td>
						<img alt="" src="${corporateCultureType.picture }" style="height: 60px;padding: 5px;">
				</td>
				<td>
					${corporateCultureType.name }
				</td>
				<td >
					<fmt:formatDate value="${corporateCultureType.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>  
				</td>
				<td >
					<fmt:formatDate value="${corporateCultureType.modifyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>  
				</td>
				<td >
					V.${corporateCultureType.version }
				</td>
				<td >
					<c:if test="${corporateCultureType.status==1 }">
						<span style="color: #999">系统创建</span>
					</c:if>
					<c:if test="${corporateCultureType.status==2 }">
						用户创建
					</c:if>
				</td>
				<td>
					${corporateCultureType.orderNum}
				</td>
				<td style="text-align: left;">${corporateCultureType.note} </td>
				<td>
					<c:if test="${corporateCultureType.status==1 }">
						-
					</c:if>
					<c:if test="${corporateCultureType.status==2 }">
						<a class="aedit" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx }/corporateCultureType/edit?dbid=${corporateCultureType.dbid}','编辑Banner设置',560,360)">编辑</a>
						|
						<a href="javascript:void(-1)" class="aedit"
						onclick="$.utile.deleteById('${ctx }/corporateCultureType/delete?dbids=${corporateCultureType.dbid}')">删除</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>