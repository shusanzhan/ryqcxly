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
<style type="text/css">
	.copy{
	}
</style>
<title>活动管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">微信活动</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/saleActivity/add'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/saleActivity/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
   		<form name="searchPageForm" id="searchPageForm" action="${ctx}/saleActivity/queryList" method="post">
			     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			     <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
				 <table  cellpadding="0" cellspacing="0" class="searchTable" >
					<tr>
						<td>标题：</td>
						<td><input type="text" class="text midea" id="name" name="name" value="${param.name}" ></input></td>
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
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">分享展示图片</td>
			<td class="span2">标题</td>
			<td class="span2">阅读次数</td>
			<td class="span1">分享次数</td>
			<td class="span1">参加次数</td>
			<td class="span2">创建时间</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="saleActivity" items="${page.result }">
			<tr>
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${saleActivity.dbid }">
				</td>
				<td>
					<img alt="" src="${saleActivity.frontImage }" width="120" height="56" style="margin: 5px;">
				</td>
				<td style="text-align: center;">
					${saleActivity.title }
				</td>
				<td style="text-align: center;">
					${saleActivity.readNum }
				</td>
				<td align="center" style="text-align: center;">
					${saleActivity.shareNum }
				</td>
				<td style="text-align: center;">
					${saleActivity.jionNum }
				</td>
				<td style="text-align: center;">
					<fmt:formatDate value="${saleActivity.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/saleActivity/edit?dbid=${saleActivity.dbid }'" title="编辑">编辑</a> |
					<a href="javascript:void(-1)" class="aedit"  onclick="showUrl('${ctx}/saleActivityWechat/index?code=${saleActivity.code }')" title="编辑">复制链接</a> |
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/saleActivity/delete?dbids=${saleActivity.dbid}','searchPageForm')" title="删除">删除</a>
				</td>
			</tr>
	</c:forEach>
</table>
</c:if>

<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<script type="text/javascript">
	function showUrl(url){
		url=window.location.protocol+"//"+window.location.host+""+url;
		window.top.art.dialog({
			icon : 'info',
			title : '复制链接',
			content : '<textarea rows="" cols="" style="width:400px;">' + url + '</textarea>',
			cancelVal : '关闭',
			lock : true,
			width:"400px",
			height:"80px",
			cancel : true
		// 为true等价于function(){}
		});
	}
</script>