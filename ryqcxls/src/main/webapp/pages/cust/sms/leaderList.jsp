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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
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
		<c:if test="${sessionScope.user.userId=='admin' }">
			<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/sms/delete','searchPageForm')">删除</a>
		</c:if>
   </div>
  	<div class="seracrhOperate">
   		<form name="searchPageForm" id="searchPageForm" action="${ctx}/sms/leaderList" method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
				 <table  cellpadding="0" cellspacing="0" class="searchTable" >
					<tr>
						<td><label>操作员：</label></td>
		  				<td>
		  					<select id="userId" name="userId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
								<option value="">请选择...</option>
								<c:forEach var="user" items="${users }">
									<option value="${user.dbid }" ${param.userId==user.dbid?'selected="selected"':'' } >${user.realName }</option>
								</c:forEach>
							</select>
						</td>
						<td>类型：</td>
						<td>
							<select class="text small" id="sendStatus" name="sendStatus" onchange="$('#searchPageForm')[0].submit()">
								<option value="-1">请选择...</option>
								<option value="0" ${param.sendStatus==0?'selected="selected"':'' } >发送失败</option>
								<option value="1" ${param.sendStatus==1?'selected="selected"':'' } >发送成功</option>
							</select>
						</td>
						<td>创建时间：</td>
						<td>
							<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
						</td>
						<td>发送时间：</td>
						<td>
							<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }" >
						</td>
						<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
					</tr>
				 </table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<div class="alert alert-info">
		<strong>获取短信服务状态:</strong> <span>${returnstatus }</span>
		<strong>剩余短信:</strong> <span>${overage }</span>
		<strong>总购买数:</strong> <span>${sendTotal }</span>
		<strong>付费方式:</strong> <span>${payinfo }</span>
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
			<td class="span1">发送人</td>
			<td class="span2">接受客户</td>
			<td class="span2">接受电话</td>
			<td class="span4">发送内容</td>
			<td class="span1">发送状态</td>
			<td class="span1">创建时间</td>
			<td class="span1">操作</td>
		</tr>
	</thead>
	<c:forEach var="sms" items="${page.result }">
			<tr>
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${sms.dbid }">
				</td>
				<td>
					${sms.sendPersonName }
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
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/sms/delete?dbids=${sms.dbid}','searchPageForm')" title="删除">删除</a>
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