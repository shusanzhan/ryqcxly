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
<title>生日会员</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">近5天过生会员</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  	<form name="searchPageForm" id="searchPageForm" action="${ctx}/member/queryMemberBirthday" metdod="post">
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>会员级别：</label></td>
  				<td>
  					<select class="text midea" id="memberShipLevelId" name="memberShipLevelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="memberShipLevel" items="${memberShipLevels }">
							<option value="${memberShipLevel.dbid }" ${param.memberShipLevelId==memberShipLevel.dbid?'selected="selected"':'' } >${memberShipLevel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text midea" value="${param.mobilePhone}"></input></td>
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
			<td class="span2">姓名</td>
			<td class="span2">级别</td>
			<td class="span1">性别</td>
			<td class="span2">生日</td>
			<td class="span2">常用手机号</td>
			<td class="span2">车型</td>
			<td class="span2">车型</td>
			<td class="span2">时间</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="member" items="${members }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${member.dbid }"/></td>
			<td>
					${member.name }
			</td>
			<td>${member.memberShipLevel.name }</td>
			<td>${member.sex }</td>
			<td><fmt:formatDate value="${member.birthday }" pattern="yyyy年MM月dd日"/> </td>
			<td>${member.mobilePhone }</td>
			<td>${member.carSeriy.name }</td>
			<td>${member.carModel.name }</td>
			<td><fmt:formatDate value="${member.createTime }" pattern="yyyy-MM-dd HH:mm"/> </td>
			<td>
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/pointRecord/add?memberId=${member.dbid }','调整积分',900,500)">调整积分</a> |
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/memberTrack/add?memberId=${member.dbid }','添加跟进记录',900,500)">添加跟进记录</a> 
			</td>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
</div>
</body>
</html>