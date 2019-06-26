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
<title>车辆性质</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车辆性质</a>
</div>
 <!--location end-->
<div class="line"></div>
<br>
<div id="detail_nav">
	<div class="detail_nav_inner">
	      <ul class="clearfix padding10">
	        <li onclick="window.location.href='/qywxSaleReport/todayStatic'" id="imgs_tap" class="detail_tap5 detail_tap pull_left select">日</li>
	        <li onclick="window.location.href='/qywxSaleReport/customer7Day'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">最近7日</li>
	        <li onclick="window.location.href='/qywxSaleReport/customerWeek'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">周</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/departmentReportDetail?brandId=${brand.dbid}'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">月</li>
	        <li onclick="window.location.href='/qywxSaleReport/customerYear'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">年</li>
	   	</ul>
	  </div>
 </div>
<div class="listOperate">
	 <div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/visitRecordReport/monthReport'">回访月报</a>
   </div> 
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/visitRecordReport/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>预约类型：</label></td>
  				<td>
				</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
			</tr>
			</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">自有店</div>
<%-- <c:forEach var="department" items="${departments }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
		<tr>
			<td colspan="10">${department.name }</td>
		</tr>
		<tr>	
			<td style="border: 0;">
				<table style="width: 100%;" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td style="border-right: 1px solid #ccc"></td>
					</tr>
					<tr>
						<td style="border-right: 1px solid #ccc">回答“是”</td>
					</tr>
					<tr>
						<td style="border-right: 1px solid #ccc">回答“否”</td>
					</tr>
					<tr>
						<td style="border-right: 1px solid #ccc">得分</td>
					</tr>
				</table>
			</td>
			<c:forEach begin="0" end="8">
				<td style="border: 0;">
				<table style="width: 100%;" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td style="border-right: 1px solid #ccc">sss</td>
					</tr>
					<tr>
						<td style="border-right: 1px solid #ccc">回答“是”</td>
					</tr>
					<tr>
						<td style="border-right: 1px solid #ccc">回答“否”</td>
					</tr>
					<tr>
						<td>得分</td>
					</tr>
				</table>
			</td>
			</c:forEach>
		</tr>
		<tr class="" >
			<td class="span6" colspan="10"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" />测试部门</td>
		</tr>
</table>
</c:forEach> --%>
${ departmentTable}
<div class="frmTitle" onclick="showOrHiden('contactTable')">二网</div>
${ distributorTypeTable}
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>