<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>客户跟踪信息</title>
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
		<%-- <a class="but button" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/customerTrack/delete','searchPageForm')">删除</a> --%>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerTrack/queryLeaderList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>部门：</label></td>
  				<td>
  					<select id="departmentId" name="departmentId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						${departmentSelect }
					</select>
				</td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input class="small text" id="userName" name="userName"  value="${param.userName }">
				</td>
				<td><label>创建日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >~
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
			</tr>
			<tr>
				
  				<td><label>意向级别：</label></td>
  				<td>
  					<select id="customerPhaseId" name="customerPhaseId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
							<c:if test="${customerPhase.dbid<=4 }">
								<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
				<td><label>客户名称：</label></td>
  				<td>
  					<input class="small text" id="name" name="name"  value="${param.name }">
				</td>
				<td><label>电话：</label></td>
  				<td>
  					<input class="small text" id="mobilePhone" name="mobilePhone"  value="${param.mobilePhone }">
  				</td>
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
			<td style="width: 60px;">名称</td>
			<td style="width: 140px;">车系</td>
			<td style="width: 60px;">回访日期</td>
			<td style="width: 60px;">级别(前/后)</td>
			<td style="width: 60px;">任务状态</td>
			<td style="width:80px;">超时状态</td>
			<td style="width:80px;">超时天数</td>
			<td style="width:80px;">创建时间</td>
			<c:if test="${sessionScope.user.queryOtherDataStatus==2 }">
				<td style="width:60px;">所属公司</td>
			</c:if>
			<td style="width:60px;">部门</td>
			<td style="width:50px;">销售顾问</td>
			<td style="width:50px;">审批状态</td>
			<td style="width: 60px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customerTrack">
		<c:set value="${customerTrack.customer }" var="customer"></c:set>
		<tr>
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
						<br>
						${customer.mobilePhone}
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
						<br>
						${customer.mobilePhone}
					</c:if>
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/custCustomer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name} ${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}">
				${customer.customerBussi.brand.name}${carModel}  ${customer.carModelStr}
			</td>
			<td>
				<fmt:formatDate value="${customerTrack.finishDate}" pattern="yyyy-MM-dd hh:mm"/>
			</td>
			<td>
				${customerTrack.beforeCustomerPhase.name}
				/
				${customerTrack.beforeCustomerPhase.name}
			</td>
			<td>
				<c:if test="${customerTrack.taskDealStatus==2 }">
					<span style="color: green">已回访</span>
				</c:if>
				<c:if test="${customerTrack.taskDealStatus==3 }">
					<span style="color: red">任务关闭</span>
					<br>
					<c:if test="${customerTrack.taskFinishType==3 }">
						提报订单关闭任务
					</c:if>	
					<c:if test="${customerTrack.taskFinishType==4 }">
						客户流失关闭任务
					</c:if>	
					
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
				<fmt:formatDate value="${customerTrack.createTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<c:if test="${sessionScope.user.queryOtherDataStatus==2 }">
				<td>
					${customer.enterprise.name }
				</td>
			</c:if>
			<td>
				${customer.department.name }
			</td>
			<td>
				${customer.bussiStaff }
			</td>
			<td>
				<c:if test="${customerTrack.salesReadStatus==1 }">
					<span style="color: red;">
						未审批<br>
					<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.openDialog('${ctx}/customerTrack/leaderApproval?dbid=${customerTrack.dbid}&type=2&typeR=2','审批跟进记录',1200,600)">审批</a>
					</span>
				</c:if> 
				<c:if test="${customerTrack.salesReadStatus==2 }">
					<span style="color: green;">已审批</span>
				</c:if> 
			</td>
			<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerTrack/leaderCustomerTrack?customerId=${customer.dbid}&redirect=3'">跟踪记录</a> 
			</td> 
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
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
</body>
</html>
