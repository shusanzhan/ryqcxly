<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!doctype html>
<html  lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta charset="UTF-8">
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
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css" type="text/css" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <title>我的积分</title>
</head>
<body>
<div class="title">
    <a class="btn-back" onclick="window.history.go(-1)" href="javascript:void(0)"><i class="icon icon-2-1"></i></a>
    <h3>我的积分</h3>
</div>
<br>
<br>
<br>
	<div class="body">
		<section class="p_10">
		<c:if test="${empty(pointRecords)||fn:length(pointRecords)<=0 }" var="status">
			<div class="noAddress">您还未有积分记录！</div>
		</c:if>
		<c:if test="${status==false }">
			<div style="height: 50px;margin-top: 12px;">
				<table style="line-height: 3em;overflow: hidden;width:100%;background:white; margin-bottom:0.1em">
				    <tbody><tr style="width:100%;">
				        <td style="width:4%"></td>
				        <td style="width:30%;text-align:center;line-height:150%;">
				            <table style="width: 100%">
				                <tbody><tr>
				                    <td id="yuer" style="color:#eb6877;padding-top:5px;font-size:16px;">${member.totalPoint }</td>
				                </tr>
				                <tr>
				                    <td style="color:gray;font-size:12px;">总积分</td>
				                </tr>
				            </tbody></table>
				        </td>
				        <td style="width:1%;text-align:center;"><div style="height:40px;margin-top:10px;border-left:solid 1px #e6e6e6;"></div></td>
				        <td style="width:30%;text-align:center;line-height:150%;">
				            <table style="width: 100%">
				                <tbody><tr>
				                    <td id="baozhengjin" style="color:#eb6877;padding-top:5px;font-size:16px;">${member.consumpiontPoint }</td>
				                </tr>
				                <tr>
				                    <td style="color:gray;font-size:12px;">已消费积分</td>
				                </tr>
				            </tbody></table>
				        </td>
				        <td style="width:1%;text-align:center;"><div style="height:40px;margin-top:10px;border-left:solid 1px #e6e6e6;"></div></td>
				        <td style="width:30%;text-align:center;line-height:150%;">
				            <table onclick="" style="width: 100%">
				                <tbody><tr>
				                    <td id="quan" style="color:#eb6877;padding-top:5px;font-size:16px;">${member.overagePiont }</td>
				                </tr>
				                <tr>
				                    <td style="color:gray;font-size:12px;">剩余积分</td>
				                </tr>
				            </tbody></table>          
				        </td>
				        <td style="width:4%"></td>
				    </tr>
				</tbody>
				</table>
			</div>
			<br>
			<table class="table_record" style="margin-top: 2px;" cellpadding="0" cellspacing="0">
				<thead>
				<tr>
					<td style="width:50%;text-align: center;">积分详情 </td>
					<td style="width:30%;text-align: center;">日期 </td>
					<td style="width:20%;text-align: center;">积分</td>
				</tr>
				</thead>
				<tbody>
					<c:forEach var="pointRecord" items="${pointRecords }">
						<tr>
							<td>${pointRecord.pointFrom }  </td>
							<td align="center">
								<fmt:formatDate value="${pointRecord.createTime }" pattern="yyyy-MM-dd"/> 
							</td>
							<td align="center">
								<span style="color: #f00;font-size: 14px;">${pointRecord.num }</span>
							 </td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		</section>
	</div>
</body>
</html>