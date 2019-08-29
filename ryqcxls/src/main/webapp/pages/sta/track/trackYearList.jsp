<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>客户回访统计年统计</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="Keywords" content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<link rel="stylesheet" href="${ctx }/css/bootstrap/bootstrap.min.css">
<link href="${ctx }/css/common.css?" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.staltalbe thead td{
		border-top: 1px solid #999;
		font-weight: bold;
	}
	.staltalbe{
		width: 98%;line-height: 28px;border: 0px;margin: 0 auto;margin-top: 10px;font-family: '微软雅黑'
	}
	.staltalbe td{
		border-bottom: 1px solid #999;border-right: 1px solid #999;text-align: center;
	}
	.staltalbe td:FIRST-CHILD{ 
		border-left: 1px solid #999;
	}
	.staltalbe tr:last-child td{
	}
	.staltalbe .label{
		text-align: center;font-weight: bold;
	}
	.layui-elem-field {
	    margin-bottom: 10px;
	    padding: 0;
	    border-width: 1px;
	    border-style: solid;
	}
	.layui-field-title {
	    margin: 10px 0 20px;
	    border-width: 1px 0 0;
	}
	.layui-elem-field legend {
	    margin-left: 20px;
	    padding: 0 10px;
	    font-size: 20px;
	    font-weight: 300;
	 	width: auto;   
	 }
	  .buttonSerach{
	  	background-color: #3eb94e;height: 40px;line-height: 40px;padding: 0px 12px;color: white;text-align: center;cursor: pointer;width: 120px;margin: 0 a
	  }
	  .buttonSerach:HOVER {
	  	background-color: #3eb94e
		}
	   .searchTable a{
	   		color: #2b7dbc;
	   		padding: 0px 8px;
	   } 
	  .searchTable tr{
	  	height: 40px;
	  }   
}
</style>
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">>客户回访统计</a>-
	<a href="javascript:void(-1);" onclick="">年统计</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)"  onclick="window.location.href='${ctx}/statTrack/queryTrackList'" style="color: #2b7dbc;">客户回访月统计</a>
		<span style="color:#2b7dbc ">|</span> 
		<a href="javascript:void(-1)"  onclick="window.history.go(-1)" style="color: #2b7dbc;">返回</a> 
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/statTrack/queryTrackYearList" method="post" >
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<c:if test="${fn:length(enterprises)>1 }">
	  				<tr>
		  				<td ><label>分公司：</label></td>
		  				<td colspan="5">
		  					<select class="text small" id="enterpriseId" name="enterpriseId"  onchange="$('#searchPageForm')[0].submit()">
		  						<option value="-1">请选择...</option>
		  						<c:forEach var="enter" items="${enterprises }">
			  						<option value="${enter.dbid }" ${enter.dbid==enterprise.dbid?'selected="selected"':'' }>${enter.name }</option>
		  						</c:forEach>
							</select>
		  				</td>
		  			</tr>
  				</c:if>
  				<tr>
  					<td><label>客户类型：</label></td>
	  				<td >
	  					<select class="text small" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
	  						<option value="-1">请选择...</option>
	  						<c:forEach var="customerType" items="${customerTypes }">
		  						<option value="${customerType.dbid }" ${customerType.dbid==param.type?'selected="selected"':'' }>${customerType.name }</option>
	  						</c:forEach>
						</select>
	  				</td>
	  				<td><label>试乘试驾：</label></td>
	  				<td>
	  					<select class="small text" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
							<option value="">请选择...</option>
							<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
							<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
						</select>
	  				</td>
	  				<td><label>到店状态：</label></td>
	  				<td>
	  					<select class="small text" id="comeShopStatus" name="comeShopStatus" onchange="$('#searchPageForm')[0].submit()" >
							<option value="-1">请选择...</option>
							<option value="1" ${param.comeShopStatus==1?'selected="selected"':''} >未到店</option>
							<option value="2" ${param.comeShopStatus==2?'selected="selected"':''}>首次到店</option>
							<option value="3" ${param.comeShopStatus==3?'selected="selected"':''}>二次到店</option>
						</select>
					</td>
  			</tr>
  			<tr>
				<td><label>登记时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${beginDate }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${endDate }">
  				</td>
  				<td colspan="2">
  					<a href="javascript:;" onclick="setSerachDate(1)">最近3个月</a>|<a href="javascript:;" onclick="setSerachDate(2)">今年</a>|<a href="javascript:;" onclick="setSerachDate(3)">去年</a>
  				</td>
   			</tr>
   			<tr>
   				<td colspan="1">
   				</td>
   				<td colspan="5">
   					<p id="searchTip" style="c">查询时间不能超过12月</p>
   				</td>
   			</tr>
   			<tr>
   				<td colspan="5" style="text-align: center;"><div  onclick="if(validateSearch()){$('#searchPageForm')[0].submit()}"  class="buttonSerach">查询</div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>回访客户统计</legend>
