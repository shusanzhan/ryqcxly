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
<title>奖励记录</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">奖励记录</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/rewardSet/edit'">返利设置</a> --%>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/reward/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
				<td><label>红包发送状态：</label></td>
  				<td>
  					<select id="turnBackStatus" name="turnBackStatus" class="text small" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择</option>
  						<option value="1" ${param.turnBackStatus==1?'selected="selected"':'' } >待发红包</option>
  						<option value="2" ${param.turnBackStatus==2?'selected="selected"':'' }>发送失败</option>
  						<option value="3" ${param.turnBackStatus==3?'selected="selected"':'' }>已发红包</option>
  					</select>
  				</td>
				<td><label>昵称：</label></td>
  				<td><input type="text" id="nickName" name="nickName" class="text small" value="${param.nickName}"></input></td>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
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
			<td class="span2">会员名称</td>
			<td class="span2">昵称</td>
			<td class="span2">返利来源</td>
			<td class="span2">创建时间</td>
			<td class="span1">返利金额</td>
			<td class="span1">操作人</td>
			<td class="span4">备注</td>
			<td class="span1">结算状态</td>
			<td class="span1">操作</td>
		</tr>
	</thead>
	<c:forEach var="reward" items="${page.result }">
		<c:set value="${reward.member }" var="member"></c:set>
		<c:set value="${member.weixinGzuserinfo }" var="weixinGzuserinfo"></c:set>
		<tr height="32" align="center">
			<td>
				<img alt="" src="${weixinGzuserinfo.headimgurl }" height="50" width="50" style="float: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)" style="float: left;">
					${member.name }（${member.sex }）
					<br>
					${member.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li><a href="javascript:void(-1)" onclick="window.location.href='${ctx}/member/information?dbid=${member.dbid}&type=1'" >会员明细</a></li>
					    </ul>
					  </div>
				</div>
			</td>
			<td >${weixinGzuserinfo.nickname }</td>
			<td >${reward.rewardFrom }</td>
			<td >
			    <fmt:formatDate value="${reward.createTime }"  pattern="yyyy年MM月dd日 HH:mm"/>	
			</td>
			<td >
				<span style="color: red">${reward.rewardMoney}</span>
			</td>
			<td >${reward.creator} </td>
			<td style="text-align: left;">${reward.note} </td>
			<td style="">
				<c:if test="${reward.turnBackStatus==1 }">
					<span style="color: red">待发红包</span>
				</c:if>
				<c:if test="${reward.turnBackStatus==2 }">
					<span style="color: red">发送失败</span>
				</c:if>
				<c:if test="${reward.turnBackStatus==3 }">
					<span style="color: green">已发红包</span>
				</c:if>
				
			</td>
			<td style="">
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/reward/viewWechat?dbid=${reward.dbid}&type=1'" >红包明细</a>
			</td>
		</tr>
	</c:forEach>
</table>
<div id="fanye" >
	<%@ include file="../../commons/commonPagination.jsp" %>
	<div style="clear: both;"></div>
</div>
</body>
</html>