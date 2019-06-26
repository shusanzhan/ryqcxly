<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>返利项目管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.history.go(-1)">返利项目类型</a>-
	<a href="javascript:void(-1);" onclick="">返利项目型管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/rebateType/addChildType?rebateTypeId=${rebateTypeId}'">添加</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/rebateType/queryChildrenTypeList"  method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="rebateTypeId" name="rebateTypeId"  value=${rebateTypeId }>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
		<thead class="TableHeader">
			<tr>
				<td class="span4" style="text-align: left;">名称</td>
				<td class="span2">父类型</td>
				<td class="span2">创建时间</td>
				<td class="span2">排序号</td>
				<td class="span2">子公司</td>
				<td class="span2">操作</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.result }" var="childrenRebateType">
			<tr>
				<td style="text-align: left;">${childrenRebateType.name }</td>
				<td>${childrenRebateType.rebateType.name}</td>
				<td><fmt:formatDate value="${childrenRebateType.createTime }" pattern="yyyy-MM-dd HH:MM"/> </td>
				<td>${childrenRebateType.orderNum }</td>
				<td>${childrenRebateType.enterpriseId}</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)"  class="aedit" onclick="window.location.href='${ctx}/rebateType/editChildrenType?rebateTypeId=${rebateTypeId}&childrenRebateTypeId=${childrenRebateType.dbid}'" style="color: #2b7dbc;">编辑</a> | 
					<a href="javascript:void(-1)"  class="aedit" onclick="$.utile.deleteById('${ctx}/rebateType/deleteChildrenType?dbids=${childrenRebateType.dbid}&rebateTypeId=${rebateTypeId}','searchPageForm')" title="删除" style="color: #2b7dbc;">删除</a>|
					<c:if test="${childrenRebateType.useStatus eq 1}">
						<a href="javascript:void(-1)"  class="aedit" onclick="useStatus('${ctx}/rebateType/changeStatus?status=1&dbid=${childrenRebateType.dbid }','searchPageForm')" style="color: green;">停用</a>
					</c:if>
					<c:if test="${childrenRebateType.useStatus eq 2}">
						<a href="javascript:void(-1)"  class="aedit" onclick="useStatus('${ctx}/rebateType/changeStatus?status=2&dbid=${childrenRebateType.dbid }','searchPageForm')" style="color: red;">启用</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
	function useStatus(url,searchFrm){
		var param;
		if(undefined==searchFrm||null==searchFrm||searchFrm.length<=0){
			
		}else{
			param=$("#"+searchFrm).serialize();
		}
		window.top.art.dialog({
			content : '您确定要改变当前状态？',
			icon : 'question',
			width:"250px",
			height:"80px",
			window : 'top',
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.post(url + "&datetime=" + new Date(),param,function callBack(data) {
					if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面
						window.top.art.dialog({
							content : data[0].message,
							icon : 'warning',
							window : 'top',
							width:"250px",
							height:"80px",
							lock : true,
							ok : function() {// 点击去定按钮后执行方法

								$.utile.close();
								return;
							}
						});
					}
					if (data[0].mark == 1) {// 删除数据失败时提示信息
						/* $.cqtaUtile.errMessage(data[0].message); */
						$.utile.tips(data[0].message);
					}
					if (data[0].mark == 0) {// 删除数据成功提示信息
						/* $.cqtaUtile.okDeleteMessage(data[0].message); */
						$.utile.tips(data[0].message);
					}
					// 页面跳转到列表页面
					setTimeout(function() {
						window.location.href = data[0].url
					}, 1000);
				});
			},
			cancel : true
		});
	}
</script>
</body>
</html>
