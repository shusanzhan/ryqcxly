<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>【${user.realName }】回访记录明细</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.tableCustomer{
		width: 100%;
		color: #5B5555;
	}
	.tableCustomer tr{
		height: 30px;
	}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">【${user.realName }】回访记录明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void(-1);" onclick="window.history.go(-1)">返回</a>
   </div>
   <div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerTrack/salerCustomerTrackDetail" method="post" >
  		<input type="hidden" id="userId" name="userId"  value="${user.dbid }" >
  		<input type="hidden"  id="startTime" name="startTime"  value="${startTime }">
  		<input type="hidden"  id="endTime" name="endTime"  value="${endTime }">
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>回访状态：</label></td>
  				<td>
  					<select class="small text" id="taskDealStatus" name="taskDealStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.taskDealStatus==1?'selected="selected"':'' } >未回访</option>
						<option value="2" ${param.taskDealStatus==2?'selected="selected"':'' } >已回访</option>
					</select>
				</td>
  				<td><label>超时状态：</label></td>
  				<td>
  					<select class="small text" id="taskOverTimeStatus" name="taskOverTimeStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.taskOverTimeStatus==1?'selected="selected"':'' } >未超时</option>
						<option value="2" ${param.taskOverTimeStatus==2?'selected="selected"':'' } >已超时</option>
					</select>
				</td>
  				<td><div  onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   <div style="clear: both;"></div>
</div>

 <table border="0" class="tableCustomer" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-bottom: 12px;">
		<tr>
			<td style="text-align: center;font-size: 18px;color: #000" colspan="4">
				${user.realName }回访记录明细
			</td>
		</tr>
		<tr>
			<td style="text-align: center;font-size: 14px;" colspan="4">
				到期回访时间：${param.startTime }至${param.endTime }
			</td>
		</tr>
	</table>
<c:if test="${empty(customerTracks)}" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="margin-bottom: 80px;">
	<thead>
		<tr>
			<td style="width: 40px;">序号</td>
			<td style="width: 60px;">名称</td>
			<td style="width: 140px;">车系</td>
			<td style="width: 60px;">回访状态</td>
			<td style="width: 60px;">超时状态</td>
			<td style="width:60px;">超时天数</td>
			<td style="width:80px;">到期回访日</td>
			<td style="width:80px;">创建日期</td>
			<td style="width:240px;">回访信息</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${customerTracks }" var="customerTrack" varStatus="i">
		<c:set var="customer" value="${customerTrack.customer }"></c:set>
		<c:set var="customerBussi" value="${customerTrack.customer.customerBussi }"></c:set>
		<tr>
			<td>
				${i.index+1 }
			</td>
			<td style="text-align: left;">
				${customer.name }
				<br>
				${customer.mobilePhone}
			</td>
			<c:set value="${customerBussi.carSeriy.name} ${ customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}">
				${customerBussi.brand.name}${carModel}  ${customer.carModelStr}
			</td>
			<td>
				<c:if test="${customerTrack.taskDealStatus==1 }">
					未回访
				</c:if>
				<c:if test="${customerTrack.taskDealStatus==2 }">
					<span style="color: green">已回访</span>
				</c:if>
				<c:if test="${customerTrack.taskDealStatus==3 }">
					<span style="color: green">任务关闭</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customerTrack.taskOverTimeStatus==1 }">
					<span style="color: green">未超时</span>
				</c:if>
				<c:if test="${customerTrack.taskOverTimeStatus==2 }">
					<span style="color: red">已超时</span>
				</c:if>
			</td>
			<td>
				${customerTrack.taskOverTimeNum }
			</td>
			<td>
				<fmt:formatDate value="${customerTrack.nextReservationTime}" pattern="yyyy-MM-dd HH:mm"/> 
			</td>
			<td>
				<fmt:formatDate value="${customerTrack.createTime}" pattern="yyyy-MM-dd HH:mm"/> 
			</td>
			<td style="text-align: left;">
				回访级别(前/后)：
				${customerTrack.beforeCustomerPhase.name}
					/
				${customerTrack.afterCustomerPhase.name}
				<br>
				回访方法：
				<c:if test="${customerTrack.trackMethod==1 }">
					电话
				</c:if>
				<c:if test="${customerTrack.trackMethod==2 }">
					到店
				</c:if>
				<c:if test="${customerTrack.trackMethod==3 }">
					短信
				</c:if>
				<c:if test="${customerTrack.trackMethod==4 }">
					回访
				</c:if>
				<br>
				回访内容：
				${customerTrack.result }
				<br>
				回访日期：
				<fmt:formatDate value="${customerTrack.finishDate }" pattern="yyyy-MM-dd HH:mm"/>
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
<script type="text/javascript">
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
</script>
</html>
