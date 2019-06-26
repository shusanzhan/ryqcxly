<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx}/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/uniform.css" />
<link rel="stylesheet" href="${ctx}/css/select2.css" />		
<link rel="stylesheet" href="${ctx}/css/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/unicorn.grey.css" class="skin-color" />	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.table td {
		text-align: left;
	}
</style>
<title>${corporateCulture.title }</title>
</head>
<body >
	<br>
	<table class="TableTop" width="90%" style="margin: 0 auto;">
		<tbody>
			<tr>
				<td class="left"></td>
				<td class="center" style="text-align: center;font-size: 18px;font-weight: bold;">${corporateCulture.title }</td>
				<td class="right"></td>
			</tr>
		</tbody>
	</table>
	<div style="margin: 0 auto;margin-top: 20px;text-align: center;padding-right: 12px;width: 90%;">
		发布人：${corporateCulture.creator }&nbsp;&nbsp;&nbsp;&nbsp;发布时间：<fmt:formatDate value="${corporateCulture.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div style="margin:auto 0;margin: 12px;text-indent: 24px;font-size: 16px;width: 90%;margin: 0 auto;line-height: 200%;">
		${corporateCulture.content }
	</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
				<div class="widget-title">
					<h5>阅读记录</h5>
				</div>
				<div class="widget-content nopadding">
					<table class="table table-bordered data-table">
						<thead>
							<tr>
								<th style="width: 20px;">序号</th>
								<th style="width: 40px;">姓名</th>
								<th style="width: 80px;">时间</th>
								<th style="width: 80px;">地址</th>
								<th style="width: 80px;">会话Id</th>
								<th style="width: 80px;">省</th>
								<th style="width: 80px;">市</th>
								<th style="width: 80px;">区</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${empty(corporateCultureRecords) }">
								<tr>
									<td style="text-align: center;" colspan="2">
										无阅读记录
									</td>
								</tr>
						</c:if>
						<c:if test="${!empty(corporateCultureRecords) }">
							<c:forEach var="bussiReadPersonRecord" items="${corporateCultureRecords }" varStatus="i">
								<tr>
									<td  style="text-align: center;width: 20px;">
										${i.index+1 }
									</td>
									<td  style="text-align: center;width: 40px;">
										${bussiReadPersonRecord.weixinGzuserinfo.nickname}
									</td>
									<td style="text-align: center;">
										<fmt:formatDate value="${bussiReadPersonRecord.readTime }" pattern="yyyy-MM-dd"/> 
									</td>
									<td style="text-align: center;">
										${bussiReadPersonRecord.ipAddress }
									</td>
									<td style="text-align: center;">
										${bussiReadPersonRecord.sessionId }
									</td>							
									<td style="text-align: center;">
										${bussiReadPersonRecord.province }
									</td>							
									<td style="text-align: center;">
										${bussiReadPersonRecord.city }
									</td>							
									<td style="text-align: center;">
										${bussiReadPersonRecord.area }
									</td>							
								</tr>
							</c:forEach>
							</c:if>
						</tbody>
					</table>  
				</div>
			</div>
		</div>
	</div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="widget-box">
				<div class="widget-title">
					<h5>点赞记录</h5>
				</div>
				<div class="widget-content nopadding">
					<table class="table table-bordered data-table">
						<thead>
							<tr>
								<th style="width: 20px;">序号</th>
								<th style="width: 40px;">姓名</th>
								<th style="width: 80px;">时间</th>
								<th style="width: 80px;">地址</th>
								<th style="width: 80px;">会话Id</th>
								<th style="width: 80px;">省</th>
								<th style="width: 80px;">市</th>
								<th style="width: 80px;">区</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${empty(zcorporateCultureRecords) }">
								<tr>
									<td style="text-align: center;" colspan="2">
										无阅读记录
									</td>
								</tr>
						</c:if>
						<c:if test="${!empty(zcorporateCultureRecords) }">
							<c:forEach var="bussiReadPersonRecord" items="${zcorporateCultureRecords }" varStatus="i">
								<tr>
									<td  style="text-align: center;width: 20px;">
										${i.index+1 }
									</td>
									<td  style="text-align: center;width: 40px;">
										${bussiReadPersonRecord.weixinGzuserinfo.nickname}
									</td>
									<td style="text-align: center;">
										<fmt:formatDate value="${bussiReadPersonRecord.readTime }" pattern="yyyy-MM-dd"/> 
									</td>
									<td style="text-align: center;">
										${bussiReadPersonRecord.ipAddress }
									</td>
									<td style="text-align: center;">
										${bussiReadPersonRecord.sessionId }
									</td>							
									<td style="text-align: center;">
										${bussiReadPersonRecord.province }
									</td>							
									<td style="text-align: center;">
										${bussiReadPersonRecord.city }
									</td>							
									<td style="text-align: center;">
										${bussiReadPersonRecord.area }
									</td>							
								</tr>
							</c:forEach>
							</c:if>
						</tbody>
					</table>  
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
					<div class="row-fluid">
						<div class="widget-box">
						<div class="widget-title">
							<h5>分享记录</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th style="width: 20px;">序号</th>
										<th style="width: 40px;">姓名</th>
										<th style="width: 40px;">openId</th>
										<th style="width: 80px;">时间</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${empty(corporateCultureShareRecords) }">
										<tr>
											<td style="text-align: center;" colspan="2">
												无分享记录
											</td>
										</tr>
								</c:if>
								<c:if test="${!empty(corporateCultureShareRecords) }">
									<c:forEach var="corporateCultureShareRecord" items="${corporateCultureShareRecords }" varStatus="i">
										<tr>
											<td  style="text-align: center;width: 20px;">
												${i.index+1 }
											</td>
											<td  style="text-align: center;width: 40px;">
												${corporateCultureShareRecord.weixinGzuserinfo.nickname}
											</td>
											<td  style="text-align: center;width: 40px;">
												${corporateCultureShareRecord.weixinGzuserinfo.openid}
											</td>
											<td style="text-align: center;">
												<fmt:formatDate value="${corporateCultureShareRecord.shareTime }" pattern="yyyy-MM-dd"/> 
											</td>
										</tr>
									</c:forEach>
								</c:if>
								</tbody>
							</table>  
						</div>
					</div>
				</div>
		</div>
	<br>
	<div class="formButton" style="text-align: center;">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
	</div>
</body>
 <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.dataTables.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.tables.js"></script>
</html>