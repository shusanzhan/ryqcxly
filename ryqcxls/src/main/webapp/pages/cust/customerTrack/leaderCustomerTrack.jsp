<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>单个客户跟踪明细--跟踪明细列表进入</title>
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
	<a href="javascript:void(-1);" onclick="">客户跟踪信息</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<c:if test="${param.redirect==3 }" var="status">
			<a class="but butCancle" href="javascript:void(-1);" onclick="window.history.go(-1)">返回</a>
		</c:if>
		<c:if test="${status==false }">
			<c:if test="${param.redirect==1 }">
				<a class="but button" href="javascript:void();" onclick="$.utile.openDialog('${ctx}/customerTrack/add?customerId=${customer.dbid }&typeRedirect=4&redirect=1','添加跟进记录',900,500)">添加跟踪记录</a>
				<a class="but butCancle" href="javascript:void(-1);" onclick="window.location.href='${ctx}/customerTrack/queryList'">返回</a>
			</c:if>
			<c:if test="${param.redirect==2  }">
				<a class="but button" href="javascript:void();" onclick="$.utile.openDialog('${ctx}/customerTrack/add?customerId=${customer.dbid }&typeRedirect=4&redirect=2','添加跟进记录',900,500)">添加跟踪记录</a>
				<a class="but butCancle" href="javascript:void(-1);" onclick="window.location.href='${ctx}/customerTrack/dayCustomerTrack'">返回</a>
			</c:if>
		</c:if>
   </div>
   <div style="clear: both;"></div>
</div>

 <table border="0" class="tableCustomer" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr>
				<td class="formTableTdLeft">创建日期：</td>
				<td>
					<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td class="formTableTdLeft">意向车型：</td>
				<td>
					<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
					${carModel} ${customer.carModelStr}  
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">客户姓名：</td>
				<td>
					${customer.name }&nbsp;&nbsp;${customer.sex }
				</td>
				<td class="formTableTdLeft">意向级别：</td>
				<td >
					${customer.customerPhase.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">常用手机号：</td>
				<td>
					${customer.mobilePhone }
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
			<td style="width: 80px;">跟进类型</td>
			<td style="width: 60px;">意向级别</td>
			<td style="width: 80px;">常用手机号</td>
			<td style="width:80px;">跟进方法</td>
			<td style="width:80px;">跟进日期</td>
			<td style="width:80px;">下次联系日期</td>
			<td style="width:240px;">跟进内容</td>
			<td style="width:60px;">查阅状态</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${customerTracks }" var="customerTrack">
		<c:set var="customer" value="${customerTrack.customer }"></c:set>
		<tr>
			<td>
				<c:if test="${customerTrack.trackType==1 }">
					日常关系维护
				</c:if>
				<c:if test="${customerTrack.trackType==2 }">
					普通邀约到店
				</c:if>
				<c:if test="${customerTrack.trackType==3 }">
					活动邀约到店
				</c:if>
			</td>
			<td>
				${customerTrack.beforeCustomerPhase.name}
			</td>
			<td>
				${customerTrack.customer.mobilePhone}
			</td>
				<td>
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
			</td>
			<td>
				<fmt:formatDate value="${customerTrack.createTime}" pattern="yyyy-MM-dd HH:mm"/> 
			</td>
			<td>
				<fmt:formatDate value="${customerTrack.nextReservationTime}" pattern="yyyy-MM-dd HH:mm"/> 
			</td>
		
			<td style="text-align: left;">
				<c:if test="${fn:length(customerTrack.trackContent)>30 }" var="status">
					${fn:substring(customerTrack.trackContent,0,30) }...
				</c:if>
				<c:if test="${status==false }">
					${customerTrack.trackContent }
				</c:if>
			</td>
			<td>
				<c:if test="${customerTrack.salesReadStatus==1 }">
					<span style="color: red;">未审批</span>
				</c:if> 
				<c:if test="${customerTrack.salesReadStatus==2 }">
					<span style="color: green;">已审批</span>
				</c:if> 
			</td>
			<td style="text-align: center;">
				<c:if test="${customerTrack.salesReadStatus==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerTrack/leaderApproval?dbid=${customerTrack.dbid}&type=1&typeR=1','审批跟进记录',1200,600)">审批</a>  
				</c:if> 
				<c:if test="${customerTrack.salesReadStatus==2 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerTrack/view?dbid=${customerTrack.dbid}&type=1','查看跟进记录',900,500)">查看</a>  
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
