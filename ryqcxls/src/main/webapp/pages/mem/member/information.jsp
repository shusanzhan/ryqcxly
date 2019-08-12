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
</style>
<title>备案经纪人明细</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">备案经纪人明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)"  class="but button" onclick="$.utile.openDialog('${ctx}/pointRecord/add?memberId=${member.dbid }&directType=2&type=2','调整积分',900,500)">调整积分</a>
		<a class="but butCancle" href="javascript:void(-1);" onclick="window.history.go(-1)">返回</a>
   </div>
   <div style="clear: both;"></div>
</div>
<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e5e5e5 ">
	<tr>
		<td class="formTableTdLeft">姓名：</td>
		<td>
			${member.name}&nbsp;&nbsp;&nbsp;
		</td>
		<td class="formTableTdLeft">编号：</td>
		<td>
			${member.no }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft">手机：</td>
		<td>
			${member.mobilePhone }
		</td>
		<td class="formTableTdLeft">电话：</td>
		<td>
			${member.phone }
		</td>
	</tr>
</table>
<div class="containerLeft" style="width: 100%">
	<div style="margin: 5px 12px;border-buttom:1px solid rgb( 222, 222, 222 ); margin-top: 30px;">
		<ul class="nav nav-tabs" role="tablist">
		  	<c:if test="${param.type==1 }" var="sta">
				  <li class="active">
				  	<a href="#member" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  	<c:if test="${sta==false }">
				  <li>
				  	<a href="#member" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		   <c:if test="${param.type==4 }" var="sta">
		  	<li  class="active"><a href="#point" role="tab" data-toggle="tab">积分记录</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#point" role="tab" data-toggle="tab">积分记录</a></li>
		  </c:if>
			  <c:if test="${param.type==6 }" var="sta">
		  	<li  class="active"><a href="#wechat" role="tab" data-toggle="tab">微信资料</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#wechat" role="tab" data-toggle="tab">微信资料</a></li>
		  </c:if>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content" >
			<c:if test="${param.type==1 }" var="sta">
			  <div class="tab-pane active" id="member" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="member" >
			</c:if>
		  		<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
					<tr>
						<td class="formTableTdLeft">姓名：</td>
						<td>
							${member.name}&nbsp;&nbsp;&nbsp;
						</td>
						<td class="formTableTdLeft">编号：</td>
						<td>
							${member.no }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">手机：</td>
						<td>
							${member.mobilePhone }
						</td>
						<td class="formTableTdLeft">身份证号：</td>
						<td>
							<%-- ${empty(member.icard)?'-':member.icard } --%>
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">出生日期：</td>
						<td>
							<fmt:formatDate value="${member.birthday }" pattern="yyyy-MM-dd"/> 
						</td>
						<%-- <td class="formTableTdLeft">学历：</td>
						<td>
							${member.memberInfo.eduBg.name}
						</td> --%>
					</tr>
					<tr>
						<td class="formTableTdLeft">电话：</td>
						<td>
							${empty(member.phone)?'-':member.phone }
						</td>
						<td class="formTableTdLeft">等级：</td>
						<td>
							<c:if test="${member.memberShipLevel.dbid==1 }">普通</c:if>
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">地区：</td>
						<td>
							${member.memberInfo.area.fullName }
						</td>
						<td class="formTableTdLeft">详细地址：</td>
						<td>
							${member.memberInfo.address }
						</td>
					</tr>
				</table>
		  </div>
		  	<c:if test="${param.type==3 }" var="sta">
			   <div class="tab-pane active" id="integralRecords" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="integralRecords">
			</c:if>
				<c:if test="${empty(couponMembers)||couponMembers==null }" var="status">
					<div class="alert alert-error">
						<strong>提示!</strong> 会员未添加优惠券
					</div>
				</c:if>
				<c:if test="${status==false }">
				<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
					<thead  class="TableHeader">
						<tr>
							<td class="span2">名称</td>
							<td class="span2">sn码</td>
							<td class="span1">类型</td>
							<td class="span1">折扣/金额</td>
							<td class="span1">姓名</td>
							<td class="span1">电话</td>
							<td class="span2">有效期</td>
							<td class="span2">创建人</td>
							<td class="span1">是否启用</td>
							<td class="span2">是否使用</td>
						</tr>
					</thead>
					<c:forEach var="couponMember" items="${couponMembers }">
							<tr>
								<td>${couponMember.name }</td>
								<td style="text-align: center;">
									${couponMember.code }
								</td>
								<td style="text-align: center;">
									<c:if test="${couponMember.type==1 }">
										折扣券							
									</c:if>
									<c:if test="${couponMember.type==2 }">
										代金券
									</c:if>
								</td>
								<td>
									<c:if test="${couponMember.showHiden==true }">
										<c:if test="${couponMember.type==1 }">
											<span style="color: red;font-size: 16px;">${ couponMember.moneyOrRabatt} 折</span>
										</c:if>
										<c:if test="${couponMember.type==2 }">
											<span style="color: red;font-size: 16px;">
												￥<fmt:formatNumber value="${ couponMember.moneyOrRabatt}"></fmt:formatNumber>
											</span>
										</c:if>
									</c:if>
								</td>
							    <td style="text-align: center;">
									${couponMember.member.name }
								</td>
							    <td style="text-align: center;">
									${couponMember.member.mobilePhone }
								</td>
								<td style="text-align: center;">
									<fmt:formatDate value="${couponMember.startTime}" pattern="yyyy-MM-dd"/> ~
									<fmt:formatDate value="${couponMember.stopTime }" pattern="yyyy-MM-dd"/>
								</td>
								 <td style="text-align: center;">
									${couponMember.creatorName }
								</td>
								<td align="center" style="text-align: center;">
									<c:if test="${couponMember.enabled==true }" var="status">
										<span style="color: blue;">是</span>
									</c:if>
									<c:if test="${status==false }">
										<span style="color: red;">否</span>
									</c:if>
								</td>
								<td align="center" style="text-align: center;">
										<c:if test="${couponMember.isUsed==true }" var="status">
											<span style="color: blue;">
												${couponMember.usedPersonName } &nbsp;&nbsp;
												<fmt:formatDate value="${couponMember.usedDate }" pattern="yyyy-MM-dd HH:mm"/>
											</span>
										</c:if>
										<c:if test="${status==false }">
											<span style="color: red;">否</span>
											<c:if test="${now<coupon.startTime }">
										    	<a href="javascript:void(-1)" class="btn_get" style="position:relative; margin-right: 2px;color: #E2E0E0">活动未开始</a>
										    </c:if>
										    <c:if test="${now>coupon.stopTime }">
										    	<a href="javascript:void(-1)" class="btn_get" style="position:relative;margin-right: 2px;color: #E2E0E0">已过期</a>
										    </c:if>
										</c:if>
								</td>
							</tr>
					</c:forEach>
				</table>
				</c:if>
		  </div>
		  <c:if test="${param.type==4 }" var="sta">
			   <div class="tab-pane active" id="point" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="point">
			</c:if>
		  		<div class="score_show">
				    <div class="score_show_available">可用积分：
					    <span style="color: red;font-size: 16px;font-weight: bold;">
						    <c:if test="${empty(member) }" var="status">
						    	无
						    </c:if>
						    <c:if test="${status==false }">
						    ${member.overagePiont }
						    </c:if>
					    </span>
					</div>
				    <div class="score_show_consume">消费积分：
				    <span style="color: red;font-size: 16px;font-weight: bold;">
				     <c:if test="${empty(member) }" var="status">
					    	无
					    </c:if>
					    <c:if test="${status==false }">
					   	 ${member.consumpiontPoint }
					    </c:if>
				   	</span>
				   </div>
				    <div class="clear"></div>
				</div>
		  		<c:if test="${fn:length(pointRecords)<=0}" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无积分记录
					</div>
				</c:if>
				<c:if test="${status==false}">
					<table cellpadding="0" cellspacing="0" class="mainTable tableContent" border="0">
						<thead  class="TableHeader">
							<tr>
							    <th>名称</th>
						        <th>时间</th>
						        <th>积分数</th>
						        <th>操作人</th>
						     </tr>
						</thead>
						<tbody>
						<c:forEach var="pointRecord" items="${pointRecords }" varStatus="i">
					      <c:if test="${i.index<(fn:length(pointRecords)-1) }" var="status">
						     <tr>
						       <td>${pointRecord.pointFrom }</td>
						       <td><fmt:formatDate value="${pointRecord.createTime }" pattern="yyyy年MM月dd日 HH:mm"/></td>
						       <td >${pointRecord.num }</td>
						       <td>${pointRecord.creator }</td>
						     </tr>
					      </c:if>
					      <c:if test="${status==false }">
						     <tr >
						       <td style="padding: 5px 0" class="left">${pointRecord.pointFrom }</td>
						       <td><fmt:formatDate value="${pointRecord.createTime }" pattern="yyyy年MM月dd日 HH:mm"/></td>
						       <td>${pointRecord.num }</td>
						       <td>${pointRecord.creator }</td>
						     </tr>
					      </c:if>
					      </c:forEach>
						</tbody>
					</table>
				</c:if>
		</div>
		  <c:if test="${param.type==5 }" var="sta">
			   <div class="tab-pane active" id="onlineBooking" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="onlineBooking">
			</c:if>
		  		<c:if test="${fn:length(onlineBookings)<=0}" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无预约记录
					</div>
				</c:if>
				<c:if test="${status==false}">
					<table cellpadding="0" cellspacing="0" class="mainTable tableContent" border="0">
						<thead  class="TableHeader">
							<tr>
							    <th>预约车型</th>
						        <th>申请时间</th>
						        <th>预约时间</th>
						        <th>处理时间</th>
						        <th>类型</th>
						        <th>状态</th>
						     </tr>
						</thead>
						<tbody>
						<c:forEach var="onlineBooking" items="${onlineBookings }" varStatus="i">
							<tr>
								<td>${onlineBooking.carModel }</td>
								<td><fmt:formatDate value="${onlineBooking.createTime }" pattern="yyyy-MM-dd HH:mm"/> </td>
								<td><fmt:formatDate value="${onlineBooking.bookingDate }" pattern="yyyy-MM-dd HH:mm"/> </td>
								<td><fmt:formatDate value="${onlineBooking.modifyTime }" pattern="yyyy-MM-dd HH:mm"/> </td>
								<td>
									<c:if test="${onlineBooking.bookingType=='1' }">
										试乘试驾
									</c:if>
									<c:if test="${onlineBooking.bookingType=='2' }">
										保养维修
									</c:if>
									<c:if test="${onlineBooking.bookingType=='3' }">
										续保年审
									</c:if>
									<c:if test="${onlineBooking.bookingType=='4' }">
										旧车置换
									</c:if>
								</td>
								<td>
									<c:if test="${onlineBooking.status==1 }">
										<span style="color: red;">未处理</span>
									</c:if>
									<c:if test="${onlineBooking.status==2 }">
										<span style="color: blue;">已经处理</span>
									</c:if>
								</td>
							</tr>
					      </c:forEach>
						</tbody>
					</table>
				</c:if>
		  </div>
		  <c:if test="${param.type==6 }" var="sta">
			   <div class="tab-pane active" id="wechat" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="wechat">
			</c:if>
				<c:set value="${member.weixinGzuserinfo }" var="weixinGzuserinfo"></c:set>
		  		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 82%;">
					<tr height="42">
						<td rowspan="4" colspan="2">
						<table  border="0" cellpadding="0" cellspacing="0" style="width: 200px;" height="200">
							<tr>
								<td height="140" width="200">
									<img alt="" width="200" src="${weixinGzuserinfo.headimgurl }">
								</td>
							</tr>
						</table>
						 </td>
						<td class="formTableTdLeft" style="width: 120px;">昵称:&nbsp;</td>
						<td >${weixinGzuserinfo.nickname }</td>
					</tr>
					<tr height="42">
						<td class="formTableTdLeft" style="width: 120px;">称呼:&nbsp;</td>
						<td >
							<c:if test="${weixinGzuserinfo.sex==1 }">
								先生
							</c:if>
							<c:if test="${weixinGzuserinfo.sex==2 }">
								女士
							</c:if>
						</td>
					</tr>
					
					<tr height="42">
						<td class="formTableTdLeft" style="width: 120px;">所在区域:&nbsp;</td>
						<td>
							${weixinGzuserinfo.country }${weixinGzuserinfo.province }${weixinGzuserinfo.city }
						</td>
					</tr>
					<tr height="32">
						<td class="formTableTdLeft" style="width: 120px;">关注状态:&nbsp;</td>
						<td >
							<c:if test="${weixinGzuserinfo.eventStatus==1 }">
								<span style="color:green;">已关注</span>
							</c:if>
							<c:if test="${weixinGzuserinfo.eventStatus==2 }">
								<span style="color:red;">取消关注</span>
							</c:if>
						</td>
					</tr>
					 <tr height="32">
						<td class="formTableTdLeft" style="width: 120px;">语言:&nbsp;</td>
						<td>${weixinGzuserinfo.language }</td>
						<td class="formTableTdLeft" style="width: 120px;">关注时间:&nbsp;</td>
						<td><fmt:formatDate value="${weixinGzuserinfo.addtime }" pattern="yyyy-MM-dd HH:ss"/></td>
					</tr>
					<tr height="42">
					    <td class="formTableTdLeft" style="width: 120px;">标识符:&nbsp;</td>
						<td >${ weixinGzuserinfo.openid}</td>
					</tr> 
				</table>
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
