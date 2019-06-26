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
		<a class="but button" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/bussiBanner/edit','添加Banner设置',560,360)">添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/bussiBanner/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/bussiBanner/queryList" metdod="get">
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
				<td class="span2">标题</td>
				<td class="span2">创建时间</td>
				<td class="span2">修改时间</td>
				<td class="span2">状态</td>
				<td class="span2">操作</td>
			</tr>
		</thead>
		<c:forEach var="bussiBanner" items="${page.result }">
			<tr height="32" align="center" style="height: 60px;">
				<td >
					<input type='checkbox' name="id" id="id1" value="${bussiBanner.dbid }"/>
				</td>
				<td>
					<img alt="" src="${bussiBanner.picture }" style="height: 60px;padding: 5px;">
				</td>
				<td>
					<a href="javascript:void(-1)" onclick="window.open('${bussiBanner.url}')">${bussiBanner.title }</a>
				</td>
				<td >
					<fmt:formatDate value="${bussiBanner.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>  
				</td>
				<td >
					<fmt:formatDate value="${bussiBanner.modifyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>  
				</td>
				<td style="">
					${bussiBanner.stateName }
				 </td>
				<td>
						<a class="aedit" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx }/bussiBanner/edit?dbid=${bussiBanner.dbid}','编辑Banner设置',560,360)">编辑</a>
						<a href="javascript:void(-1)" class="aedit"
						onclick="$.utile.deleteById('${ctx }/bussiBanner/delete?dbids=${bussiBanner.dbid}')">删除</a>
						<c:if test="${bussiBanner.state==1 }">
							<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/bussiBanner/stopOrStart?dbid=${bussiBanner.dbid}','searchPageForm','确定停用该内容吗')">停用</a>
						</c:if>
						<c:if test="${bussiBanner.state==2 }">
						<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/bussiBanner/stopOrStart?dbid=${bussiBanner.dbid}','searchPageForm','确定启用该内容吗')">启用</a>
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