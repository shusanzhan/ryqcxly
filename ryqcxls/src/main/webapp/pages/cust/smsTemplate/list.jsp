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
<title>短信模板管</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">短信模板管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/smsTemplate/add'">添加</a>
		<c:if test="${sessionScope.user.userId=='admin' }">
			<a class="but button" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/smsTemplate/delete','searchPageForm')">删除</a>
		</c:if>
   </div>
  	<div class="seracrhOperate">
   		<form name="searchPageForm" id="searchPageForm" action="${ctx}/smsTemplate/queryList" method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			     <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
				 <table  cellpadding="0" cellspacing="0" class="searchTable" >
					<tr>
						<td>类型：</td>
						<td>
							<select class="text small" id="type" name="type" onchange="$('#searchPageForm')[0].submit()">
								<option value="">请选择...</option>
								<option value="1" ${param.type==1?'selected="selected"':'' } >商务营销</option>
								<option value="2" ${param.type==2?'selected="selected"':'' } >日常祝福</option>
								<option value="3" ${param.type==3?'selected="selected"':'' } >生日祝福</option>
								<option value="4" ${param.type==4?'selected="selected"':'' } >节日祝福</option>
							</select>
						</td>
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
			<td class="span1">名称</td>
			<td class="span1">类型</td>
			<td class="span4">内容</td>
			<td class="span1">创建时间</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="smsTemplate" items="${page.result }">
			<tr>
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${smsTemplate.dbid }">
				</td>
				<td>
					${smsTemplate.name }
				</td>
				<td>
					<c:if test="${smsTemplate.type==1 }">必发短信</c:if>
					<c:if test="${smsTemplate.type==2 }">商务营销</c:if>
					<c:if test="${smsTemplate.type==3 }">日常祝福</c:if>
					<c:if test="${smsTemplate.type==4 }">生日祝福</c:if>
					<c:if test="${smsTemplate.type==5 }">节日祝福</c:if>
				</td>
				<td style="text-align: left;">
					${smsTemplate.content }
				</td>
				<td align="center">
					<fmt:formatDate value="${smsTemplate.createTime }"/> 
				</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/smsTemplate/edit?dbid=${smsTemplate.dbid}'">编辑</a> |
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/smsTemplate/delete?dbids=${smsTemplate.dbid}','searchPageForm')" title="删除">删除</a>
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