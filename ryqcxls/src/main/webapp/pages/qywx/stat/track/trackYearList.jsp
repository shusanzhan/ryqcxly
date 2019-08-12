<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>客户回访（年）统计</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
	.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
.form-inline tr{
	height: 45px;
}
#trTd{
	vertical-align: middle;
}
.table td{
	text-align: center;
   
}
#totalTr {
    font-weight: bold;
    background-color: #009688;
    color: white;
}
.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td {
    padding: 8px 0px;
    line-height: 1.42857143;
    vertical-align: center;
    border-top: 1px solid #ddd;
    font-size: 10px;
}
</style>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">客户回访（年）统计</span>
  	<a class="go_home" href="${ctx }/qywxStat/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<div id="detail_nav">
     <div class="detail_nav_inner">
         <ul class="clearfix padding10">
           <li class="detail_tap pull_left " id="imgs_tap" onclick="window.location.href='${ctx}/qywxTrack/queryTrackList'">月统计</li>
           <li class="detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxTrack/queryTrackYearList'">年统计</li>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		回访客户统计
	</h5>
</div>
<p style="color: red;"><span style="color: red;font-weight: bold;">需回访</span>=当天需要回访客户数量汇总</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">已回访</span>=当天需要回访客户已经回访汇总（包含其他时间进行的回访）</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">回访率</span>=已回访/需回访*100</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">回访总量</span>=当天回访客户总量（销售顾问回访+（客户订单+客户流失）关闭回访量</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">销售回访</span>=当天销售顾问正常回访总量</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">超时量</span>=回访总量总包含的超时数据总量</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">超时率</span>=超时量/回访总量*100</p>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 100px">日期</td>
					<td style="width: 60px">需回访</td>
					<td style="width: 60px">已回访</td>
					<td style="width: 60px">回访率</td>
					<td style="width: 80px">回访总量</td>
					<td style="width: 80px">销售回访</td>
					<td style="width: 60px">超时量</td>
					<td style="width: 60px">超时率</td>
				</tr>
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
						<fmt:formatNumber value="${trackAll.trackPer }" pattern="#0.00"></fmt:formatNumber>
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
						<fmt:formatNumber value="${trackAll.trackOverPer }" pattern="#0.00"></fmt:formatNumber>
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
						<fmt:formatNumber value="${track.trackPer }" pattern="#0.00"></fmt:formatNumber>
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
						<fmt:formatNumber value="${track.trackOverPer }" pattern="#0.00"></fmt:formatNumber>
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
						<fmt:formatNumber value="${trackAll.trackPer }" pattern="#0.00"></fmt:formatNumber>
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
						<fmt:formatNumber value="${trackAll.trackOverPer }" pattern="#0.00"></fmt:formatNumber>
					</td>
				</tr>
			</c:if>
		</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问回访统计
	</h5>
</div>
<div class="row-fluid">
<p style="color: red;"><span style="color: red;font-weight: bold;">说明</span>：【销售顾问回访统计】为查询时间段内销售顾问回访数据</p>
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 60px">需回访</td>
				<td style="width: 60px">已回访</td>
				<td style="width: 60px">回访率</td>
				<td style="width: 80px">回访总量</td>
				<td style="width: 80px">销售回访</td>
				<td style="width: 60px">超时量</td>
				<td style="width: 60px">超时率</td>
			</tr>
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
					<fmt:formatNumber value="${trackUser.trackPer }" pattern="#0.00"></fmt:formatNumber>
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
					<fmt:formatNumber value="${trackUser.trackOverPer }" pattern="#0.00"></fmt:formatNumber>
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
					<fmt:formatNumber value="${trackUserAll.trackPer }" pattern="#0.00"></fmt:formatNumber>
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
					<fmt:formatNumber value="${trackUserAll.trackOverPer }" pattern="#0.00"></fmt:formatNumber>
				</td>
		</tr>
	</table>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问回访汇总统计
	</h5>
</div>
<div class="row-fluid">
<p style="color: red;"><span style="color: red;font-weight: bold;">说明</span>：【销售顾问回访汇总统计】查询在职销售顾问总潜客、总回访量汇总统计,不涉及时间区间</p>
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">潜客总量</td>
				<td style="width: 80px">回访总量</td>
				<td style="width: 80px">平均回访次数</td>
			</tr>
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
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问成交客户回访汇总统计
	</h5>
