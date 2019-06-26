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
		<!-- <span style="color: #000;font-size: 14px;">已发短信总数：</span> -->
   </div>
  	<div class="seracrhOperate">
<form name="searchPageForm" id="searchPageForm" action="${ctx}/sms/queryList" method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			     <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
				 <table  cellpadding="0" cellspacing="0" class="searchTable" >
					<tr>
						<td>类型：</td>
						<td>
							<select class="text small" id="sendStatus" name="sendStatus" onchange="$('#searchPageForm')[0].submit()">
								<option value="-1">请选择...</option>
								<option value="0" ${param.sendStatus==0?'selected="selected"':'' } >发送失败</option>
								<option value="1" ${param.sendStatus==1?'selected="selected"':'' } >发送成功</option>
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
			<td class="span3">接受客户</td>
			<td class="span3">接受电话</td>
			<td class="span2">发送内容</td>
			<td class="span1">发送状态</td>
			<td class="span1">创建时间</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="sms" items="${page.result }">
			<tr>
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${sms.dbid }">
				</td>
				<td style="cursor: pointer;" title="${sms.customerName }">
					<c:if test="${fn:length(sms.customerName)>8 }">
						${fn:substring(sms.customerName,0,8) }
					</c:if> 
					<c:if test="${fn:length(sms.customerName)<=8 }">
						${sms.customerName}
					</c:if> 
				</td>
				<td style="cursor: pointer;" title="${sms.mobilePhone }">
					<c:if test="${fn:length(sms.mobilePhone)>20 }">
						${fn:substring(sms.mobilePhone,0,20) }
					</c:if> 
					<c:if test="${fn:length(sms.mobilePhone)<=20 }">
						${sms.mobilePhone }
					</c:if> 
				</td>
				<td style="text-align: left;">
					${sms.content }
				</td>
				<td >
					<c:if test="${sms.sendStatus==1 }">
						<span style="color: green">发送成功</span>
					</c:if>
					<c:if test="${sms.sendStatus==0 }">
						<span style="color: red">发送失败</span>
					</c:if>
				</td>
				<td align="center">
					<fmt:formatDate value="${sms.createTime }"/> 
				</td>
				<td style="text-align: center;">
					<c:if test="${sms.sendStatus==0 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/sms/edit?dbid=${sms.dbid}','searchPageForm','您确定要重发短信吗？')">重新发送</a> 
					</c:if>
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