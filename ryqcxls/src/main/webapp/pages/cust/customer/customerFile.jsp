<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="Keywords" content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<!-- 最新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="${ctx }/css/bootstrap/bootstrap.min.css">
<link  type="text/css" href="${ctx }/css/common.css" rel="stylesheet">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.tableContent{
	width: 100%;
}
.tableContent tr{
	height: 32px;
}
.table-c{
}
.table-c table{border: 0}
.table-c table td{border-left:1px solid #767474;border-bottom: 1px solid #767474;}
.table-c table td:FIRST-CHILD{border-left:0;}
.table-c table td:nth-last-child(0){border-right:0;border-left:0;}
.table-c table tr:nth-last-child(0) td{border-right:0;border-left:0;border: 0;}
.tabletr{
	border: 0;
}
.tabletr td{
	
}
.bar {
    background-color: #eff7ff;
    border-bottom: 1px solid #d7e8f8;
    height: 40px;
    line-height: 40px;
}
.bar a {
	font-family: "微软雅黑",Helvetica,Arial,sans-serif;
    color: #2b7dbc;
    text-decoration: none;
    font-size: 14px;
    font-family: '宋体';
}
</style>
<title>客户档案</title>
</head>
<body class="bodycolor">
<c:if test="${empty(param.from) }">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户档案</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="bar">
	<a href="javascript:void();" onclick="$.utile.openDialog('${ctx}/customerTrack/add?customerId=${customer.dbid }&typeRedirect=6','添加跟进记录',900,500)">添加跟踪记录</a>
	|
	<a href="javascript:;" id="print" class="" onclick="window.history.go(-1)" style="margin-left: 5px;">返回</a>
</div>
</c:if>
<c:if test="${!empty(param.from) }">
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void(-1);" onclick="window.close()">关闭</a>
   </div>
</div>
</c:if>
<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e5e5e5 ;">
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">编号：</td>
		<td>
			${customer.sn }
		</td>
		<td class="formTableTdLeft" align="right" width="12%">信息来源：</td>
		<td>
			 ${customer.customerInfrom.name }
		</td>
	</tr>	
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">姓名：</td>
		<td width="38%" align="left">
			${customer.name }
			(
				<span style="color: #56a845">${customer.sex }</span>
			)
			<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/custCustomer/edit?dbid=${customer.dbid}&parentMenu=1'">编辑档案</a>
		</td>
		<td class="formTableTdLeft" width="12%" align="right">联系电话：</td>
		<td width="38%" align="left">
			${customer.mobilePhone }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">车型：</td>
		<td width="38%" align="left">
			${customerBussi.brand.name }
			${customerBussi.carSeriy.name }
			${customerBussi.carModel.name}
			${customer.carModelStr }
		</td>
		<td class="formTableTdLeft" width="12%" align="right">销售员：</td>
		<td width="38%" align="left">
			${customer.user.realName }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">初次级别：</td>
		<td>
			${customer.firstCustomerPhase.name}
		</td>
		<td class="formTableTdLeft" align="right" width="12%">当前级别：</td>
		<td >
			${customer.customerPhase.name}
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">客户状态：</td>
		<td width="38%" align="left">
			<c:if test="${customer.lastResult==0 }">
				<span style="color:maroon;">创建</span>
			</c:if>
			<c:if test="${customer.lastResult==1 }">
				<span style="color: green;">提报订单</span>
			</c:if>
			<c:if test="${customer.lastResult>1 }">
				<span style="color: red;">客户流失</span>
			</c:if>
		</td>
		<td class="formTableTdLeft" width="12%" align="right">创建时间：</td>
		<td width="38%" align="left">
			<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
		</td>
	</tr>
	<tr>
			<td class="formTableTdLeft" align="right" width="12%">订单状态：</td>
			<td width="38%" align="left">
				<c:if test="${empty(orderContract) }">
					<c:if test="${customer.lastResult>1 }">
						<span style="color: red;">客户流失</span>
					</c:if>
					<c:if test="${customer.lastResult==1 }">
						<span style="color: red;">待填写订单</span>
					</c:if>
				</c:if>
				<c:if test="${!empty(orderContract) }">
					<c:if test="${orderContract.status==0 }">
						<span style="color: red;">创建订单</span>
					</c:if>
					<c:if test="${orderContract.status==1 }">
						<span style="color: red;">审批中...</span>
						<a href="javascript:void();" onclick="window.location.href='/orderContract/viewOrderContract?dbid=${orderContract.dbid }'">查看订单</a> 
					</c:if>
					<c:if test="${orderContract.status==2 }">
						<span style="color: green;">审批同意</span>
						<a href="javascript:void();" onclick="window.location.href='/orderContract/viewOrderContract?dbid=${orderContract.dbid }'">查看订单</a> |
						<a href="javascript:void();" onclick="window.open('${ctx }/orderContract/printContract?dbid=${orderContract.dbid }')">打印合同</a>
					</c:if>
					<c:if test="${orderContract.status==3 }">
						<span style="color: red;">审批驳回</span>
						<a href="javascript:void();" onclick="window.location.href='/orderContract/viewOrderContract?dbid=${orderContract.dbid }'">查看订单</a> 
					</c:if>
					<c:if test="${orderContract.status==4 }">
						<span style="color: green;">合同已打印</span>
						<a href="javascript:void();" onclick="window.location.href='/orderContract/viewOrderContract?dbid=${orderContract.dbid }'">查看订单</a> |
						<a href="javascript:void();" onclick="window.open('${ctx }/orderContract/printContract?dbid=${orderContract.dbid }')">打印合同</a>
					</c:if>
				</c:if>
			</td>
			<td class="formTableTdLeft" align="right" width="12%">交车状态：</td>
			<td width="38%" align="left">
				<c:if test="${empty(customerShoppingRecord) }">
					<c:if test="${customer.lastResult>1 }">
						<span style="color: red;">客户流失</span>
					</c:if>
					<c:if test="${customer.lastResult==1 }">
						<span style="color: red;">待交车</span>
					</c:if>
				</c:if>
				<c:if test="${!empty(customerPidBookingRecord) }">
					<c:if test="${empty(customer.customerPidBookingRecord.pidStatus) }">
						<span style="color: red;">待交车</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==1 }">
						<span style="color: green">发起交车</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==3 }">
						<span style="color: #DD9A4B;">合同流失...</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==2 }">
						<span style="color: #DD9A4B;">已归档</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
						<span style="color: green;">合同流失同意</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
						<span style="color: red;">合同流失驳回</span>
					</c:if>
					(
					<c:if test="${customer.customerPidBookingRecord.hasCarOrder==1 }">
						<span style="color: blue;">现车订单</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.hasCarOrder==2 }">
						<span style="color:green;">在途订单</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.hasCarOrder==3 }">
						<span style="color: red;">无车订单</span>
					</c:if>
					)
					<c:if test="${!empty(customerPidBookingRecord) }">
						<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customerPidBookingRecord.vinCode }&amp;type=1">${customerPidBookingRecord.vinCode }</a>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft" align="right" width="12%">按揭状态：</td>
			<td width="38%" align="left">
				<c:if test="${empty(finCustomer) }">
					客户无按揭资料
				</c:if>
				<c:if test="${!empty(finCustomer) }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='/finCustomer/finCustomerFile?finCustomerId=${finCustomer.dbid}&type=1'">按揭资料</a>
				</c:if>
			</td>
			<td class="formTableTdLeft" width="12%" align="right">保险状态：</td>
			<td width="38%" align="left">
				<c:if test="${empty(insCustomer) }">
					客户无保险资料
				</c:if>
				<c:if test="${!empty(insCustomer) }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='/insCustomer/insCustomerDetail?dbid=${insCustomer.dbid}'">保险资料</a>
				</c:if>
			</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">是否到店：</td>
		<td>
			<c:if test="${customer.comeShopStatus==1||empty(customer.comeShopStatus)}">
					未到店				
				</c:if>
				<c:if test="${customer.comeShopStatus==2 }">
					<span style="color: red;">首次到店</span>		
					首次到店时间：${customer.comeShopDate }			
				</c:if>
				<c:if test="${customer.comeShopStatus==3 }">
					<span style="color: red;">二次到店</span>二次到店司机：${customer.twoComeShopDate }
					首次到店时间：${customer.comeShopDate }			
				</c:if>
		</td>
		<td class="formTableTdLeft" align="right" width="12%">试驾状态：</td>
		<td>
			<c:if test="${customer.tryCarStatus==1||empty(customer.tryCarStatus)}">
				未试驾				
			</c:if>
			<c:if test="${customer.tryCarStatus==2 }">
				<span style="color: red;">已试驾</span>	${customer.tryCarDate }		
			</c:if>
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">备注：</td>
		<td  colspan="3">
			${customer.note }
		</td>
	</tr>
