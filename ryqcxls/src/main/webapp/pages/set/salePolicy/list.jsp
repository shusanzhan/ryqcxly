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
<title>商务政策</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">商务政策</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/salePolicy/add'">添加</a>
		<a class="but button" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/salePolicy/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/salePolicy/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td class="formTableTdLeft" >用户类型:&nbsp;</td>
				<td>
					<select id="distributorTypeId" name="distributorTypeId" class="midea text" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<c:forEach var="distributorType" items="${distributorTypes }">
							<option value="${distributorType.dbid }" ${param.distributorTypeId==distributorType.dbid?'selected="selected"':'' } >${distributorType.name }</option>
						</c:forEach>
					</select>
				</td>
  				<td><label>名称：</label></td>
  				<td><input type="text" id="title" name="title" class="text midea" value="${param.title}"></input></td>
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
			<td class="span4">标题</td>
			<td class="span2">经销商类型</td>
			<td class="span2">创建人</td>
			<td class="span2">车架时间</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="salePolicy" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${salePolicy.dbid }"/></td>
			<td style="text-align: left;">
				<a href="javascript:void(-1)"  style="color: #46A0DE;"onclick="$.utile.openDialog('${ctx }/salePolicy/read?dbid=${salePolicy.dbid }&readIn=0','${salePolicy.title }',1024,560)">${salePolicy.title }</a>
			</td>
			<td >
				${salePolicy.distributorType.name} 
			</td>
			<td>${salePolicy.user.realName} </td>
			<td>${salePolicy.createDate} </td>
			<td>
				<a href="#" class="aedit"	onclick="window.location.href='${ctx }/salePolicy/edit?dbid=${salePolicy.dbid}'">编辑</a>
				<a href="#" class="aedit"	onclick="$.utile.deleteById('${ctx }/salePolicy/delete?dbids=${salePolicy.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>