</fieldset>
<div class="tab-content" >
	<div class="tab-pane active" id="baseInfo" >
		<p style="color: red;"><span style="color: red;font-weight: bold;">需回访</span>=当天需要回访客户数量汇总</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">已回访</span>=当天需要回访客户已经回访汇总（包含其他时间进行的回访）</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">回访率</span>=已回访/需回访*100</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">回访总量</span>=当天回访客户总量（销售顾问回访+（客户订单+客户流失）关闭回访量</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">销售回访</span>=当天销售顾问正常回访总量</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">超时量</span>=回访总量总包含的超时数据总量</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">超时率</span>=超时量/回访总量*100</p>
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 80px">日期</td>
					<td style="width: 80px">需回访</td>
					<td style="width: 80px">已回访</td>
					<td style="width: 80px">回访率</td>
					<td style="width: 80px">回访总量</td>
					<td style="width: 80px">销售回访</td>
					<td style="width: 80px">超时量</td>
					<td style="width: 80px">超时率</td>
				</tr>
			</thead>
			<c:if test="${fn:length(tracks)>15 }" var="lengthStatus"></c:if>
			<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>
						${trackAll.waitNum }
					</td>
					<td>
						${trackAll.waitTrackEdNum }
					</td>
					<td>
						<fmt:formatNumber value="${trackAll.trackPer }" pattern="#0.00"></fmt:formatNumber>%
					</td>
					<td>
						${trackAll.trackAllNum }
					</td>
					<td>
						${trackAll.trackNum }
					</td>
					<td>
						${trackAll.trackOverTimeNum }
					</td>
					<td>
						<fmt:formatNumber value="${trackAll.trackOverPer }" pattern="#0.00"></fmt:formatNumber>%
					</td>
				</tr>
			</c:if>
			<c:forEach items="${tracks }" var="track" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						<fmt:formatDate value="${track.createDate}" pattern="yyyy-MM"/> 
					</td>
					<td>
						${track.waitNum }
					</td>
					<td>
						${track.waitTrackEdNum }
					</td>
					<td>
						<fmt:formatNumber value="${track.trackPer }" pattern="#0.00"></fmt:formatNumber>%
					</td>
					<td>
						${track.trackAllNum }
					</td>
					<td>
						${track.trackNum }
					</td>
					<td>
						${track.trackOverTimeNum }
					</td>
					<td>
						<fmt:formatNumber value="${track.trackOverPer }" pattern="#0.00"></fmt:formatNumber>%
					</td>
				</tr>
			</c:forEach>
			<c:if test="${lengthStatus==false }">
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>
						${trackAll.waitNum }
					</td>
					<td>
						${trackAll.waitTrackEdNum }
					</td>
					<td>
						<fmt:formatNumber value="${trackAll.trackPer }" pattern="#0.00"></fmt:formatNumber>%
					</td>
					<td>
						${trackAll.trackAllNum }
					</td>
					<td>
						${trackAll.trackNum }
					</td>
					<td>
						${trackAll.trackOverTimeNum }
					</td>
					<td>
						<fmt:formatNumber value="${trackAll.trackOverPer }" pattern="#0.00"></fmt:formatNumber>%
					</td>
				</tr>
			</c:if>
		</table>
</div>
</div>
<h3>销售顾问回访统计</h3>
<p style="color: red;"><span style="color: red;font-weight: bold;">说明</span>：【销售顾问回访统计】为查询时间段内销售顾问回访数据</p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">需回访</td>
				<td style="width: 80px">已回访</td>
				<td style="width: 80px">回访率</td>
				<td style="width: 80px">回访总量</td>
				<td style="width: 80px">销售回访</td>
				<td style="width: 80px">超时量</td>
				<td style="width: 80px">超时率</td>
			</tr>
		</thead>
		<c:forEach items="${trackUsers }" var="trackUser" varStatus="i">
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${trackUser.userName }
				</td>
				<td>
					${trackUser.waitNum }
				</td>
				<td>
					${trackUser.waitTrackEdNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackUser.trackPer }" pattern="#0.00"></fmt:formatNumber>%
				</td>
				<td>
					${trackUser.trackAllNum }
				</td>
				<td>
					${trackUser.trackNum }
				</td>
				<td>
					${trackUser.trackOverTimeNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackUser.trackOverPer }" pattern="#0.00"></fmt:formatNumber>%
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${trackUserAll.waitNum }
				</td>
				<td>
					${trackUserAll.waitTrackEdNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackUserAll.trackPer }" pattern="#0.00"></fmt:formatNumber>%
				</td>
				<td>
					${trackUserAll.trackAllNum }
				</td>
				<td>
					${trackUserAll.trackNum }
				</td>
				<td>
					${trackUserAll.trackOverTimeNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackUserAll.trackOverPer }" pattern="#0.00"></fmt:formatNumber>%
				</td>
		</tr>
	</table>
