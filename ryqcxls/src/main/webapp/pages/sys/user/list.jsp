<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<title>用户管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/user/queryList'">用户管理中心</a>
</div>
 <!--location end-->
<div class="line"></div>

<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/user/add'">添加</a>
		<a class="but butCancle" href="javascript:void(-1);" onclick="$.utile.deleteIds('${ctx }/user/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		 <form name="searchPageForm" id="searchPageForm" action="${ctx}/user/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
  		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
				<td>
					部门:&nbsp;
					<select id="departmentId" name="departmentId" class="small text" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						${departmentSelect }
					</select>
				</td>
				<td>
					用户类型:
					<select id="userType" name="userType" class="small text" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<option value="1" ${param.userType==1?'selected="selected"':'' } >一网用户</option>
						<option value="2" ${param.userType==2?'selected="selected"':'' } >二网用户</option>
					</select>
				</td>
				<td>
					启用状态&nbsp;
					<select id="userState" name="userState" class="small text" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<option value="1" ${param.userState==1?'selected="selected"':'' } >启用</option>
						<option value="2" ${param.userState==2?'selected="selected"':'' } >停用</option>
					</select>
				</td>
  				<td><label>名称：</label></td>
  				<td><input type="text" id="userName" name="userName" class="text small" value="${param.userName}"></input></td>
  				<td><label>用户ID：</label></td>
  				<td><input type="text" id="userId" name="userId" class="text small" value="${param.userId}"></input></td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 无用户信息！请点击“添加”按钮进行添加数据操作
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
<thead class="TableHeader">
	<tr>
		<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
		<td class="span2">用户Id</td>
		<td class="span2">名字</td>
		<td class="span2">部门</td>
		<td class="span2">岗位</td>
		<td class="span2">角色</td>
		<td class="span2">业务类型</td>
		<td class="span2">手机</td>
		<td class="span2">邮箱</td>
		<td class="span2">微信Id</td>
		<td class="span2">用户状态</td>
		<td class="span3" >操作</td>
	</tr>
</thead>
<c:forEach var="user" items="${page.result }">
	<tr height="32" align="center">
		<td><input type='checkbox' name="id" id="id1" value="${user.dbid }"/></td>
		<td>${user.userId }</td>
		<td align="left" style="text-align: left;">${user.realName }&nbsp;&nbsp; 
			<c:if test="${!empty(user.staff.sex) }">
				(${user.staff.sex })	
			</c:if>
		</td>
		<td align="left" style="text-align: left;">${user.department.name }</td>
		<td align="left" style="text-align: left;">${user.positionNames }</td>
		<td>
			<c:forEach var="role" items="${user.roles }">
				${role.name },
			</c:forEach>
		</td>
		<td>
			<c:if test="${user.bussiType==1 }">
				展厅
			</c:if>
			<c:if test="${user.bussiType==2 }">
				网销
			</c:if>
			<c:if test="${user.bussiType==3 }">
				区域
			</c:if>
			<c:if test="${user.bussiType==4 }">
				后勤
			</c:if>
			<c:if test="${user.bussiType==5 }">
				其他
			</c:if>
		</td>
		<td align="left">${user.mobilePhone }</td>
		<td align="left">${user.email }</td>
		<td align="left">${user.wechatId }</td>
		<td align="left">
			<c:if test="${user.userState==1}">
				<span style="color:blue;">启用</span>
			</c:if>
			<c:if test="${user.userState==2}">
				<span style="color: red;">停用</span>
			</c:if>
		</td>
		<td><a href="javascript:void(-1)" class="aedit"	onclick="window.location.href='${ctx }/user/edit?dbid=${user.dbid}'">编辑</a>
			<%-- <a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.deleteById('${ctx }/stopOrStartUser?dbid=${user.dbid}','searchPageForm')">删除</a> --%>
			<c:if test="${user.userState==1}">
				<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/user/stopOrStartUser?dbid=${user.dbid}','searchPageForm','您确定【${user.realName}】停用该用户吗')">停用</a>
			</c:if>
			<c:if test="${user.userState==2}">
				<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/user/stopOrStartUser?dbid=${user.dbid}','searchPageForm','您确定【${user.realName}】启用该用户吗')">启用</a>
			</c:if>
			<a href="javascript:void(-1)" class="aedit"	onclick="window.location.href='${ctx }/user/userRole?dbid=${user.dbid}'">授权</a>
			<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/user/resetPassword?dbid=${user.dbid}&type=1','searchPageForm','您确定【${user.realName}】重置密码')">重置密码</a>
	</tr>
</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
</html>