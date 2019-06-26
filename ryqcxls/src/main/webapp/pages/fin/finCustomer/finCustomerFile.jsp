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
</style>
<title>贷款客户档案</title>
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
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void(-1);" onclick="window.history.go(-1)">返回</a>
   </div>
   <div style="clear: both;"></div>
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
		<td class="formTableTdLeft" align="right" width="12%">姓名：</td>
		<td width="38%" align="left">
			${finCustomer.name }
			(
				<c:if test="${finCustomer.customerType==1 }">
					<span style="color: #56a845">保有</span>
				</c:if>
				<c:if test="${finCustomer.customerType==2 }">
					<span style="color: #ff6700">多品牌</span>
				</c:if>
			)
		</td>
		<td class="formTableTdLeft" width="12%" align="right">联系电话：</td>
		<td width="38%" align="left">
			${finCustomer.mobilePhone }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">车型：</td>
		<td width="38%" align="left">
			${finCustomer.carSeriyName }
		</td>
		<td class="formTableTdLeft" width="12%" align="right">销售员：</td>
		<td width="38%" align="left">
			${finCustomer.saler }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">客户状态：</td>
		<td width="38%" align="left">
			<c:if test="${finCustomer.customerStatus==1 }">
				<span style="color:maroon;">创建</span>
			</c:if>
			<c:if test="${finCustomer.customerStatus==2 }">
				<span style="color: green;">成交</span>
			</c:if>
			<c:if test="${finCustomer.customerStatus==3 }">
				<span style="color: red;">流失</span>
			</c:if>
		</td>
		<td class="formTableTdLeft" width="12%" align="right">申请时间：</td>
		<td width="38%" align="left">
			${finCustomer.createDate }
		</td>
	</tr>
	<tr>
			<td class="formTableTdLeft" align="right" width="12%">成交状态：</td>
			<td width="38%" align="left">
				<c:if test="${finCustomer.fileStatus==1 }">
					<span style="color: red;">待交车</span>
				</c:if>
				<c:if test="${finCustomer.fileStatus==2 }">
					<span style="color: green;">已交车</span>
				</c:if>
			</td>
			<td class="formTableTdLeft" align="right" width="12%">上户状态：</td>
			<td width="38%" align="left">
				<c:if test="${finCustomer.householdRegStatus==1 }">
					<span style="color: red;">待上户</span>
				</c:if>
				<c:if test="${finCustomer.householdRegStatus==2 }">
					<span style="color: green;">已上户</span>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft" align="right" width="12%">放款状态：</td>
			<td width="38%" align="left">
				<c:if test="${finCustomer.loanStatus==1 }">
					<span style="color: red;">待放款</span>
				</c:if>
				<c:if test="${finCustomer.loanStatus==2 }">
					<span style="color: green;">已放款</span>
				</c:if>
			</td>
			<td class="formTableTdLeft" align="right" width="12%">申请结果：</td>
			<td width="38%" align="left">
				<c:if test="${finCustomer.applyStatus==1 }">
					<span style="color: red;">审批中...</span>
				</c:if>
				<c:if test="${finCustomer.applyStatus==3 }">
					<span style="color: red;">失败</span>
				</c:if>
				<c:if test="${finCustomer.applyStatus==2 }">
					<span style="color: green;">通过</span>
				</c:if>
			</td>
		</tr>
