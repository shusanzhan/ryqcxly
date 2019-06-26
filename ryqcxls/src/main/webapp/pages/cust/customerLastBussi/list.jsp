<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>客户跟踪信息</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户跟踪信息</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/customerTrack/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerTrack/queryList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>意向级别：</label></td>
  				<td>
  					<select id="customerPhaseId" name="customerPhaseId"  class="text midea">
						<option value="">请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
							<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
						</c:forEach>
					</select>
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
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 60px;">编号</td>
			<td style="width: 100px;">名称</td>
			<td style="width: 100px;">意向级别</td>
			<td style="width: 80px;">常用手机号</td>
			<td style="width:80px;">跟进日期</td>
			<td style="width:40px;">跟进方法</td>
			<td style="width:240px;">跟进内容</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customerTrack">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customerTrack.dbid }">
			</td>
			<td>${customerTrack.customer.sn }</td>
			<td>
					<c:if test="${fn:length(customerTrack.customer.name)>12 }" var="status">
						${fn:substring(customerTrack.customer.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${customerTrack.customer.name }
					</c:if>
			</td>
			<td>
				${customerTrack.beforeCustomerPhase.name}
			</td>
			<td>
				${customerTrack.customer.mobilePhone}
			</td>
			<td>
				<fmt:formatDate value="${customerTrack.trackDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				<c:if test="${customerTrack.trackMethod==1 }">
					电话
				</c:if>
				<c:if test="${customerTrack.trackMethod==2 }">
					到店
				</c:if>
				<c:if test="${customerTrack.trackMethod==3 }">
					短信
				</c:if>
				<c:if test="${customerTrack.trackMethod==4 }">
					回访
				</c:if>
			</td>
			<td style="text-align: left;">
				<c:if test="${fn:length(customerTrack.trackContent)>40 }" var="status">
					${fn:substring(customerTrack.trackContent,0,40) }...
				</c:if>
				<c:if test="${status==false }">
					${customerTrack.trackContent }
				</c:if>
			</td>
			<td style="text-align: center;">
			<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerTrack/edit?dbid=${customerTrack.dbid}','编辑跟进记录',900,500)">编辑</a> | 
			<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/customerTrack/delete?dbids=${customerTrack.dbid}','searchPageForm')" title="删除">删除</a></td>
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
