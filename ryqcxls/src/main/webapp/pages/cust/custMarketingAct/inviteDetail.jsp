<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>市场活动管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/progressbars/css/style.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/fullcalendar.css" />	
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css" class="skin-color" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.table td {
		height: 24px;
		padding-bottom: 0px;
	}
	.table thead td{
		text-align: center;
	}
	.table tbody td{
		text-align: center;
	}
</style>
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">市场活动管理</a>
	<a href="javascript:void(-1);" class="aedit" onclick="window.history.go(-1)" style="text-align: left;float: right;padding-right: 12px;color:#2b7dbc">返回</a>
	
</div>
 <!--location end-->
<div class="line"></div>
<div class="container-fluid" style="width: 100%">
	<div class="widget-box" style="width: 96%;margin-left: 5px;" >
			<div class="widget-content nopadding">
				<ul class="stat-boxes" style="text-align: center;">
					<li>
						<div class="right">
							<strong>${custMarketingAct.targetPersonNum }</strong>
							邀约目标
						</div>
					</li>
					<li>
						<div class="right">
							<strong>${custMarketingAct.inviteNum }</strong>
							发起邀约
						</div>
					</li>
					<li>
						<div class="right">
							<strong>${accCount }</strong>
							接受邀约
						</div>
					</li>
					<li>
						<div class="right">
							<strong>${waitingCount }</strong>
							待定邀约
						</div>
					</li>
					<li>
						<div class="right">
							<strong>${disCount }</strong>
							拒绝邀约
						</div>
					</li>
			</ul>						
		</div>
	</div>
	<div class="row-fluid">
			<div class="widget-box" style="width: 96%;">
							<div class="widget-title"><span class="icon"><i class="icon-file"></i></span><h5>邀约活动信息</h5></div>
							<div class="widget-content nopadding">
								<ul class="recent-posts">
									<li>
										<div class="article-post">
											<p><a href="#">标题：${custMarketingAct.name } </a>  </p>
											<p>
												发布时间：${custMarketingAct.createDate }
											</p>
											<p>
												活动时间：${custMarketingAct.actStartDate }~${custMarketingAct.actEndDate }
											</p>
											<p>
												${custMarketingAct.content }
											</p>
										</div>
									</li>
								</ul>
							</div>
						</div>
	</div>
	<div class="row-fluid">
			<div class="span6">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-file"></i></span><h5>邀约进度</h5></div>
					<div style="margin: 0 auto;margin: 5px;height: 30px;height: 250px;">
						<section class="container" style="height: 30px;max-width: 640px;">
						    <div class="progressbar1" style="height: 26px;max-width: 440px;">
						      <fmt:formatNumber value="${(accCount+waitingCount*20/100)/custMarketingAct.targetPersonNum*100}" var="per"/>
						      <span  class="blue" style="width: ${per}%;"><span>${per }%</span></span>
						    </div>
						</section>
					</div>
				</div>
			</div>
			<div class="span6">
				<div class="widget-box" style="height: 250px;">
					<div class="widget-title">
						<span class="icon"><i class="icon-file"></i></span><h5>邀约客户反馈结果</h5></div>
					<div id="container1" style="min-width: 310px; max-width: 620px; margin: 0 auto;height: 250px;"></div>
				</div>
			</div>
	</div>
	<div class="row-fluid">
		<div class="widget-box" style="width: 96%;">
			<div class="widget-title"><span class="icon"><i class="icon-file"></i></span><h5>邀约销售顾问报表</h5></div>
			<div class="widget-content nopadding">
				<table class="table table-bordered table-striped">
					<thead>
						<tr style="text-align: center;">
							<td align="center" width="40">序号</td>
							<td align="center" width="80">部门</td>
							<td align="center" width="40">销售顾问</td>
							<td align="center" width="40">邀约次数</td>
							<td align="center" width="40">接受</td>
							<td align="center" width="40">待定</td>
							<td align="center" width="40">拒绝</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="customerTrackMarketingCount" items="${customerTrackMarketingCounts }" varStatus="i">
							<tr>
								<td align="center" width="80">${i.index+1 }</td>
								<td align="center" width="40">${customerTrackMarketingCount.depName }</td>
								<td align="center" width="40">${customerTrackMarketingCount.userName }</td>
								<td align="center" width="40">${customerTrackMarketingCount.total }</td>
								<td align="center" width="40">${customerTrackMarketingCount.accTotal }</td>
								<td align="center" width="40">${customerTrackMarketingCount.waitingTotal }</td>
								<td align="center" width="40">${customerTrackMarketingCount.disTotal }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<c:if test="${empty(customerTracks)}" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="margin-bottom: 80px;">
	<thead>
		<tr>
			<td style="width: 60px;">客户</td>
			<td style="width: 80px;">跟进类型</td>
			<td style="width: 60px;">意向级别</td>
			<td style="width: 80px;">常用手机号</td>
			<td style="width:80px;">跟进方法</td>
			<td style="width:80px;">跟进日期</td>
			<td style="width:80px;">下次联系日期</td>
			<td style="width:240px;">跟进内容</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${customerTracks }" var="customerTrack">
		<c:set var="customer" value="${customerTrack.customer }"></c:set>
		<tr>
			<td>
				${customerTrack.customer.name}
			</td>
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
			<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerTrack/view?dbid=${customerTrack.dbid}&type=1','查看跟进记录',900,500)">查看</a>  
				<%-- |<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/customerTrack/delete?dbids=${customerTrack.dbid}','searchPageForm')" title="删除">删除</a> --%>
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
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script type="text/javascript">
$(function () {
	 var data=eval("[ ['接受',${accCount}], ['待定',${waitingCount}], ['拒绝',${disCount}]]");
	 $('#container1').highcharts({
        chart: {
            type: 'pie'
        },
        title: {
            text: '回复结果比例'
        },
      
        xAxis: {
            type: 'category',
            labels: {
                rotation: -45,
                align: 'right',
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: '客户量（人）'
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: ': <b>{point.y:.1f} 人</b>',
        },
        series: [{
            name: 'Population',
            data: data,
            dataLabels: {
                enabled: true,
                rotation: -90,
                color: '#FFFFFF',
                align: 'right',
                x: 4,
                y: 10,
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif',
                    textShadow: '0 0 3px black'
                }
            }
        }]
    });
})
</script>
</html>