</table>
<div class="containerLeft" style="width: 100%">
	<div style="margin: 5px 12px;border-buttom:1px solid rgb( 222, 222, 222 ); margin-top: 30px;">
		<ul class="nav nav-tabs" role="tablist">
		  	<c:if test="${param.type==1 }" var="sta">
				  <li class="active">
				  	<a href="#baseInfo" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  	<c:if test="${sta==false }">
				  <li>
				  	<a href="#baseInfo" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		   <c:if test="${param.type==2 }" var="sta">
		  		<li class="active"><a href="#comeShop" role="tab" data-toggle="tab">来店记录</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  		<li><a href="#comeShop" role="tab" data-toggle="tab">来店记录</a></li>
		  </c:if>
		   <c:if test="${param.type==3 }" var="sta">
		  	<li class="active"><a href="#construct" role="tab" data-toggle="tab">跟踪记录</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#construct" role="tab" data-toggle="tab">跟踪记录</a></li>
		  </c:if>
		   <c:if test="${param.type==4 }" var="sta">
		  	<li  class="active"><a href="#carOperateLog" role="tab" data-toggle="tab">操作日志</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#carOperateLog" role="tab" data-toggle="tab">操作日志</a></li>
		  </c:if>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content" >
			<c:if test="${param.type==1 }" var="sta">
			  <div class="tab-pane active" id="baseInfo" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="baseInfo" >
			</c:if>
		  	<table border="1" align="center" class="" cellpadding="0" cellspacing="0" style="width: 98%;border: 1px solid #CCC;padding: 12px">
				<tr style="height: 30px;">
					<td class="formTableTdLeft">客户姓名：</td>
					<td>
						${customer.name }&nbsp;&nbsp;${customer.sex }
					</td>
					<td class="formTableTdLeft">意向级别：</td>
					<td >
						${customer.customerPhase.name }
					</td>
				</tr>
				<tr style="height: 30px;">
					<td class="formTableTdLeft">生日：</td>
					<td>
						<fmt:formatDate value="${customer.nbirthday }"/> 
					</td>
					<td class="formTableTdLeft" >年龄：</td>
					<td >
						${customer.age }
					</td>
				</tr>
				<tr style="height: 30px;">
					<td class="formTableTdLeft">家用电话：</td>
					<td>
						${customer.phone }
					</td>
					<td class="formTableTdLeft">常用手机号：</td>
					<td>
						${customer.mobilePhone }
					</td>
				</tr>
					<tr style="height: 30px;">
						<td class="formTableTdLeft">EMAIL：</td>
						<td>
							${customer.email }
						</td>
						<td class="formTableTdLeft">QQ/MSN：</td>
						<td>
							${customer.qq }
						</td>
					</tr>
				<tr style="height: 30px;">
				    <td class="formTableTdLeft">家庭情况：</td>
					<td>
						${customer.family }
					</td>
					<td>
						单位信息：
					</td>
					<td>
						${customer.companyName1 }
					</td>
				</tr>
				<tr style="height: 30px;">
					<td class="formTableTdLeft">证件信息：</td>
					<td>
						${ customer.paperwork.name}
					</td>
					<td class="formTableTdLeft">证件号码：</td>
					<td>
						${customer.icard }
					</td>
				</tr>
				
				<tr style="height: 30px;">
					<td class="formTableTdLeft">地域：</td>
					<td id="areaLabel">
						${customer.area.fullName }
					</td>
					<td class="formTableTdLeft">地址：</td>
					<td>
						${customer.address }
					</td>
				</tr>
				<tr style="height: 30px;">
					<td class="formTableTdLeft" >邮编：</td>
					<td >
						${customer.zipCode }
					</td>
					<td class="formTableTdLeft">行业：</td>
					<td>
						${customer.industry.name}
					</td>
					
				</tr>
				<tr style="height: 30px;">
					<td class="formTableTdLeft">职业：</td>
					<td>
						${customer.profession.name}
					</td>
					<td class="formTableTdLeft">学历：</td>
					<td>
							${customer.educational.name}
					</td>
				</tr>
				<tr style="height: 30px;">
				    <td class="formTableTdLeft">业务员：</td>
					<td>
						${customer.bussiStaff }
					</td>
				</tr>
		</table>
	</div>
			<c:if test="${param.type==2 }" var="sta">
			  <div class="tab-pane active" id="comeShop" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="comeShop" >
			</c:if>
				<table border="1" align="center" class="" cellpadding="0" cellspacing="0" style="width: 98%;border: 1px solid #CCC;">
				<tr style="height: 30px;">
					<td class="formTableTdLeft">部门：</td>
					<td>
						${ customer.department.name}
					</td>
					<td class="formTableTdLeft">进店时间：</td>
					<td>
						${customerShoppingRecord.comeInTime }
					</td>
				</tr>
				<tr style="height: 30px;">
					<td>
						离店时间：
					</td>
					<td>
						${customerShoppingRecord.farwayTime }
					</td>
					<td class="formTableTdLeft">停留时间：</td>
					<td>
						<c:if test="${customerShoppingRecord.waitingTime==1}">
							约10分钟
						</c:if>
						<c:if test="${customerShoppingRecord.waitingTime==2}">
							约20分钟
						</c:if>
						<c:if test="${customerShoppingRecord.waitingTime==3}">
							约30分钟
						</c:if>
						<c:if test="${customerShoppingRecord.waitingTime==4}">
							约1小时
						</c:if>
						<c:if test="${customerShoppingRecord.waitingTime==5}">
							约2小时
						</c:if>
						<c:if test="${customerShoppingRecord.waitingTime==6}">
							约3小时
						</c:if>
						<c:if test="${customerShoppingRecord.waitingTime==7}">
							约5小时
						</c:if>
						<c:if test="${customerShoppingRecord.waitingTime==8}">
							约8小时
						</c:if>
					</td>
				</tr>
				<tr style="height: 30px;">
				    <td class="formTableTdLeft">设置：</td>
					<td>
						<label style="float: left;"><input  type="checkbox" id="isGetCar" name="customerShoppingRecord.isGetCar"  ${customerShoppingRecord.isGetCar==true?'checked="checked"':'' } value="true"> 客户是否有车</label>
					</td>
					<td class="formTableTdLeft">
						试驾专员：
					</td>
					<td>
						${customerShoppingRecord.tryDriver }
					</td>
				</tr>
				<tr style="height: 30px;">
				    <td class="formTableTdLeft">客户车型：</td>
					<td>
						${customerShoppingRecord.carModel }
					</td>
					<td class="formTableTdLeft">
						客户随性人数：
					</td>
					<td>
						${customerShoppingRecord.customerNum }
					</td>
				</tr>
				<tr style="height: 30px;">
					<td class="formTableTdLeft">接待经过：</td>
					<td  colspan="3">
						${customerShoppingRecord.receptionExperience }
					</td>
				</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft">购车关注点：</td>
				<td>
					${customerBussi.buyCarCare.name }
				</td>
			</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft">购车主要目的：</td>
				<td>
					${customerBussi.buyCarTarget.name}
				</td>
				<td class="formTableTdLeft">购车类型：</td>
				<td>
					${customerBussi.buyCarType.name}
				</td>
			</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft" >意向车型：</td>
				<td id="carModelLabel">
					${customerBussi.carSeriy.name}
					${customerBussi.carModel.name}
				</td>
				<td class="formTableTdLeft" >购车预算：</td>
				<td colspan="">
					${customerBussi.buyCarBudget.name}
				</td>
			</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft">主要使用者：</td>
				<td >
					 ${customerBussi.buyCarMainUse.name}
				</td>
			</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft">客户特征：</td>
				<td colspan="3">
					${customerBussi.customerSpecification }
				</td>
			</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft">客户需求：</td>
				<td colspan="3">
					${customerBussi.customerNeed }
				</td>
			</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft" >主要关注竞品：</td>
				<td colspan="3">
					${customerBussi.customerCareAbout }
				</td>
			</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft">其它重点描述：</td>
				<td colspan="3">
					${customerBussi.otherMainDescription }
				</td>
			</tr>
				<tr style="height: 30px;">
					<td class="formTableTdLeft">后续跟进计划：</td>
					<td colspan="3">
						${customerBussi.afterPlan }
					</td>
				</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft">备注：</td>
				<td colspan="3">
					${customerBussi.note }
				</td>				
			</tr>
			</table>
		  </div>
		  	<c:if test="${param.type==3 }" var="sta">
			   <div class="tab-pane active" id="construct" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="construct">
			</c:if>
				<c:if test="${empty(customertracks)||customertracks==null }" var="status">
					<div class="alert alert-info">
						<strong>提示!</strong> 当前未添加数据.
					</div>
				</c:if>
				<c:if test="${status==false }">
					<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
						<thead>
						<tr>
							<td style="width:120px;">跟进日期</td>
							<td style="width:40px;">跟进方法</td>
							<td style="width: 40px;">意向级别</td>
							<td style="width: 80px;">下次预约时间</td>
							<td style="width:120px;">跟进内容</td>
							<td style="width: 120px;">沟通结果</td>
							<td style="width: 80px;">客户反馈问题</td>
							<td style="width: 80px;">对应措施</td>
							<td style="width: 80px;">展厅经理意见</td>
							<td style="width: 80px;">销售经理意见</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${customertracks }" var="customerTrack">
						<tr>
							<td>
								<fmt:formatDate value="${customerTrack.trackDate}" pattern="yyyy-MM-dd HH:mm"/>
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
								${customerTrack.beforeCustomerPhase.name}
							</td>
							<td>
								<fmt:formatDate value="${customerTrack.nextReservationTime}" pattern="yyyy-MM-dd HH:mm"/> 
							</td>
							
							<td style="text-align: left;">
									${customerTrack.trackContent }
							</td>
							<td style="text-align: left;">
									${customerTrack.result }
							</td>
							<td style="text-align: left;">
									${customerTrack.feedBackResult }
							</td>
							<td style="text-align: left;">
									${customerTrack.dealMethod }
							</td>
							<td style="text-align: left;">
									${customerTrack.showroomManagerSuggested }
							</td>
							<td style="text-align: left;">
									${customerTrack.salesNote }
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<br>
				<br>
				<br>
				</c:if>
		  </div>
		  	<c:if test="${param.type==4 }" var="sta">
			   <div class="tab-pane active" id="carTransfer" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carTransfer">
			</c:if>
				<c:if test="${empty(customertracks)||customertracks==null }" var="status">
						<div class="alert alert-info">
							<strong>提示!</strong> 当前未添加数据.
						</div>
					</c:if>
					<c:if test="${status==false }">
						<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
							<thead>
							<tr>
								<td style="width:80px;">跟进日期</td>
								<td style="width:40px;">跟进方法</td>
								<td style="width: 40px;">意向级别</td>
								<td style="width: 80px;">下次预约时间</td>
								<td style="width:120px;">跟进内容</td>
								<td style="width: 120px;">沟通结果</td>
								<td style="width: 80px;">客户反馈问题</td>
								<td style="width: 80px;">对应措施</td>
								<td style="width: 80px;">展厅经理意见</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${customertracks }" var="customerTrack">
							<tr>
								<td>
									<fmt:formatDate value="${customerTrack.trackDate}" pattern="yyyy-MM-dd HH:mm"/> 
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
									${customerTrack.beforeCustomerPhase.name}
								</td>
								<td>
									<fmt:formatDate value="${customerTrack.nextReservationTime}" pattern="yyyy-MM-dd HH:mm"/> 
								</td>
								
								<td style="text-align: left;">
										${customerTrack.trackContent }
								</td>
								<td style="text-align: left;">
										${customerTrack.result }
								</td>
								<td style="text-align: left;">
										${customerTrack.feedBackResult }
								</td>
								<td style="text-align: left;">
										${customerTrack.dealMethod }
								</td>
								<td style="text-align: left;">
										${customerTrack.showroomManagerSuggested }
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					</c:if>
		  </div>
		  <c:if test="${param.type==4 }" var="sta">
			   <div class="tab-pane active" id="carOperateLog" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carOperateLog">
			</c:if>
		  		<c:if test="${fn:length(customerOperatorLogs)<=0}" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无客户操作日志
					</div>
				</c:if>
				<c:if test="${status==false}">
					<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="margin-bottom: 32px;">
						<thead>
							<tr>
								<td style="width: 40px;">
									序号		
								</td>
								<td style="width: 120px;">操作类型</td>
								<td style="width: 80px;">操作时间</td>
								<td style="width: 80px;">操作人</td> 
								<td style="width: 120px;">备注</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${customerOperatorLogs}" var="finOperatorLog" varStatus="i">
							<tr >
								<td style="text-align: center;">
									${i.index+1 }
								</td>
								<td>
									${finOperatorLog.type }
								</td>
								<td>
									<fmt:formatDate value="${finOperatorLog.operateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>	 
								</td>
								<td>
									${finOperatorLog.operator}
								</td>
								<td style="text-align: left;">
									${finOperatorLog.note}
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
		  </div>
		  
		</div>
	</div>
