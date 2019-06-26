 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>个人名片</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">个人名片</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/bussiCard/edit','添加个人名片',760,460)">添加</a>
		<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/bussiCard/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/bussiCard/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td>姓名：</td>
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
			<td class="span1">类型</td>
			<td  class="span2">姓名</td>
			<td class="span2">联系电话</td>
			<td class="span2">PV量</td>
			<td class="span2">分享量</td>
			<td class="span2">PU量</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="bussiCard">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${bussiCard.dbid }">
				</td>
				<td style="text-align: center;">
					<c:if test="${bussiCard.type==1 }">
						销售
					</c:if>
					<c:if test="${bussiCard.type==2 }">
						售后
					</c:if>
				</td>
				<td style="text-align: left;">
					<a href="javascript:void(-1)" onclick="window.location.href='${ctx }/bussiCard/bussiCardDetail?bussiCardId=${bussiCard.dbid}'" title="${bussiCard.name }" class="aedit">${bussiCard.name }</a>
				</td>
				<td >${bussiCard.mobilePhone }</td>
				<td >${bussiCard.readNum }</td>
				<td >${bussiCard.shareNum }</td>
				<td >${bussiCard.personNum }</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/bussiCard/edit?dbid=${bussiCard.dbid }','编辑个人名片',760,460)" title="删除">编辑</a>
					|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/bussiCard/delete?dbids=${bussiCard.dbid}','searchPageForm')" title="删除">删除</a>
					|
					<a href="javascript:void(-1)" class="aedit play" onclick="commonSelect('${ctx}/bussiCard/backGroundMusic?bussiCardId=${bussiCard.dbid }','设置背景音乐',760,380,${bussiCard.dbid })">背景音乐</a>
					|
					<a href="javascript:void(-1)" class="aedit play" onclick="">分享</a>
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
function commonSelect(url,title,width,height,bussiCardId){
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
				$.post('${ctx}/bussiCard/saveBackGroundMusic',{backGroudMusicId:members.split("|")[0],bussiCardId:bussiCardId},function callBack(data) {
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
