<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<title>转单操作记录管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/turnCustomerRecord/queryList'">转单操作管理</a>
</div>
 <!--location end-->
<div class="line"></div>

<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/turnCustomerRecord/addRoom'">添加</a>
		<a class="but butCancle" href="javascript:void(-1);" onclick="$.utile.deleteIds('${ctx }/turnCustomerRecord/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		 <form name="searchPageForm" id="searchPageForm" action="${ctx}/turnCustomerRecord/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="type" name="type" value='2'>
  		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<<%-- tr>
  				<td><label>名称：</label></td>
  				<td><input type="text" id="turnCustomerRecordName" name="turnCustomerRecordName" class="text midea" value="${param.turnCustomerRecordName}"></input></td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr> --%>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 无转单信息！请点击“添加”按钮进行添加数据操作
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
<thead class="TableHeader">
	<tr>
		<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
		<td class="span2">原销售顾问</td>
		<td class="span2">目标销顾问</td>
		<td class="span4">转单客户</td>
		<td class="span2">操作日期</td>
		<td class="span2">操作人</td>
		<td class="span2" >操作</td>
	</tr>
</thead>
<c:forEach var="turnCustomerRecord" items="${page.result }">
	<tr height="32" align="center">
		<td><input type='checkbox' name="id" id="id1" value="${turnCustomerRecord.dbid }"/></td>
		<td>${turnCustomerRecord.reBussiStaff }</td>
		<td>${turnCustomerRecord.tarBussiStaff }</td>
		<td align="left">
			<c:if test="${fn:length(turnCustomerRecord.customerName)>12 }" var="status">
				${fn:substring(turnCustomerRecord.customerName,0,12) }...
			</c:if>
			<c:if test="${status==false }">
				${turnCustomerRecord.customerName }
			</c:if>
		</td>
		<td>
		<fmt:formatDate value="${turnCustomerRecord.createTime }" pattern="yyyy-MM-dd HH:mm"/>
		</td>
		<td align="left">${turnCustomerRecord.operatorName }</td>
		<td>
			<a href="javascript:void(-1)" class="aedit"	onclick="window.location.href='${ctx }/turnCustomerRecord/view?dbid=${turnCustomerRecord.dbid}'">查看</a>
			<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.deleteById('${ctx }/turnCustomerRecord/delete?dbids=${turnCustomerRecord.dbid}','searchPageForm')">删除</a>
	</tr>
</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
</html>