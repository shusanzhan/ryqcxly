 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>视频管理</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">视频管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/bussiVideo/edit','添加视频管理',540,300)">添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/bussiVideo/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/bussiVideo/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td>歌名：</td>
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
			<td class="span3">
				图片
			</td>
			<td class="span3">标题</td>
			<td class="span2">大小</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="bussiVideo">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${bussiVideo.dbid }">
				</td>
				<td style="text-align: left;">
					<img alt="" src="${bussiVideo.pictrue }" width="80"> 
				</td>
				<td style="text-align: left;">${bussiVideo.title }</td>
				<td>
					<fmt:formatNumber value="${bussiVideo.size/(1024*1024) }" pattern="0.00"/>MB
				</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/bussiVideo/edit?dbid=${bussiVideo.dbid }','编辑',540,300)"" title="编辑">编辑</a>
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/bussiVideo/delete?dbids=${bussiVideo.dbid}','searchPageForm')" title="删除">删除</a>
					|
					<a href="javascript:void(-1)" class="aedit play" onclick="$.utile.openDialog('${ctx}/bussiVideo/play?dbid=${bussiVideo.dbid }','视频播放',540,300)">播放</a>
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
<script>
	function start(dbid){
		$("audio").each(function(i){
			this.currentTime = 0;
		 });
		$(".play").each(function(i){
			if($(this).attr("id")!="a"+dbid){
				$(this).text("播放");
			}
		 });
		var text=$("#a"+dbid).text();
		if(text.indexOf("播放")!=-1){
			$("#a"+dbid).text("停止");
			$('#myaudio'+dbid)[0].play();
		}else {
			$("#a"+dbid).text("播放");
			$('#myaudio'+dbid)[0].pause();
		}
	}
</script>
</html>
