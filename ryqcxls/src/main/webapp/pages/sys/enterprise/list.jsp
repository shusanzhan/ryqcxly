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
<title>经销商管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/enterprise/queryList'">经销商管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<br>

<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1);" onclick="window.location.href='${ctx}/enterprise/edit'">添加</a>
		<a class="but butCancle" href="javascript:void(-1);" onclick="	$.utile.deleteIds('${ctx }/enterprise/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		 <form name="searchPageForm" id="searchPageForm" action="${ctx}/enterprise/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
  		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>经销商：</label></td>
  				<td><input type="text" id="enterpriseName" name="enterpriseName" class="text small" value="${param.enterpriseName}"></input></td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 无用户信息！请点击“添加”按钮进行添加数据操作
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
<thead class="TableHeader">
	<tr>
		<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
		<td class="span2">名称</td>
		<td class="span2">业务类型</td>
		<td class="span4">地址</td>
		<td class="span1">邮编</td>
		<td class="span2">联系电话</td>
		<td class="span2">座机</td>
		<td class="span2">银行</td>
		<td class="span2">账号</td>
		<td class="span2" >操作</td>
	</tr>
</thead>
<c:forEach var="enterprise" items="${page.result }">
	<tr height="32" align="center">
		<td><input type='checkbox' name="id" id="id1" value="${enterprise.dbid }"/></td>
		<td align="left" style="text-align: left;">${enterprise.name }</td>
		<td align="left" style="text-align: left;">
			<c:if test="${enterprise.bussiType==1 }">
				小车业务	
			</c:if>
			<c:if test="${enterprise.bussiType==2 }">
				大卡车业务	
			</c:if>
			<c:if test="${enterprise.bussiType==3 }">
				多品牌	
			</c:if>
		</td>
		<td align="left" style="text-align: left;">${enterprise.address }</td>
		<td>${enterprise.zipCode }</td>
		<td>${enterprise.phone }</td>
		<td>${enterprise.fax }</td>
		<td>${enterprise.bank }</td>
		<td>${enterprise.account }</td>
		<td>
			<a href="javascript:void(-1)" class="aedit"	onclick="window.location.href='${ctx }/enterprise/edit?dbid=${enterprise.dbid}&redirectType=2'">编辑</a> |
			<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/enterprise/delete?dbids=${enterprise.dbid}','searchPageForm')" title="删除">删除</a>
		</td>
	</tr>
</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
</html>