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
<script type="text/javascript">
</script>
<title>相册管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">相册管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="alert alert-error" style="margin-top: 5px;">
	<strong style="font-size: 24px;">${parent.title }</strong>作品管理 
</div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/album/add?parentId=${param.parentId }'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="window.location.href='${ctx}/album/queryList'">返回</a>
   </div>
  	<div class="seracrhOperate">
   		<form name="searchPageForm" id="searchPageForm" action="${ctx}/album/desiList" method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			     <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(albums)||albums==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">相册图片</td>
			<td class="span2">标题</td>
			<td class="span2">照片数</td>
			<td class="span2">是否显示</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="album" items="${albums }">
			<tr>
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${album.dbid }">
				</td>
				<td>
					<img alt="" src="${album.franteUrl }" width="60" height="60" style="margin: 5px;">
				</td>
				<td style="text-align: center;">
					${album.title }
				</td>
				<td style="text-align: center;">
					${fn:length(album.albumimgs) }
				</td>
				<td style="text-align: center;">
					<c:if test="${album.isShow==1 }">
						显示
					</c:if>
					<c:if test="${album.isShow==2}">
						隐藏
					</c:if>
				</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/album/edit?dbid=${album.dbid }&parentId=${param.parentId }'" title="编辑">编辑</a> |
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/album/delete?dbids=${album.dbid}&parentId=${param.parentId }','searchPageForm')" title="删除">删除</a> 
				</td>
			</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
function deleteIds(url,searchFrm) {
	var checkBef = checkBefDel();
	var params=$("#"+searchFrm).serialize();
	try {
		if (checkBef == true) {
			window.top.art.dialog({
				content : '您确定删除选择数据吗？',
				icon : 'question',
				width:"250px",
				height:"80px",
				lock : true,
				ok : function() {// 点击去定按钮后执行方法
					var param = getCheckBox();
					$.post(url + "?dbids=" + param + "&parentId=${param.parentId}&datetime=" + new Date(),params,	callBack);
					function callBack(data) {
						if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面

							window.top.art.dialog({
								content : data[0].message,
								icon : 'warning',
								window : 'top',
								lock : true,
								width:"200px",
								height:"80px",
								ok : function() {// 点击去定按钮后执行方法

									$.utile.close();
									return;
								}
							});

						}

						if (data[0].mark == 1) {// 删除数据失败时提示信息
							$.utile.tips(data[0].message);
						}
						if (data[0].mark == 0) {// 删除数据成功提示信息
							$.utile.tips(data[0].message);
						}
						// 页面跳转到列表页面
						setTimeout(function() {
							window.location.href = data[0].url
						}, 1000);
					}
				},
				cancel : true
			});
		} else {
			return;
		}
	} catch (e) {
		return;
	}
}
</script>
</html>