</div>
<div style="display: none; width: 340px;" id="templateId">
		<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 400px;margin-top: 5px;">
			<tr style="height: 60px;" height="60">
				<td class="formTableTdLeft" width="80">到店成交:&nbsp;</td>
				<td colspan="3">
					<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="1">到店成交</label>
					<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="2">到店未成交</label>
				</td>
			</tr>
		</table>
	</div>
</body>
<script type='text/javascript'  src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script type='text/javascript'  src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
	function comeShopeRecord(){
		top.art.dialog({
		    title: '客户到店登记',
		    content: document.getElementById('templateId'),
		    width:500,
		    lock : true,
			fixed : true,
		    ok: function () {
		    	var comeShopeStatus=window.parent.document.getElementsByName("comeShopeStatus");
		    	var selectvalue="";   //  selectvalue为radio中选中的值
	            for(var i=0;i<comeShopeStatus.length;i++){
                    if(comeShopeStatus[i].checked==true) {
                    	selectvalue=comeShopeStatus[i].value; 
                   }
	            }
		    	if(null==selectvalue||selectvalue==''){
		    		alert("请选择到店成交状态！");
		    		return false;
		    	}
	    		var url='${ctx}/custCustomer/comeShopRecord?customerId=${customer.dbid}&comeShopeStatus='+selectvalue+"&redirectType=1";
	    		window.location.href=url;
				return true;
		    },
		    cancel:function(){
				return true;
		    }
		});
	}
</script>
</html>
