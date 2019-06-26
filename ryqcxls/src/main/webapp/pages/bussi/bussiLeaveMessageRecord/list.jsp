 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>留言管理</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">留言管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/bussiLeaveMessageRecord/edit','添加留言管理',760,460)">添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/bussiLeaveMessageRecord/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/bussiLeaveMessageRecord/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td>匿名：</td>
				<td>
					<select id="anonymousStatus" name="anonymousStatus" class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="-1">请选择...</option>
						<option value="1" ${param.anonymousStatus==1?'selected="selected"':''} >匿名</option>
						<option value="2" ${param.anonymousStatus==2?'selected="selected"':''}>正常</option>
					</select>
				</td>
				<td>姓名：</td>
				<td><input type="text" class="text small"  id="name" name="name" value="${param.name}" ></input></td>
				<td>联系电话：</td>
				<td><input type="text" class="text small"  id="mobilePhone" name="mobilePhone" value="${param.mobilePhone}" ></input></td>
				<td>名片：</td>
				<td><input type="text" class="text small"  id="bussiCardName" name="bussiCardName" value="${param.bussiCardName}" ></input></td>
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
	<thead class="TableHeader" style="height: 40px;">
		<tr class="TableHeader">
			<td class="sn">
					<input type="checkbox" name="title-table-checkbox" id="title-table-checkbox"  onclick="selectAll(this,'id')">
			</td>
			<td class="span1">昵称</td>
			<td class="span2">匿名</td>
			<td class="span2">电话</td>
			<td class="span2">名片</td>
			<td class="span4">处理状态</td>
			<td class="span2">留言时间</td>
			<td class="span2">内容</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="bussiLeaveMessageRecord">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${bussiLeaveMessageRecord.dbid }">
				</td>
				<td >${bussiLeaveMessageRecord.wechatUser }</td>
				<c:if test="${bussiLeaveMessageRecord.anonymousStatus==1}">
					<td >
						<span style="color: red;">匿名</span>
					</td>
					<td >
						-
					</td>
				</c:if> 
				<c:if test="${bussiLeaveMessageRecord.anonymousStatus==2}">
					<td >
						${bussiLeaveMessageRecord.name}
					</td>
					<td >
						${bussiLeaveMessageRecord.mobilePhone}
					</td>
				</c:if> 
				<td>
					${bussiLeaveMessageRecord.bussiCardName }
				</td>
				<td style="text-align: left;">
					<c:if test="${bussiLeaveMessageRecord.dealStatus==1 }">
						<span style="color: red;">待处理</span>
					</c:if>
					<c:if test="${bussiLeaveMessageRecord.dealStatus==2 }">
						${bussiLeaveMessageRecord.dealPerson },
						<fmt:formatDate value="${bussiLeaveMessageRecord.dealTime }" pattern="yyyy-MM-dd HH:mm:ss"/>,
						${bussiLeaveMessageRecord.dealContent }
					</c:if>
				</td>

				<td >
					<fmt:formatDate value="${bussiLeaveMessageRecord.leaveMessageTime }" pattern="yyyy-MM-dd HH:mm:ss"/>,
				</td>
				<td >${bussiLeaveMessageRecord.message }</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit play" onclick="window.location.href='${ctx}/bussiLeaveMessageRecord/detail?dbid=${bussiLeaveMessageRecord.dbid }'">明细</a>
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
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function commonSelect(url,title,width,height,bussiLeaveMessageRecordId){
	var path="";
	art.dialog.open(path+url, {
		title: title,
		width:width,
		height:height,
		fixed: true,
		lock : true,
	    drag: false,
	    resize: false,
		init: function () {
			var iframe = this.iframe.contentWindow;
			var top = art.dialog.top;// 引用顶层页面window对象
		},
		ok: function () {
			var iframe = this.iframe.contentWindow;
			if (!iframe.document.body) {
				alert('iframe还没加载完毕呢')
				return false;
			};
			var members= iframe.document.getElementById('backGroudMusicId').value;
			if(null!=members&&members.length>0){
				$.post('${ctx}/bussiLeaveMessageRecord/saveBackGroundMusic',{backGroudMusicId:members.split("|")[0],bussiLeaveMessageRecordId:bussiLeaveMessageRecordId},function callBack(data) {
					if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
						$.utile.tips(data[0].message);
						// 保存数据成功时页面需跳转到列表页面
						return true;
					}
					if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
						$.utile.tips(data[0].message);
						// 保存失败时页面停留在数据编辑页面
						return false;
					}
				})
				return true;
			}else{
				alert("请选择数据！");
				return false;
			}
		},
		cancel: true
	});
}
</script>
</html>
