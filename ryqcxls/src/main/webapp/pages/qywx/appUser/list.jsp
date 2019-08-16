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
<title>应用管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/app/queryList'">应用管理</a>-
	<a href="javascript:void(-1);" onclick="">用户管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="bachOpenId()" style="float: left;">批量生成OPenId</a>
		<div id="errorMess1" style="float: left;display: none;" class="alert alert-error">正在同步数据，请稍后再试.....</div>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/appUser/list" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="dbid" name="dbid" value='${app.dbid}'>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">userId</td>
			<td class="span2">姓名</td>
			<td class="span2">openId</td>
			<td class="span2">appId</td>
			<td class="span4">状态</td>
			<td class="span4">操作</td>
		</tr>
	</thead>
	<c:forEach var="appUser" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${appUser.dbid }"/></td>
			<td>
				${appUser.user.userId }
			</td>
			<td>
				${appUser.user.realName }
			</td>
			<td style="text-align: center;">${appUser.openId} </td>
			<td style="text-align: center;">${appUser.redBagAppId} </td>
			<td style="text-align: center;">
				<c:if test="${appUser.status==1 }">
					<span style="color: red">未生成</span>
				</c:if>
				<c:if test="${appUser.status==2 }">
					<span style="color: green">已生成</span>
				</c:if>
			</td>
			<td>
				<c:if test="${appUser.status==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/appUser/saveOpenId?appId=${app.dbid}&appUserId=${appUser.dbid }','searchPageForm','确定生成OPENID？')">生成openId</a>
				</c:if>
				<c:if test="${appUser.status==2 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/appUser/saveOpenId?appId=${app.dbid}&appUserId=${appUser.dbid }','searchPageForm','确定生成OPENID？')">更新openId</a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
var status=1;
function bachOpenId(){
	$("#errorMess1").show();
	$.post('${ctx}/appUser/bachOpenId?appId=${app.dbid}',{},function (data){
		if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
			$.utile.tips(data[0].message+"");
			$("#errorMess1").hide();
			location.reload() 
		}
		if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
			$.utile.tips(data[0].message);
			status=1;
			$("#errorMess1").hide();
		}
	})
}
</script>
</html>