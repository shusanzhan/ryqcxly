<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>经销商管理管理</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">经销商管理管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="window.location.href='${ctx }/distributor/chocie?parentMenu=1'">添加</a>
		<a class="but button" href="javascript:void(-1)" onclick="changeUser('${ctx}/distributor/changeUser')">转区域专员</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/distributor/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/distributor/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td>合作类型：</td>
				<td>
					<select id="type" class="text midea" name="type" onchange="$('#searchPageForm')[0].submit()">
						<option value="-1">请选择...</option>
						<option value="1" ${param.type==1?'selected="selected"':'' } >合作经销商</option>
						<option value="2" ${param.type==2?'selected="selected"':'' }>非合作经销商</option>
					</select>
				
				</td>
				<td>类型：</td>
				<td>
					<select id="distributorTypeId" class="text midea" name="distributorTypeId" onchange="$('#searchPageForm')[0].submit()">
						<option value="-1">请选择...</option>
						<c:forEach var="distributorType" items="${distributorTypes}">
							<option value="${distributorType.dbid }" ${param.distributorTypeId==distributorType.dbid?'selected="selected"':'' } >${distributorType.name }</option>
						</c:forEach>
					</select>
				</td>
				<td>经销商名称：</td>
				<td><input type="text" class="text midea"  id="name" name="name" value="${param.name}" ></input></td>
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
	<thead class="TableHeader">
		<tr>
			<td class="sn">
					<input type="checkbox" name="title-table-checkbox" id="title-table-checkbox"  onclick="selectAll(this,'id')">
			</td>
			<td class="span3">名称</td>
			<td  class="span1">简称</td>
			<td  class="span2">合作类型</td>
			<td  class="span2">类型</td>
			<td  class="span3">区域</td>
			<td class="span2">联系电话</td>
			<td class="span2">合作起始日期</td>
			<td class="span2">创建日期</td>
			<td class="span1">区域专员</td>
			<td class="span3">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="distributor">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${distributor.dbid }">
				</td>
				<td style="text-align: left;">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/distributor/view?dbid=${distributor.dbid}&parentMenu=1'">
						${distributor.name }
					</a>	
				</td>
				<td >${distributor.shortName }</td>
				<td >
					<c:if test="${distributor.type==1 }">
						<span style="color: green;">合作经销商</span>
					</c:if>
					<c:if test="${distributor.type==2 }">
						<span style="color: red;">非合作经销商</span>
					</c:if>
				</td>
				<td >${distributor.distributorType.name }</td>
				<td >${distributor.legalArea.fullName }</td>
				<td>${distributor.mobilePhone }</td>
				<td>
					<fmt:formatDate value="${distributor.startCooperation}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${distributor.createTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${distributor.user.realName }
				</td>
				<td style="text-align: center;">
					<c:if test="${distributor.type==1 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/distributor/turnOn?dbid=${distributor.dbid}','searchPageForm','确定设置为非合作经销商吗？')" title="设置为非合作商">设置非合作</a>
					</c:if>
					<c:if test="${distributor.type==2 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/distributor/edit?dbid=${distributor.dbid}&parentMenu=1'">设置合作</a> | 
					</c:if>
					|
					<c:if test="${distributor.type==1 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/distributor/edit?dbid=${distributor.dbid}&parentMenu=1'">编辑</a> | 
					</c:if>
					<c:if test="${distributor.type==2 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/distributor/editEn?dbid=${distributor.dbid}&parentMenu=1'">编辑</a> | 
					</c:if>
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/distributor/delete?dbids=${distributor.dbid}','searchPageForm')" title="删除">删除</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function checkOperateSingal() {
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if (length <= 0) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '请选择操作数据！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
			// 为true等价于function(){}
		});
		return false;
	} else if(length >= 2) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '只能选择一条数据，进行操作！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
			// 为true等价于function(){}
		});
		return false;
	}else{
		return true;
	}
}
function changeUser(url){
	var status=checkOperateSingal();
	if(status==true){
		var param = getCheckBox();
		$.utile.openDialog(url+"?distributorId="+param,'转区域专员',960,420)
	}
}
</script>
</html>
