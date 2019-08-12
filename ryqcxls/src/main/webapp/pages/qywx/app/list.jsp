<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>应用管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">应用管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="#" class="aedit" onclick="window.location.href='${ctx }/app/edit'">添加应用</a>
		<a class="but button" href="javascript:void();" onclick="synApp()" style="float: left;">同步应用</a>
		<a class="but button" href="javascript:void();" onclick="synUser()" style="float: left;">同步用户</a>
		<div id="errorMess1" style="float: left;display: none;" class="alert alert-error">正在同步数据，请稍后再试.....</div>
		<div id="errorMess2" style="float: left;display: none;" class="alert alert-error">请勿重复提交数据，正在同步数据，请稍后再试.....</div>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/app/queryList" metdod="get">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">头像</td>
			<td class="span2">名称</td>
			<td class="span2">token</td>
			<td class="span4">安全码</td>
			<td class="span1">微信应用Id</td>
			<td class="span4">操作</td>
		</tr>
	</thead>
	<c:forEach var="app" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${app.dbid }"/></td>
			<td style="text-align: left;">
				<img alt="" src="${app.round_logo_url }" width="60">
			</td>
			<td style="text-align: left;">${app.name }</td>
			<td style="text-align: center;">${app.token} </td>
			<td style="text-align: left;">${app.encodingAeskey} </td>
			<td style="text-align: center;">${app.appId} </td>
			<td>
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/app/edit?dbid=${app.dbid}'">编辑</a>
				|
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/appUser/list?dbid=${app.dbid}'">用户</a>
				|
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/appMenu/queryList?appDbid=${app.dbid}'">设置菜单</a>
				|
				<a href="#" class="aedit" onclick="$.utile.deleteById('${ctx }/app/delete?dbids=${app.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
var status=1;
function synApp(){
	if(status==2){
		$("#errorMess2").show();
		$("#errorMess1").hide();
		return ;
	}
	status=2;
	$("#errorMess1").show();
	$.post('${ctx}/app/synApp',{},function (data){
		if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
			$.utile.tips(data[0].message+"");
			status=1;
			$("#errorMess2").hide();
			$("#errorMess1").hide();
			location.reload() 
		}
		if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
			$.utile.tips(data[0].message);
			status=1;
			$("#errorMess2").hide();
			$("#errorMess1").hide();
		}
	})
}
function synUser(){
	if(status==2){
		$("#errorMess2").show();
		$("#errorMess1").hide();
		return ;
	}
	status=2;
	$("#errorMess1").show();
	$.post('${ctx}/app/synUser',{},function (data){
		if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
			$.utile.tips(data[0].message+"");
			status=1;
			$("#errorMess2").hide();
			$("#errorMess1").hide();
			location.reload() 
		}
		if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
			$.utile.tips(data[0].message);
			status=1;
			$("#errorMess2").hide();
			$("#errorMess1").hide();
		}
	})
}
</script>
</html>