</div>
<div class="row-fluid">     
<p style="color: red;"><span style="color: red;font-weight: bold;">说明</span>：【销售顾问成交客户回访汇总统计】查询在职销售顾问总成交客户、总成交客户回访量汇总统计，不涉及时间区间</p>           
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">成交客户</td>
				<td style="width: 80px">回访总量</td>
				<td style="width: 80px">平均回访次数</td>
			</tr>
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
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问流失客户回访汇总统计
	</h5>
</div>
<p style="color: red;"><span style="color: red;font-weight: bold;">说明</span>：【销售顾问流失客户回访汇总统计】查询在职销售顾问总流失客户、总流失客户回访量汇总统计，不涉及时间区间</p>
<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">流失客户</td>
				<td style="width: 80px">回访总量</td>
				<td style="width: 80px">平均回访次数</td>
			</tr>
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
	</tbody>
</table>
<br>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx}/qywxTrack/queryTrackYearList" name="searchPageForm" id="searchPageForm" method="post">
      	 <table>
  			<c:if test="${fn:length(enterprises)>1 }">
	  			<tr>
		  				<td><label>分公司：</label></td>
		  				<td colspan="4" >
		  					<select class="form-control" id="enterpriseId" name="enterpriseId"  onchange="$('#searchPageForm')[0].submit()">
		  						<option value="-1">请选择...</option>
		  						<c:forEach var="enter" items="${enterprises }">
			  						<option value="${enter.dbid }" ${enter.dbid==enterprise.dbid?'selected="selected"':'' }>${enter.name }</option>
		  						</c:forEach>
							</select>
		  				</td>
	  			</tr>
  			</c:if>
  			<tr>
  				<td><label>试乘试驾：</label></td>
  				<td>
  					<select class="form-control" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
						<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>到店状态：</label></td>
  				<td>
  					<select class="form-control" id="comeShopStatus" name="comeShopStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.comeShopStatus==1?'selected="selected"':''} >未到店</option>
						<option value="2" ${param.comeShopStatus==2?'selected="selected"':''}>首次到店</option>
						<option value="3" ${param.comeShopStatus==3?'selected="selected"':''}>二次到店</option>
					</select>
				</td>
			</tr>
  			<tr>
  				<td><label>客户类型：</label></td>
  				<td colspan="" >
  					<select class="form-control" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<c:forEach var="customerType" items="${customerTypes }">
	  						<option value="${customerType.dbid }" ${customerType.dbid==param.type?'selected="selected"':'' }>${customerType.name }</option>
  						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
				<td><label>登记时间：</label></td>
  				<td>
  					<input class="form-control" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${beginDate }" >
  				</td>
  			</tr>
  			<tr>
  				<td><label>~</label></td>
  				<td>
  					<input class="form-control" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${endDate }">
  				</td>
  			</tr>
  			<tr>
  				<td colspan="2">
  					<a href="javascript:;" onclick="setSerachDate(1)">最近3个月</a>|<a href="javascript:;" onclick="setSerachDate(2)">今年</a>|<a href="javascript:;" onclick="setSerachDate(3)">去年</a>
  				</td>
   			</tr>
   			<tr>
   				<td colspan="2">
   					<p id="searchTip" style="c">查询时间不能超过12个月</p>
   				</td>
   			</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="if(validateSearch()){$('#searchPageForm')[0].submit()}">查询</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/jsdateUtile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
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
function ajaxCarCount(){
	var params=$("#searchPageForm").serialize();
	var customerInfromSetDbid=$("#customerInfromSetDbid").val();
	$.post("${ctx}/qywxStatCustomerInvitation/ajaxCarCount?customerInfromSetDbid="+customerInfromSetDbid+"&dateType=2",params,function(data){
		if(data=="error"){
			alert("查询出错！");
		}else{
			var obj=data.split("|");
			$("#carCountId").text("");
			$("#carCountId").append(obj[0]);
			chart3(obj[1]);
		}
	}) 
}
</script>
</html>