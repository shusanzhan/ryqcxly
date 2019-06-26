<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>退库管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">退库记录</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/refundCar/delete','searchPageForm')">删除</a>
   	</div>
   	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/refundCar/queryList" method="post" >
			<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			<c:if test="${empty(param.orderNum) }">
				<input type="hidden" id="orderNum" name="orderNum" value='1'>
			</c:if>
			<c:if test="${!empty(param.orderNum) }">
				<input type="hidden" id="orderNum" name="orderNum" value='${param.orderNum }'>
			</c:if>
			<table cellpadding="0" cellspacing="0" class="searchTable" >
	  			<tr>
	  				<td><label>车辆：</label></td>
	  				<td>
	  					<input type="text" id="title" name="title" value="${param.title }" class="text midea" >
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
		<strong>提示!</strong> 当前无退库记录.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
			</div></td>
			<td style="width: 280px;">车辆</td>
			<td style="width: 320px;">退库原因</td>
			<td style="width: 80px;">操作人</td> 
			<td style="width:100px;">操作时间</td>
			<td style="width: 200px;">备注</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result}" var="refundCar" varStatus="i">
		<tr >
			<td style="text-align: center;">
				<input type="checkbox"   name="id" id="id1" value="${refundCar.dbid }">
			</td>
			<td>
				${refundCar.title }
			</td>
			<td>
				${refundCar.reason}
			</td>
			<td>
				${refundCar.operator}
			</td>
			<td>
				<fmt:formatDate value="${refundCar.date}" pattern="yyyy-MM-dd"/> 
			</td>
			<td style="text-align: left;">
				${refundCar.note}
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
</html>
