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
<title>金融产品</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">金融产品</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/finProduct/add'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/finProduct/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/finProduct/queryList" method="post">
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
			<td class="span2">贷款渠道</td>
			<td class="span2">适用类型</td>
			<td class="span2">计息类型</td>
			<td class="span4">年限类型</td>
			<td class="span2">创建日期</td>
			<td class="span1">排序</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="finProduct" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${finProduct.dbid }"/></td>
			<td style="text-align: left;">${finProduct.name }</td>
			<td style="text-align: center;">
				<c:if test="${finProduct.productType==1 }">
					奇瑞徽银
				</c:if>
				<c:if test="${finProduct.productType==2 }">
					银行
				</c:if>
				<c:if test="${finProduct.productType==3 }">
					担保公司
				</c:if>
				<c:if test="${finProduct.productType==4 }">
					其他贷款渠道
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${finProduct.type==1 }">
					通用
				</c:if>
				<c:if test="${finProduct.type==2 }">
					专用
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${finProduct.interestType==1 }">
					年息
				</c:if>
				<c:if test="${finProduct.interestType==2}">
					月息
				</c:if>
			</td>
			<td style="text-align: center;">${finProduct.finYear.name} </td>
			<td style="text-align: center;">${finProduct.createDate} </td>
			<td style="text-align: center;">${finProduct.orderNum} </td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/finProduct/edit?dbid=${finProduct.dbid}'">编辑</a>
				<a href="#" class="aedit"
				onclick="$.utile.deleteById('${ctx }/finProduct/delete?dbids=${finProduct.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>