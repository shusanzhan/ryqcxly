<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品综合管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">商品综合管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx }/product/add?parentMenu=1'">添加</a>
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx }/product/warmStockNum'">库存预警报表</a>
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx }/product/queryStopList'">停用商品</a>
		<%-- <a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/product/delete','searchPageForm')">删除</a> --%>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/product/queryList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="text midea" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>商品分类：</label></td>
  				<td>
  					<select class="midea text" id="categoryId" name="categoryId" onchange="$('#searchPageForm')[0].submit()" >
					<option value="">请选择...</option>
						${productCateGorySelect }
					</select>
				</td>
  				<td><label>名称：</label></td>
  				<td><input type="text" id="name" name="name" class="text midea" value="${param.name}"></input></td>
  				<td><label>编号：</label></td>
  				<td><input type="text" id="sn" name="sn" class="text midea" value="${param.sn}"></input></td>
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
	<thead>
		<tr>
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 60px;">编号</td>
			<td style="width: 220px;">名称</td>
			<td style="width: 60px;">商品分类</td>
			<td style="width: 60px;">适用类型</td>
			<td style="width: 60px;">销售指导价</td>
			<td style="width:60px;">顾问结算价</td>
			<td style="width:60px;">含税成本价</td>
			<td style="width:60px;">施工成本</td>
			 <td style="width: 50px;">库存</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="product">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${product.dbid }">
			</td>
			<td>${product.sn }</td>
			<td>
					<c:if test="${fn:length(product.name)>12 }" var="status">
						${fn:substring(product.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${product.name }
					</c:if>
			</td>
			<td>
				${product.productcategory.name}
			</td>
			<td>
				<c:if test="${product.commType==1 }">
					通用
				</c:if>
				<c:if test="${product.commType==2 }">
					专用
				</c:if>
			</td>
			<td>
				${product.price}
			</td>
			<td>
				<fmt:formatNumber value="${product.salerCostPrice }"></fmt:formatNumber> 
			</td>
			<td>
				${product.costPrice}
			</td>
			<td>
				${product.constructCostPrice}
			</td>
			<td>
				${product.stockNum}
			</td>
			<td>
				<fmt:formatDate value="${product.createTime }"/>
			</td>
			<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/product/edit?dbid=${product.dbid}&parentMenu=1&currentPage=${page.currentPageNo}&pageSize=${page.pageSize}'">编辑</a> | 
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/product/stopOrStart?dbid=${product.dbid}','searchPageForm','您确定【${product.name}】停用该商品吗')">停用</a> | 
				<%-- <a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/product/delete?dbids=${product.dbid}','searchPageForm')" title="删除">删除</a> --%>
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
</html>
