<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>回访统计</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	a:VISITED{
		text-decoration: none;
		border: none;
	}
	.form-inline tr{
		height: 45px;
	}
	#trTd{
		vertical-align: middle;
	}
	#anEnter{
		font-size: 10px;
	}
	#anEnter td{
		padding: 5px 2px;
	}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">回访统计</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="alert alert-info" style="margin-top: 12px;">
	<strong>提示:</strong>默认查询当前月份回访数据 
</div>
<div class="listOperate" >
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
   </div>
   <div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerTrack/queryCustomerTrackCountList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="type" name="type" value='1'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label for="exampleInputName2">销售顾问</label></td>
      	 		<td >
      	 			<input type="text" class="text small" id="userName" name="userName" value="${param.userName }">
			    </td>
  				 <td><label>到期回访时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${beginDate }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${endDate }">
  				</td>
  				<td><div  onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(customerTrackCounts)||customerTrackCounts==null }" var="status">
	<div class="alert alert-info" style="margin-top: 20px;">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
			<tr>
			<td style="width: 40px;">序号</td>
			<td style="width:120px;">销售顾问</td>
			<td style="width:80px;">回访总量</td>
			<td style="width:80px;">已回访量</td>
			<td style="width:80px;">未回访量</td>
			<td style="width:80px;">关闭访量</td>
			<td style="width:80px;">超时总量</td>
			<td style="width: 100px;">超时已回访量</td>
			<td style="width: 100px;">超时未回访量</td>
			<td style="width: 100px;">超时关闭未回访量</td>
			<td style="width: 60px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${customerTrackCounts }" var="customerTrackCount" varStatus="i">
		<tr>
			<td >
				${i.index+1 }
			</td>
			<td>
				${customerTrackCount.companyName }
			</td>
			<td>
				${customerTrackCount.total }
			</td>
			<td>
				${customerTrackCount.trackedNum }
			</td>
			<td>
				${customerTrackCount.notTrackNum }
			</td>
			<td>
				${customerTrackCount.closeTrackNum }
			</td>
			<td>
				<span style="color: red">${customerTrackCount.overTimeTrackNum }</span>
			</td>
			<td>
				<span style="color: red">${customerTrackCount.overTimeTrackedNum }</span>
			</td>
			<td>
				<span style="color: red">${customerTrackCount.overTimeNotTrackNum }</span>
			</td>
			<td>
				<span style="color: red">${customerTrackCount.overTimeCloseNum }</span>
			</td>
			<td>
				<a href="javascript:void(-1)" class="aedit" onclick="companyCustomerTrackDetail('searchPageForm',${customerTrackCount.companyId})">回访明细</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/customerTrack/exportCustomerTrackExcel?'+params;
}
function companyCustomerTrackDetail(searchFrm,companyId){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/customerTrack/salerCustomerTrackDetail?userId='+companyId+'&'+params;
}
</script>
</html>
