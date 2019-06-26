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
<script type="text/javascript">
</script>
<title>活动申请记录</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">活动申请记录</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
   		<form name="searchPageForm" id="searchPageForm" action="${ctx}/share/queryShareAplay" method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			     <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
			     <input type="hidden" id="dbid" name="dbid" value='${param.dbid}'>
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
<div class="alert alert-info">
		<strong>今天申请人：</strong> 
			${todayCount }&nbsp;&nbsp;&nbsp;&nbsp;
		<strong>历史申请人：</strong> 
			${last }
	</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn">序号</td>
			<td class="span2">申请车型</td>
			<td class="span2">申请人</td>
			<td class="span2">电话号码</td>
			<td class="span2">申请时间</td>
			<td class="span2">处理状态</td>
			<td class="span2">登记时间</td>
			<td class="span2">处理人</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="shareAplay" items="${page.result }">
			<tr>
				<td style="text-align: center;">
					${ shareAplay.dbid}
				</td>
				<td style="text-align: center;">
					${ shareAplay.carSeriy.name}
				</td>
				<td style="text-align: center;">
					${ shareAplay.name}
				</td>
				<td style="text-align: center;">
					${ shareAplay.phone}
				</td>
				<td style="text-align: center;">
					
					<fmt:formatDate value="${ shareAplay.applyDate}" pattern="yyyy-MM-dd HH:mm"/>	
				</td>
				<td style="text-align: center;">
					<c:if test="${shareAplay.status==1 }">
						<span style="color: red">未处理</span>
					</c:if>
					<c:if test="${shareAplay.status==2 }">
						<span style="color: green">已处理</span>
					</c:if>
				</td>
				<td style="text-align: center;">
					<fmt:formatDate value="${ shareAplay.dealDate}" pattern="yyyy-MM-dd HH:mm"/>	
				</td>
				<td style="text-align: center;">
					${shareAplay.user.realName }
				</td>
				<td style="text-align: center;">
					<c:if test="${shareAplay.status==1 }">
						<a href="${ctx }/share/editShareAplay?dbid=${shareAplay.dbid}">处理</a>
					</c:if>
					<c:if test="${shareAplay.status==2 }">
						<a href="${ctx }/share/viewShareAplay?dbid=${shareAplay.dbid}">查看</a>
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