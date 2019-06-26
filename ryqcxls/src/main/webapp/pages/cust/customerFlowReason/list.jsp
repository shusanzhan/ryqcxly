<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>战败原因</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">战败原因</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="${ctx }/customerFlowReason/add">	添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/customerFlowReason/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/customerFlowReason/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td>名称：</td>
				<td><input type="text" class="text midea"  id="name" name="name" value="${param.name}" ></input></td>
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
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead class="TableHeader">
				<tr>
					<td class="sn">
						<input type="checkbox" name="title-table-checkbox" id="title-table-checkbox"  onclick="selectAll(this,'id')">
					</th>
					<td class="span2">名称</tdh>
					<td class="span5" style="text-align: center;">备注</td>
					<td class="span2">创建时间</td>
					<td class="span1">排序</td>
					<td class="span2">操作</td>
				</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.result }" var="customerFlowReason">
		<tr>
				<td style="text-align: center;"><input type="checkbox"   name="id" id="id1" value="${customerFlowReason.dbid }">
				</td>
				<td align="left" style="text-align: left;">${customerFlowReason.name }</td>
				<td style="text-align: left;">
					${customerFlowReason.note }
				</td>
				<td style="text-align: center;">${customerFlowReason.createDate }</td>
				<td style="text-align: center;">${customerFlowReason.orderNum }</td>
				<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerFlowReason/edit?dbid=${customerFlowReason.dbid}&parentMenu=3'">编辑</a> | 
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/customerFlowReason/delete?dbids=${customerFlowReason.dbid}','searchPageForm')" title="删除">删除</a></td>
			</tr> 
			</c:forEach>
		</tbody>
	</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
