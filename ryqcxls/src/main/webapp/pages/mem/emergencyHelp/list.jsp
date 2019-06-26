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
<title>购车关注点管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">道路紧急救援</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
<div class="operate">
		<a class="but button" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/emergencyHelp/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/emergencyHelp/queryList" metdod="get">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>处理情况：</label></td>
  				<td>
  					<select class="text midea" id="status" name="status"  onchange="$('#searchPageForm')[0].submit()">
						<option value="" >请选择...</option>
							<option value="false" ${param.status==false?'selected="selected"':'' } >未处理</option>
							<option value="true" ${param.status==true?'selected="selected"':'' } >已经处理</option>
					</select>
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span1">客户</td>
			<td class="span2">联系电话</td>
			<td class="span2">经纬度</td>
			<td class="span2">详细</td>
			<td class="span4">地址</td>
			<td class="span2">创建时间</td>
			<td class="span1">状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="emergencyHelp" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${emergencyHelp.dbid }"/></td>
			<td align="left" >${emergencyHelp.member.name }</td>
			<td align="left">${emergencyHelp.phone }</td>
			<td align="left" style="text-align: left;">${emergencyHelp.coordinates }</td>
			<td align="left" style="text-align: left;">${emergencyHelp.title }</td>
			<td align="left" style="text-align: left;">${emergencyHelp.address }</td>
			<td><fmt:formatDate value="${emergencyHelp.createTime }" pattern="yyyy年MM月dd日 HH:mm "/> </td>
			<td >
				<c:if test="${emergencyHelp.status==false}">
					<span style="color: red;">未处理</span>
				</c:if>
				<c:if test="${emergencyHelp.status==true}">
					<span style="color: blue;">已经处理</span>
				</c:if>
			 </td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/emergencyHelp/edit?dbid=${emergencyHelp.dbid}'">查看地图</a>
				<a href="#" class="aedit"
				onclick="$.utile.deleteById('${ctx }/emergencyHelp/delete?dbids=${emergencyHelp.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>