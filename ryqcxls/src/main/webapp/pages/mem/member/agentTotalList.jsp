<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>经纪人引流统计</title>
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
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>->
	<a href="javascript:void(-1);" >经纪人引流统计</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate" >
	<div class="operate">
   </div>
   <div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx }/member/queryAgentTotalList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="type" name="type" value='1'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				 <td><label>注册日期开始：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${beginDate }" >
				</td>
  				<td><label>注册日期时间：</label></td>
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
<div class="frmTitle" onclick="showOrHiden('contactTable')">经纪人引流统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
		<tr>
			<td style="width: 30px;" rowspan="">序号</td>
			<td style="width:60px;" rowspan="1">姓名</td>
			<td style="width:60px;" rowspan="1">数量</td>
			<td style="width:60px;" rowspan="1">认证数量</td>
		</tr>
	<tbody>
		<c:set value="0" var="total"></c:set>
		<c:set value="0" var="carMasterNum"></c:set>
		<c:forEach items="${members }" var="member" varStatus="i">
		<tr>
			<td >
					${i.index+1 }
				</td>
				<td>
					${member.name}
				</td>
				<td>
					${member.totalNum}
					<c:set value="${total+member.totalNum }" var="total"></c:set>
				</td>
				<td>
					${member.carMasterNum}
					<c:set value="${carMasterNum+member.carMasterNum }" var="carMasterNum"></c:set>
				</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="2">合计</td>
			<td>
				${total }
			</td>
			<td>
				${carMasterNum }
			</td>
		</tr>
	</tbody>
</table>
<br>
<br>
<br>
</body>
</html>
