<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>市场活动管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/progressbars/css/style.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">市场活动管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		 <a class="but butSave" href="javascript:void();" onclick="window.location.href='${ctx}/custMarketingAct/add'">添加</a>
		 <a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/custMarketingAct/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/custMarketingAct/queryList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>活动主题：</label></td>
  				<td>
  					<input class="small text" id="name" name="name" onFocus="" value="${param.name }" >~
  				</td>
				<td><label>创建时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${param.startTime }" >~
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${param.endTime }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 12px;">
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
			<td style="width: 100px;">活动主题</td>
			<td style="width: 100px;">活动时间</td>
			<td style="width: 100px;">创建时间</td>
			<td style="width: 100px;">目标邀约人数</td>
			<td style="width: 100px;">邀约人数</td>
			<td style="width: 100px;">确定人数</td>
			<td style="width: 100px;">活动状态</td>
			<td style="width: 120px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="custMarketingAct">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${custMarketingAct.dbid }">
			</td>
			<td>
				${custMarketingAct.name }
			</td>
			<td>
				${custMarketingAct.actStartDate }~${custMarketingAct.actEndDate }
			</td>
			<td>
				${custMarketingAct.createDate }
			</td>
			<td>
				${custMarketingAct.targetPersonNum }
			</td>
			<td>
				${custMarketingAct.inviteNum }
			</td>
			<td>
				${custMarketingAct.intentionCustNum }
			</td>
			<td>
				<c:if test="${custMarketingAct.actStartDate>now }" var="status">
					<span style="color: orange;">未开始</span>
				</c:if>
				<c:if test="${now>=custMarketingAct.actStartDate&&now<=custMarketingAct.actEndDate}" var="status">
					<span style="color:green;">活动中...</span>
				</c:if>
				<c:if test="${custMarketingAct.actEndDate<now }" var="status">
					<span style="color: red;">已结束</span>
				</c:if>
			</td>
			<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/custMarketingAct/edit?dbid=${custMarketingAct.dbid}'">编辑</a> 
				|
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/custMarketingAct/inviteDetail?dbid=${custMarketingAct.dbid}'">邀约明细</a> 
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
