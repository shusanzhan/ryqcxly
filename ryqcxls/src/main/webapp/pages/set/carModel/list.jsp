<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>车型管理</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车型管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="${ctx }/carModel/add?parentMenu=1">添加</a>
		<c:if test="${fn:contains(sessionScope.user.userId,'super') }">
			<a class="but butCancle" href="javascript:void(-1)" onclick="$.utile.deleteIds('${ctx }/carModel/delete','searchPageForm')">删除</a>
		</c:if>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/carModel/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td><label>品牌：</label></td>
  				<td>
  					<select id="brandId" name="brandId"  class="text midea" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
				</td>
				<td><label>车系：</label></td>
  				<td>
  					<select id="carSeriesId" name="carSeriesId"  class="text midea" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriesId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
				</td>
				<td>车型名称：</td>
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
			<td class="span5">名称</td>
			<td class="span2">品牌</td>
			<td  class="span2">车系</td>
			<td class="span1">年款</td>
			<td class="span1">指导价</td>
			<td class="span1">经销商报价</td>
			<td class="span1">排序</td>
			<td class="span1">启用状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="carModel">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${carModel.dbid }">
				</td>
				<td style="text-align: left;">
				
					${carModel.brand.name }${carModel.carseries.name }${carModel.name }</td>
				<td>
					${carModel.brand.name }
				</td>
				<td>
					${carModel.carseries.name }
				</td>
				<td>${carModel.yearModel }</td>
				<td>${carModel.navPrice }</td>
				<td>${carModel.salePrice }</td>
				<td>${carModel.orderNum }</td>
				<td>
					<c:if test="${carModel.status==1}">
						<span style="color: green;">启用</span>
					</c:if>
					<c:if test="${carModel.status==2}">
						<span style="color: red;">停用</span>
					</c:if>
				</td>
				<td style="text-align: center;">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/carModel/edit?dbid=${carModel.dbid}&parentMenu=1'">编辑</a> | 
					<c:if test="${carModel.status==1}">
						<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/carModel/stopOrStart?dbid=${carModel.dbid}','searchPageForm','您确定【${carModel.name}】停用该车型吗')">停用</a>
					</c:if>
					<c:if test="${carModel.status==2}">
						<a href="javascript:void(-1)"  class="aedit"	onclick="$.utile.operatorDataByDbid('${ctx }/carModel/stopOrStart?dbid=${carModel.dbid}','searchPageForm','您确定【${carModel.name}】启用该车型吗')">启用</a>
					</c:if>
					<c:if test="${fn:contains(sessionScope.user.userId,'super') }">
						|
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/carModel/delete?dbids=${carModel.dbid}','searchPageForm')" title="删除">删除</a>
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
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
