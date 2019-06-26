<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品综合管理</title>
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
		<a href="javascript:void(-1)" class="current">商品综合管理</a>
</div>
<div class="container-fluid">
	<div style="width: 100%;">
		<div style="float: left;margin-top: 10px;">
			<p>
				<a class="btn btn-danger" href="javascript:void(-1)" onclick="window.location.href='${ctx}/consumptionRecord/add'">
					<i class="icon-arrow-left icon-white"></i>返回
				</a>
				<a class="btn btn-warning " href="javascript:void(-1)" onclick="exportExcel('searchPageForm')">
					<i class="icon-th icon-white"></i>导出excel
				</a>
			</p>
		</div>
		<div style="float: right;margin-top: 10px;line-height: 30px;">
			<form name="searchPageForm" id="searchPageForm" class="form-horizontal" action="${ctx}/consumptionRecord/queryList" method="post">
		     <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		     <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		     <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
			 <table  cellpadding="0" cellspacing="0" >
				<tr>
					<td>姓名：</td>
					<td><input type="text" class="input-small"  id="name" name="name" value="${param.name}" ></input></td>
					<td>手机：</td>
					<td><input type="text" class="input-small"  id="mobilePhone" name="mobilePhone" value="${param.mobilePhone}" ></input></td>
					<td>消费时间：</td>
					<td>
						<input type="text" class="input-small"  id="startTime" name="startTime" value="${param.startTime}" onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'});"></input>
						~<input type="text" class="input-small"  id="endTime" name="endTime" value="${param.endTime}" onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')}'});"></input>
					</td>
					
					<td><input type="submit"  class="btn btn-success" value="查询" style="margin-left: 20px;"></input></td>
				</tr>
			 </table>
			</form>
		</div>
		<div  style="clear: both;"></div>
	</div>
	<div class="widget-content">
		<c:if test="${empty(page.result)||page.result==null }" var="status">
			<div class="alert">
				<strong>提示!</strong> 当前未添加数据.
			</div>
		</c:if>
		<c:if test="${status==false }">
		<table class="table table-bordered table-striped with-check">
			<thead>
				<tr>
					<th style="width: 60px;">编号</th>
					<th style="width: 60px;">会员</th>
					<th style="width: 60px;">电话</th>
					<th style="width: 60px;">总金额</th>
					<th style="width: 60px;">优惠金额</th>
					<th style="width: 60px;">实收金额</th>
					<th style="width:50px;">折扣率</th>
					<th style="width: 100px;">消费时间</th>
					<th style="width: 60px;">操作人</th>
					<th style="width: 100px;">创建时间</th>
					<th style="width: 80px;">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.result }" var="consumptionRecord">
				<tr>
					<td>${consumptionRecord.sn }</td>
					<td style="text-align: center;">${consumptionRecord.member.name }</td>
					<td style="text-align: center;">${consumptionRecord.member.mobilePhone }</td>
					<td style="text-align: center;">
						${consumptionRecord.totalPrice }
					</td>
					<td style="text-align: center;">
						${consumptionRecord.discountAmount}
					</td>
					<td style="text-align: center;">
						${consumptionRecord.payInAmount}
					</td>
					<td style="text-align: center;">
						${consumptionRecord.rateDiscount}
					</td>
					<td style="text-align: center;">
						<fmt:formatDate value="${consumptionRecord.createTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td style="text-align: center;">
						${consumptionRecord.user.realName}
					</td>
					<td  style="text-align: center;">
						<fmt:formatDate value="${consumptionRecord.operatorDate }"/>
					</td>
					<td style="text-align: center;">
						 <c:if test="${sessionScope.user.userId=='admin' }">
							<%-- <a href="javascript:void(-1)" onclick="window.location.href='${ctx}/consumptionRecord/edit?dbid=${consumptionRecord.dbid}&parentMenu=1'">编辑</a> | --%> 
							<a href="${ctx }/consumptionRecord/printOrder?dbid=${consumptionRecord.dbid}" onclick="">打印</a>|
							<a href="javascript:void(-1)" onclick="$.utile.deleteById('${ctx}/consumptionRecord/delete?dbids=${consumptionRecord.dbid}','searchPageForm')" title="删除">删除</a>|
						</c:if> 
						<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/consumptionRecord/view?dbid=${consumptionRecord.dbid}'">查看</a> 
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
		<div id="fanye">
			<%@ include file="../../commons/commonPagination.jsp" %>
		</div>
	</div>
</div>
	<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
	<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
	<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
	<script src="${ctx }/widgets/bootstrap3/jquery.dataTables.min.js"></script>
	<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
	<script src="${ctx }/widgets/bootstrap3/unicorn.tables.js"></script>
	<script src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
	<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
	<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
	<script type="text/javascript">
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/consumptionRecord/exportExcel?'+params;
}
</script>
</body>
</html>
