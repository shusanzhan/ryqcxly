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
<title>企业文化</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">企业文化</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="window.location.href='${ctx}/corporateCulture/edit'">添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/corporateCulture/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/corporateCulture/queryList" metdod="get">
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
				<td class="span2">类型</td>
				<td class="span2">创建时间</td>
				<td class="span2">修改时间</td>
				<td class="span2">版本</td>
				<td class="span2">创建人</td>
				<td class="span2">pv量</td>
				<td class="span2">uv量</td>
				<td class="span2">分享量</td>
				<td class="span2">点赞量</td>
				<td class="span2">发布状态</td>
				<td class="span2">banner状态</td>
				<td class="span2">top状态</td>
				<td class="span2">操作</td>
			</tr>
		</thead>
		<c:forEach var="corporateCulture" items="${page.result }">
			<tr height="32" align="center" style="height: 60px;">
				<td >
					<c:if test="${corporateCulture.realessStatus==3||corporateCulture.realessStatus==1 }">
						<input type='checkbox' name="id" id="id1" value="${corporateCulture.dbid }" />
					</c:if>
					<c:if test="${corporateCulture.realessStatus==2}">
						<input type='checkbox'   disabled="disabled"/>
					</c:if>
				</td>
				<td>
					<img alt="" src="${corporateCulture.picture }" style="height: 60px;padding: 5px;">
				</td>
				<td>
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/corporateCulture/corporateCultureDetail?corporateCultureId=${corporateCulture.dbid}'">${corporateCulture.title }</a>
				</td>
				<td>
					${corporateCulture.corporateCultureType.name }
				</td>
				<td >
					<fmt:formatDate value="${corporateCulture.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>  
				</td>
				<td >
					<fmt:formatDate value="${corporateCulture.modifyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>  
				</td>
				<td >
					V.${corporateCulture.version }
				</td>
				<td >
					${corporateCulture.creator }
				</td>
				<td >
					${corporateCulture.pvNum }
				</td>
				<td >
					${corporateCulture.uvNum }
				</td>
				<td >
					${corporateCulture.shareNum }
				</td>
				<td >
					${corporateCulture.praiseNum }
				</td>
				<td >
					<c:if test="${corporateCulture.realessStatus==1 }">
						<span style="">草稿</span>
					</c:if>
					<c:if test="${corporateCulture.realessStatus==2 }">
						<span style="color: green;">已发布</span>
						<br>
						${corporateCulture.realessPerson }  ${corporateCulture.realessTime }
					</c:if>
					<c:if test="${corporateCulture.realessStatus==3 }">
						<span style="color: red;">停用</span>
					</c:if>
				</td>
				<td >
					<c:if test="${corporateCulture.banerStatus==1 }">
						默认
						<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/corporateCulture/banner?corporateCultureId=${corporateCulture.dbid}','searchPageForm','确定启用banner显示吗')">启用</a>
					</c:if>
					<c:if test="${corporateCulture.banerStatus==2 }">
						<span style="color: green;">显示</span>
						<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/corporateCulture/banner?corporateCultureId=${corporateCulture.dbid}','searchPageForm','确定停用banner显示吗')">停用</a>
					</c:if>
				</td>
				<td >
					<c:if test="${corporateCulture.topStatus==1 }">
						默认<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/corporateCulture/top?corporateCultureId=${corporateCulture.dbid}','searchPageForm','确定设置为最新')">启用</a>
					</c:if>
					<c:if test="${corporateCulture.topStatus==2 }">
						<span style="color: green;">新</span>
						<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/corporateCulture/top?corporateCultureId=${corporateCulture.dbid}','searchPageForm','确定停用为最新')">停用</a>
					</c:if>
				</td>
				<td>
					<c:if test="${corporateCulture.realessStatus==2 }">
						<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/corporateCulture/stop?corporateCultureId=${corporateCulture.dbid}','searchPageForm','确定停用该内容吗')">停用</a>
					</c:if>
					<c:if test="${corporateCulture.realessStatus==3||corporateCulture.realessStatus==1 }">
						<a class="aedit" href="javascript:void(-1)" onclick="window.location.href='${ctx }/corporateCulture/edit?dbid=${corporateCulture.dbid}'">编辑</a>
						|
						<a class="aedit" href="javascript:void(-1)" onclick="$.utile.operatorDataByDbid('${ctx }/corporateCulture/realess?corporateCultureId=${corporateCulture.dbid}','searchPageForm','确定发布该内容吗')">发布</a>
						|
						<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.deleteById('${ctx }/corporateCulture/delete?dbids=${corporateCulture.dbid}')">删除</a>
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