</table>
<div class="containerLeft" style="width: 100%">
	<div style="margin: 5px 12px;border-buttom:1px solid rgb( 222, 222, 222 ); margin-top: 30px;">
		<ul class="nav nav-tabs" role="tablist">
		  	<c:if test="${param.type==1 }" var="sta">
				  <li class="active">
				  	<a href="#factoryOrder" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  	<c:if test="${sta==false }">
				  <li>
				  	<a href="#factoryOrder" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  <c:if test="${param.type==2 }" var="sta">
		  	<li class="active">
		  		<a href="#installItem" role="tab" data-toggle="tab">贷款信息</a>
		  	</li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#installItem" role="tab" data-toggle="tab">贷款信息</a></li>
		  </c:if>
		   <c:if test="${param.type==3 }" var="sta">
		  	<li class="active"><a href="#carTransfer" role="tab" data-toggle="tab">邮寄信息</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#carTransfer" role="tab" data-toggle="tab">邮寄信息</a></li>
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
			  <div class="tab-pane active" id="factoryOrder" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="factoryOrder" >
			</c:if>
		  		<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
		  			<tr>
						<td class="formTableTdLeft" >地址：</td>
						<td width="38%" align="left">
							${finCustomer.address }
						</td>
						<td class="formTableTdLeft">身份证：</td>
						<td width="38%" align="left">
							${finCustomer.icard }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" >共申人：</td>
						<td width="38%" align="left">
							${finCustomer.commName }
						</td>
						<td class="formTableTdLeft" >共申人电话：</td>
						<td width="38%" align="left">
							${finCustomer.commMobilePhone }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">销售员：</td>
						<td>
							${finCustomer.saler }
						</td>
						<td class="formTableTdLeft">销售员电话：</td>
						<td>
							${finCustomer.salerPhone }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">销售公司：</td>
						<td>
							${finCustomer.saleCompany.name }
						</td>
						<td class="formTableTdLeft">部门：</td>
						<td>
							${finCustomer.dep }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">创建日期：</td>
						<td>
							${finCustomer.createDate}
						</td>
						<td class="formTableTdLeft">最后一次修改日期：</td>
						<td>
							${finCustomer.modifyDate}
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">区域：</td>
						<td colspan="3">
							${finCustomer.netArea }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">备注：</td>
						<td colspan="3">
							${finCustomer.note }
						</td>
					</tr>
				</table>
		  </div>
		  	<c:if test="${param.type==2 }" var="sta">
			   <div class="tab-pane active" id="installItem" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="installItem">
			</c:if>
				<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
		  			<tr>
						<td class="formTableTdLeft" >车价：</td>
						<td width="38%" align="left">
							${finCustomerLoan.carPrice }
						</td>
						<td class="formTableTdLeft">开票价：</td>
						<td width="38%" align="left">
							${finCustomerLoan.kaiPiaoPrice }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" >贷款金额：</td>
						<td width="38%" align="left">
							${finCustomerLoan.loanPrice }
						</td>
						<td class="formTableTdLeft" >手续费：</td>
						<td width="38%" align="left">
							${finCustomerLoan.countFee }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">贷款产品：</td>
						<td>
							${finCustomerLoan.finProductName }
						</td>
						<td class="formTableTdLeft">年限：</td>
						<td>
							${finCustomerLoan.finProductItemName }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">月供：</td>
						<td>
							${finCustomerLoan.monthSupPrice }
						</td>
						<td class="formTableTdLeft">利息：</td>
						<td>
							${finCustomerLoan.annualInterest }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">实际利息：</td>
						<td>
							${finCustomerLoan.actDiscountPrice }
						</td>
						<td class="formTableTdLeft">公司贴息：</td>
						<td>
							${finCustomerLoan.companyDiscountPrice }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">利润：</td>
						<td>
							${finCustomerLoan.profitPrice }
						</td>
						<td class="formTableTdLeft">贴息金额：</td>
						<td>
							${finCustomerLoan.discountMony }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">盗抢险产值：</td>
						<td>
							${finCustomerLoan.dqxProfitPrice }
						</td>
						<td class="formTableTdLeft">贷款成数：</td>
						<td>
							${finCustomerLoan.loanPer }
						</td>
					</tr>
				</table>
		  </div>
		  	<c:if test="${param.type==3 }" var="sta">
			   <div class="tab-pane active" id="carTransfer" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carTransfer">
			</c:if>
				<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
					<tr>
						<td class="formTableTdLeft">成交状态：</td>
						<td width="38%" align="left">
							<c:if test="${finCustomer.fileStatus==1 }">
								<span style="color: red;font-size: 14px;">待交车</span>
							</c:if>
							<c:if test="${finCustomer.fileStatus==2 }">
								<span style="color: green;font-size: 14px;">已交车</span>
							</c:if>
						</td>
						<td class="formTableTdLeft">归档日期：</td>
						<td width="38%" align="left">
							${ finCustomer.fileDate}
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">上户状态：</td>
						<td width="38%" align="left">
							<c:if test="${finCustomer.householdRegStatus==1 }">
								<span style="color: red;font-size: 14px;">待上户</span>
							</c:if>
							<c:if test="${finCustomer.householdRegStatus==2 }">
								<span style="color: green;font-size: 14px;">已上户</span>
							</c:if>
						</td>
						<td class="formTableTdLeft">上户时间：</td>
						<td width="38%" align="left">
							${ finCustomer.householdRegDate}
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">上户区域：</td>
						<td width="38%" align="left">
							${finCustomer.householdRegArea }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">放款状态：</td>
						<td width="38%" align="left">
							<c:if test="${finCustomer.loanStatus==1 }">
								<span style="color: red;font-size: 14px;">待放款</span>
							</c:if>
							<c:if test="${finCustomer.loanStatus==2 }">
								<span style="color: green;font-size: 14px;">已放款</span>
							</c:if>
						</td>
						<td class="formTableTdLeft">放款时间：</td>
						<td width="38%" align="left">
							${ finCustomer.loanDate}
						</td>
					</tr>
						<tr>
							<td class="formTableTdLeft">邮寄状态：</td>
							<td width="38%" align="left">
								<c:if test="${finCustomer.mailStatus==1 }">
									<span style="color: red;font-size: 14px;">待邮寄</span>
								</c:if>
								<c:if test="${finCustomer.mailStatus==2 }">
									<span style="color: green;font-size: 14px;">已邮寄</span>
								</c:if>
							</td>
							<td class="formTableTdLeft">邮寄时间：</td>
							<td width="38%" align="left">
								${ finCustomer.mailDate}
							</td>
						</tr>
						<tr>
							<td class="formTableTdLeft">邮寄单号：</td>
							<td width="38%" align="left">
								${ finCustomer.mailNo}
							</td>
							<td class="formTableTdLeft">备注：</td>
							<td width="38%" align="left">
								${finCustomer.mailNote }
							</td>
						</tr>
					
					</tbody>
				</table>
		  </div>
		  <c:if test="${param.type==4 }" var="sta">
			   <div class="tab-pane active" id="carOperateLog" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carOperateLog">
			</c:if>
		  		<c:if test="${fn:length(finOperatorLogs)<=0}" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>车辆操作日志
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
							<c:forEach items="${finOperatorLogs}" var="finOperatorLog" varStatus="i">
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
</body>
<script type='text/javascript'  src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script type='text/javascript'  src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
