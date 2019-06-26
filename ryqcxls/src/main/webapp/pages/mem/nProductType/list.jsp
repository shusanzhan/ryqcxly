<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品类型管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx }/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx }/css/uniform.css" />
<link rel="stylesheet" href="${ctx }/css/unicorn.main.css" />
<link rel="stylesheet" href="${ctx }/css/unicorn.grey.css"
	class="skin-color" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div id="breadcrumb">
	<a href="${ctx }/main/index" title="微商城中心" class="tip-bottom"><i
		class="icon-home"></i>微商城中心</a> 
		<a href="javascript:void(-1)" class="current">商品类型管理</a>
</div>

<div class="container-fluid">
	<div style="width: 100%;">
		<div style="margin-top: 10px;">
			<p>
				<a class="btn btn-inverse" href="${ctx }/nProductType/add?parentMenu=1">
					<i	class="icon-plus-sign icon-white"></i>添加</a>
			</p>
		</div>
	</div>
	<div class="widget-content">
		<c:if test="${empty(nProductTypes)||nProductTypes==null }" var="status">
			<div class="alert">
				<strong>提示!</strong> 当前未添加数据.
			</div>
		</c:if>
		<c:if test="${status==false }">
		<table class="table table-bordered table-striped with-check">
			<thead>
				<tr>
					<th style="width: 400px;">名称</th>
					<th style="width: 80px;">顺序号</th>
					<th style="width: 80px;">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${nProductTypes }" var="nProductType">
					<tr>
						<td style="text-align: left;">${nProductType.name }</td>
						<td>${nProductType.orderNum }</td>
						<td style="text-align: center;">
						<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/nProductType/edit?dbid=${nProductType.dbid}&parentMenu=1'">编辑</a> | 
						<a href="javascript:void(-1)" onclick="$.utile.deleteById('${ctx}/nProductType/delete?dbid=${nProductType.dbid}','searchPageForm')" title="删除">删除</a></td>
					</tr>
					<ystech:nProdcutType dbid="${nProductType.dbid }"/>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
	</div>
</div>


<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.dataTables.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.tables.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</body>
</html>
