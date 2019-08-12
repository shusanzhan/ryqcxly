<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>客户管理</title>
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
	<a href="javascript:void(-1);" onclick="">流失客户管理</a>
</div>
 <!--location end-->
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<%-- <div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.open('${ctx }/custCustomer/satisfactionAssessment')">意向跟踪卡</a>
   </div> --%>
   <div class="operate">
		<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/custCustomer/queryRoomManageOutFlow" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="text small" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="text small" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text small" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input type="text" id="userName" name="userName" class="text small" value="${param.userName}"></input>
				</td>
  				<td><label>结案情形：</label></td>
  				<td>
  					<select id="customerFlowReasonId" name="customerFlowReasonId" class="small text" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<c:forEach var="customerFlowReason" items="${customerFlowReasons }">
							<option value="${customerFlowReason.dbid }" ${customerFlowReason.dbid ==param.customerFlowReasonId?'selected="selected"':'' }>${customerFlowReason.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
				<td><label>创建日期开始：</label></td>
  				<td>
  					<input class="small text" id="startFolderTime" name="startFolderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startFolderTime }" >
				</td>
  				<td><label>结束：</label></td>
  				<td>
  					<input class="small text" id="endFolderTime" name="endFolderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endFolderTime }">
  				</td>
		</tr>
		<tr>
				<td><label>审批状态：</label></td>
  				<td>
  					<select id="approvalStatus" name="approvalStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
						<option value="-1">请选择...</option>
						<option value="0" ${param.approvalStatus==0?'selected="selected"':'' }>待审批</option>
						<option value="1" ${param.approvalStatus==1?'selected="selected"':'' }>已审批</option>
					</select>
				</td>
				<td><label>流失日期开始：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
				</td>
  				<td><label>结束：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
  				<td><label>审批日期开始：</label></td>
  				<td>
  					<input class="small text" id="startApprovalTime" name="startApprovalTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startApprovalTime }" >
				</td>
  				<td><label>结束：</label></td>
  				<td>
  					<input class="small text" id="endApprovalTime" name="endApprovalTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endApprovalTime }">
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
			<td style="width: 60px;">姓名</td>
			<td style="width:160px;">车型</td>
			<td style="width: 60px;">意向级别</td>
			<td style="width: 80px;">部门</td>
			<td style="width: 80px;">交叉客户</td>
			<td style="width: 100px;">结案情形</td>
			<td style="width: 160px;">流失备注</td>
			<td style="width: 100px;">流失发起时间</td>
			<td style="width: 80px;">审批人</td>
			<td style="width: 100px;">流失通过时间</td>
			<td style="width: 100px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<td style="text-align: left">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/custCustomer/customerFile?dbid=${customer.dbid}&type=1'" title="点击查看客户档案明细">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
					</c:if>
					${customer.mobilePhone}
					<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd "/>
				</a>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td style="text-align: left" title="${carModel}  ${customer.carModelStr}">
				${customer.customerBussi.brand.name}
					${carModel}  ${customer.carModelStr}
			</td>
			<td>
				${customer.customerPhase.name}
			</td>
			<td style="text-align: left">
				${customer.department.name }
				<br>		
				${customer.bussiStaff}
			</td>
			<td>
				
			</td>
			<td>
				${customer.customerLastBussi.customerFlowReason.name }
			</td>
			<td style="text-align: left;">
				${customer.customerLastBussi.note }
			</td>
			<td>
				<fmt:formatDate value="${customer.customerLastBussi.createTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				${customer.customerLastBussi.approvalPersonName }
			</td>
			<td>
				<fmt:formatDate value="${customer.customerLastBussi.approvalDate }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td style="text-align: center;">
				<c:if test="${customer.lastResult>1 }">
					<c:if test="${customer.customerLastBussi.approvalStatus==0 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerLastBussi/approval?customerId=${customer.dbid }&type=1','销售经理审批流失客户',640,400)">审批</a> 
					</c:if>
					<c:if test="${customer.customerLastBussi.approvalStatus==1 }">
						<span style="color: red;">客户流失</span>
					</c:if>
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
	 function exportExcel(searchFrm){
			var params;
			if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
				params=$("#"+searchFrm).serialize();
			}
			window.location.href='${ctx}/custCustomer/exportOutFlowExcel?'+params;
		}
</script>
</html>
