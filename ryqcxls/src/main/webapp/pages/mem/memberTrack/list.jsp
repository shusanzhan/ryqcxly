<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>会员跟踪信息</title>
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
	<a href="javascript:void(-1);" onclick="">会员跟踪信息</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/memberTrack/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/memberTrack/queryList" method="post" >
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
			<td style="width: 80px;">名称</td>
			<td style="width: 80px;">意向级别</td>
			<td style="width: 80px;">常用手机号</td>
			<td style="width:80px;">跟进日期</td>
			<td style="width:80px;">跟进方法</td>
			<td style="width:240px;">跟进内容</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="memberTrack">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${memberTrack.dbid }">
			</td>
			<td>${memberTrack.member.no }</td>
			<td>
					<c:if test="${fn:length(memberTrack.member.name)>12 }" var="status">
						${fn:substring(memberTrack.member.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${memberTrack.member.name }
					</c:if>
			</td>
			<td>
				${memberTrack.customerPhase.name}
			</td>
			<td>
				${memberTrack.member.mobilePhone}
			</td>
			<td>
				<fmt:formatDate value="${memberTrack.trackDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				<c:if test="${memberTrack.trackMethod==1 }">
					电话
				</c:if>
				<c:if test="${memberTrack.trackMethod==2 }">
					到店
				</c:if>
				<c:if test="${memberTrack.trackMethod==3 }">
					短信
				</c:if>
				<c:if test="${memberTrack.trackMethod==4 }">
					回访
				</c:if>
			</td>
			<td style="text-align: left;">
				<c:if test="${fn:length(memberTrack.trackContent)>30 }" var="status">
					${fn:substring(memberTrack.trackContent,0,30) }...
				</c:if>
				<c:if test="${status==false }">
					${memberTrack.trackContent }
				</c:if>
			</td>
			<td style="text-align: center;">
			<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/memberTrack/edit?dbid=${memberTrack.dbid}','编辑跟进记录',900,500)">编辑</a> | 
			<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/memberTrack/delete?dbids=${memberTrack.dbid}','searchPageForm')" title="删除">删除</a></td>
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
