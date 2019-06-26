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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>积分报表</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">积分报表</a>
</div>
 <!--location end-->
<div class="line"></div>
<div >
	<div style="float: left;">
		<h3>系统发行总积分：<span style="color: red;text-shadow: red;font-size: 28px;">${countZ }</span></h3> 
	</div>
	<div style="float: left;margin-left: 20px;">
		<h3>系统可用积分：<span style="color: red;text-shadow: red;font-size: 28px;">${countZ+countF }</span></h3> 
	</div>
	<div style="float: left;margin-left: 20px;">
		<h3>系统已经使用积分：
		<span style="color: pink;text-shadow: pinks;font-size: 28px;">
			<c:if test="${empty(countF) }" var="status">0</c:if> 
			<c:if test="${status==false }">${countF}</c:if>	
		</span>
		</h3>
	</div>
	<div style="clear: both;"></div>
</div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/pointRecord/report" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>操作员：</label></td>
  				<td>
  					<input type="text" id="creator" name="creator" class="text midea" value="${param.creator}"></input>
  				</td>
  				<td><label>操作时间开始：</label></td>
  				<td>
  					<input class="midea text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
				</td>
  				<td>结束：</td>
  				<td>
  					<input class="midea text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">会员名称</td>
			<td class="span2">会员ID</td>
			<td class="span2">积分来源</td>
			<td class="span2">创建时间</td>
			<td class="span2">积分</td>
			<td class="span2">操作人</td>
		</tr>
	</thead>
	<c:forEach var="pointRecord" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align: left;">${pointRecord.member.name }</td>
			<td style="text-align: left;">${pointRecord.member.mobilePhone }</td>
			<td style="text-align: left;">${pointRecord.pointFrom }</td>
			<td style="text-align: left;">
			    <fmt:formatDate value="${pointRecord.createTime }"  pattern="yyyy年MM月dd日 HH:mm"/>	
			</td>
			<td >${pointRecord.num} </td>
			<td >${pointRecord.creator} </td>
		</tr>
	</c:forEach>
</table>
<div id="fanye" >
	<%@ include file="../../commons/commonPagination.jsp" %>
	<div style="clear: both;"></div>
</div>

</body>
<script type="text/javascript">
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/pointRecord/exportExcel?'+params;
}
</script>
</html>