<h3>销售顾问回访汇总统计</h3>
<p style="color: red;"><span style="color: red;font-weight: bold;">说明</span>：【销售顾问回访汇总统计】查询在职销售顾问总潜客、总回访量汇总统计,不涉及时间区间</p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">潜客总量</td>
				<td style="width: 80px">回访总量</td>
				<td style="width: 80px">平均回访次数</td>
			</tr>
		</thead>
		<c:forEach items="${trackStatTotals }" var="trackStat" varStatus="i">
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${trackStat.realName }
				</td>
				<td>
					${trackStat.createNum }
				</td>
				<td>
					${trackStat.trackNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackStat.trackAvgNum }" pattern="#0.00"></fmt:formatNumber>
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${trackStatTotal.createNum }
				</td>
				<td>
					${trackStatTotal.trackNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackStatTotal.trackAvgNum }" pattern="#0.00"></fmt:formatNumber>
				</td>
		</tr>
	</table>
<h3>销售顾问成交客户回访汇总统计</h3>
<p style="color: red;"><span style="color: red;font-weight: bold;">说明</span>：【销售顾问成交客户回访汇总统计】查询在职销售顾问总成交客户、总成交客户回访量汇总统计，不涉及时间区间</p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">成交客户</td>
				<td style="width: 80px">回访总量</td>
				<td style="width: 80px">平均回访次数</td>
			</tr>
		</thead>
		<c:forEach items="${trackUserStatSuccessTotalLists }" var="trackStat" varStatus="i">
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${trackStat.realName }
				</td>
				<td>
					${trackStat.createNum }
				</td>
				<td>
					${trackStat.trackNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackStat.trackAvgNum }" pattern="#0.00"></fmt:formatNumber>
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${trackStatSuccessTotal.createNum }
				</td>
				<td>
					${trackStatSuccessTotal.trackNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackStatSuccessTotal.trackAvgNum }" pattern="#0.00"></fmt:formatNumber>
				</td>
		</tr>
	</table>
<h3>销售顾问流失客户回访汇总统计</h3>
<p style="color: red;"><span style="color: red;font-weight: bold;">说明</span>：【销售顾问流失客户回访汇总统计】查询在职销售顾问总流失客户、总流失客户回访量汇总统计，不涉及时间区间</p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">流失客户</td>
				<td style="width: 80px">回访总量</td>
				<td style="width: 80px">平均回访次数</td>
			</tr>
		</thead>
		<c:forEach items="${trackUserStatFlowTotalLists }" var="trackStat" varStatus="i">
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${trackStat.realName }
				</td>
				<td>
					${trackStat.createNum }
				</td>
				<td>
					${trackStat.trackNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackStat.trackAvgNum }" pattern="#0.00"></fmt:formatNumber>
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${trackStatFlowTotal.createNum }
				</td>
				<td>
					${trackStatFlowTotal.trackNum }
				</td>
				<td>
					<fmt:formatNumber value="${trackStatFlowTotal.trackAvgNum }" pattern="#0.00"></fmt:formatNumber>
				</td>
		</tr>
	</table>
	<div class="hightChat">
		<div id="pieFlowUserData" style="width: 98%;"></div>
	</div>
<br>
<br>
<br>
<script type='text/javascript'  src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script type='text/javascript'  src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/jsdateUtile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script type="text/javascript">
function setSerachDate(type){
	var today=new Date();
	if(type==1){
		var year=today.getFullYear();
	    var month=today.getMonth();
	    var temp=new Date(year,month-2,1)
		var tempDate2=temp.format("yyyy-MM");
		$("#startTime").val(tempDate2);
		today=today.format("yyyy-MM");
		$("#endTime").val(today);
	}
	if(type==2){
		var year=today.getFullYear();
	    var month=today.getMonth();
	    var temp=new Date(year,0,1)
	    temp=temp.format("yyyy-MM");
		$("#startTime").val(temp);
		today=today.format("yyyy-MM");
		$("#endTime").val(today);
	}
	if(type==3){
		var year=today.getFullYear();
	    var month=today.getMonth();
	    var temp=new Date(year-1,0,1)
	    temp=temp.format("yyyy-MM");
		$("#startTime").val(temp);
		var tempEnd=new Date(year-1,11,1)
		tempEnd=tempEnd.format("yyyy-MM");
		$("#endTime").val(tempEnd);
	}
}
function convertDateFromString(dateString) {
	if (dateString) { 
		var date = new Date(dateString.replace(/-/,"/")) 
		return date;
	}
}
function validateSearch(){
	var startTime=$("#startTime").val();
	var endTime=$("#endTime").val();
	var endDate=convertDateFromString(endTime);
	var startDate=convertDateFromString(startTime);
	var startYear=startDate.getFullYear();
    var startMonth=startDate.getMonth();
	var endYear=endDate.getFullYear();
    var endMonth=endDate.getMonth();
    var totalMonh=0;
    if(endYear>startYear){
    	var month=(endYear-startYear)*11
    	totalMonh=month+(11-startMonth+endMonth);
    }
    else if(endYear==startYear){
    	totalMonh=endMonth-startMonth;
    }
    if(totalMonh>12){
		$("#searchTip").css("color","red");
		return false;
	}else{
		$("#searchTip").css("color","balck");
		return true;
	}
}
</script>
</body>

</html>
