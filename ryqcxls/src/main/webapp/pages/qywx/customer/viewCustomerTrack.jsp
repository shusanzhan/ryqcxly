<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品明细</title>
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
</head>
<body>
<div class="orderContrac detail">
	<div class="title" align="left">
 			客户名称：${customer.name }
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table width="100%">
				<tr>
					<td colspan="2" class="formTableTdLeft">跟进日期：
						<fmt:formatDate value="${customerTrack.trackDate }" pattern="yyyy年MM月dd日" />
					</td>
				</tr>
				<tr>
					<td colspan="2" class="formTableTdLeft">跟进方法：
						<c:if test="${customer.lastResult==1 }">
							电话
						</c:if>
						<c:if test="${customer.lastResult==2 }">
							到店
						</c:if>
						<c:if test="${customer.lastResult==3 }">
							短信
						</c:if>
						<c:if test="${customer.lastResult==4 }">
							上门
						</c:if>
						<c:if test="${customer.lastResult==5 }">
							微信
						</c:if>
						<c:if test="${customer.lastResult==6 }">
							QQ
						</c:if>
					</td>
				</tr>
				<tr>
					<td  colspan="2" class="formTableTdLeft">意向级别：
						${customerTrack.beforeCustomerPhase.name}
					</td>
				</tr>
				<tr>
					<td colspan="2" class="formTableTdLeft">下次预约：
						<fmt:formatDate value="${customerTrack.nextReservationTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="formTableTdLeft">跟进内容：
						${customerTrack.trackContent }
					</td>
				</tr>
				<tr >
					<td colspan="2" class="formTableTdLeft">沟通结果：
						${customerTrack.result }
					</td>
				</tr>
				<tr >
					<td colspan="2" class="formTableTdLeft">反馈问题：
						${customerTrack.feedBackResult }
					</td>
				</tr>
				<tr >
					<td colspan="2" class="formTableTdLeft">对应措施：
						${customerTrack.dealMethod }
					</td>
				</tr>
				<tr >
					<td colspan="2" class="formTableTdLeft">经理意见：
						${customerTrack.showroomManagerSuggested } 
					</td>
				</tr>
		</table>
		</div>
	</div>
</div>
</body>

</html>
