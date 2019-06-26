 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>个人名片</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
</head>
<body style="">
<div class="location" style="height: 40px;line-height: 40px;">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">个人名片</a>-
	<a href="javascript:void(-1);" onclick="">[${bussiCard.name }]明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="window.history.go(-1)">返回</a>
   </div>
   	<div style="clear: both;"></div>
</div>
<div id="content" style="margin-left:0px;">
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-signal"></i>
						</span>
						<h5>[${bussiCard.name }]图片</h5>
					</div>
				</div>
			</div>
			<div class="widget-content">
				<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width:760px;padding-top: 40px;">
					<tr height="220" style="height: 160px;">
						<td style="text-align: center;">
							<img alt="" src="${bussiCard.picture }" style="width: 120px;height: 120px;">
							<br>
							头像
						</td>
						<td style="text-align: center;">
							<img alt="" src="${bussiCard.wechatQrCode }" style="width: 120px;height: 120px;">
							<br>
							微信关注二维码
						</td>
						<td style="text-align: center;">
							<img alt="" src="${bussiCard.bussiCardQrCode }" style="width: 120px;height: 120px;">
							<br>
							名片二维码
						</td>
						<td style="text-align: center;">
							<img alt="" src="${bussiCard.shareQrCode }" style="width: 120px;height: 120px;">
							<br>
							分享二维码
						</td>
					</tr>	
				</table>
			</div>
		</div>
<br>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon">
								<i class="icon-signal"></i>
							</span>
							<h5>名片档案</h5>
						</div>
					</div>
				</div>
				<div class="widget-content">
					<table class="table table-bordered" style="width: 100%;">
						<tr>
							<td>
								姓名
							</td>
							<td>
								${bussiCard.name }
							</td>
							<td>
								联系电话
							</td>
							<td>
								${bussiCard.mobilePhone }
							</td>
							<td>
								职位
							</td>
							<td>
								${bussiCard.position }
							</td>
						</tr>
						<tr>
							<td>
								邮箱
							</td>
							<td>
								${bussiCard.email }
							</td>
							<td>
								地址
							</td>
							<td>
								${bussiCard.address }
							</td>
							<td>
								人气
							</td>
							<td>
								${bussiCard.readNum }
							</td>
						</tr>
						<tr>
							<td>
								创建人
							</td>
							<td>
								${bussiCard.creator }
							</td>
							<td>
								创建时间
							</td>
							<td>
								<fmt:formatDate value="${bussiCard.createTime }" pattern="yyyy-MM-dd"/>
							</td>
							<td>
								最近修改时间
							</td>
							<td>
								<fmt:formatDate value="${bussiCard.modifyTime }" pattern="yyyy-MM-dd"/>
							</td>
						</tr>
						<tr>
							<td>
								阅读量
							</td>
							<td>
								${bussiCard.personNum }
							</td>
							<td>
								分享量
							</td>
							<td>
								${bussiCard.shareNum }
							</td>
							<td>
								一键拨号点击量
							</td>
							<td>
								${bussiCard.phoneNum }
							</td>
						</tr>
						<tr>
							<td>
								一键加我点击次数
							</td>
							<td>
								${bussiCard.addMeNum }
							</td>
							<td>
								一键导入名片次数
							</td>
							<td>
								${bussiCard.exportMeNum }
							</td>
							<td>
								一键导航次数
							</td>
							<td>
								${bussiCard.navNum }
							</td>
						</tr>
						<tr>
							<td>
								背景音乐
							</td>
							<td colspan="5">
								${bussiCard.backGroundMusic.name }
								<a href="javascript:void(-1)" class="aedit play" onclick="start(${bussiCard.backGroundMusic.dbid })" id='a${bussiCard.backGroundMusic.dbid }'>播放</a>
								<audio class='audio' id="myaudio${bussiCard.backGroundMusic.dbid }" src="${bussiCard.backGroundMusic.url}" controls="controls" loop="false" hidden="true" title='${bussiCard.backGroundMusic.name }'>${bussiCard.backGroundMusic.name }</audio>
							</td>
						</tr>
					</table>
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
								<c:if test="${empty(bussiSharePersonRecords) }">
										<tr>
											<td style="text-align: center;" colspan="2">
												无分享记录
											</td>
										</tr>
								</c:if>
								<c:if test="${!empty(bussiSharePersonRecords) }">
									<c:forEach var="bussiSharePersonRecord" items="${bussiSharePersonRecords }" varStatus="i">
										<tr>
											<td  style="text-align: center;width: 20px;">
												${i.index+1 }
											</td>
											<td  style="text-align: center;width: 40px;">
												${bussiSharePersonRecord.weixinGzuserinfo.nickname}
											</td>
											<td  style="text-align: center;width: 40px;">
												${bussiSharePersonRecord.weixinGzuserinfo.openid}
											</td>
											<td style="text-align: center;">
												<fmt:formatDate value="${bussiSharePersonRecord.shareTime }" pattern="yyyy-MM-dd"/> 
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
								<c:if test="${empty(bussiCardLikes) }">
										<tr>
											<td style="text-align: center;" colspan="2">
												无阅读记录
											</td>
										</tr>
								</c:if>
								<c:if test="${!empty(bussiCardLikes) }">
									<c:forEach var="bussiCardLike" items="${bussiCardLikes }" varStatus="i">
										<tr>
											<td  style="text-align: center;width: 20px;">
												${i.index+1 }
											</td>
											<td  style="text-align: center;width: 40px;">
												${bussiCardLike.weixinGzuserinfo.nickname}
											</td>
											<td style="text-align: center;">
												<fmt:formatDate value="${bussiCardLike.readTime }" pattern="yyyy-MM-dd"/> 
											</td>
											<td style="text-align: center;">
												${bussiCardLike.ipAddress }
											</td>
											<td style="text-align: center;">
												${bussiCardLike.sessionId }
											</td>							
											<td style="text-align: center;">
												${bussiCardLike.province }
											</td>							
											<td style="text-align: center;">
												${bussiCardLike.city }
											</td>							
											<td style="text-align: center;">
												${bussiCardLike.area }
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
								<c:if test="${empty(bussiReadPersonRecords) }">
										<tr>
											<td style="text-align: center;" colspan="2">
												无阅读记录
											</td>
										</tr>
								</c:if>
								<c:if test="${!empty(bussiReadPersonRecords) }">
									<c:forEach var="bussiReadPersonRecord" items="${bussiReadPersonRecords }" varStatus="i">
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
							<h5>点击记录</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th style="width: 20px;">序号</th>
										<th style="width: 40px;">类型</th>
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
								<c:if test="${empty(bussiClickPersonRecords) }">
										<tr>
											<td style="text-align: center;" colspan="2">
												无点击记录
											</td>
										</tr>
								</c:if>
								<c:if test="${!empty(bussiClickPersonRecords) }">
									<c:forEach var="bussiReadPersonRecord" items="${bussiClickPersonRecords }" varStatus="i">
										<tr>
											<td  style="text-align: center;width: 20px;">
												${i.index+1 }
											</td>
											<td  style="text-align: center;width: 40px;">
												<c:if test="${bussiReadPersonRecord.clickType==1 }">
													一键拨号								
												</c:if>
												<c:if test="${bussiReadPersonRecord.clickType==2 }">
													一键加我
												</c:if>
												<c:if test="${bussiReadPersonRecord.clickType==3 }">
													一键导入
												</c:if>
												<c:if test="${bussiReadPersonRecord.clickType==4 }">
													一键导航
												</c:if>
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
</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
 <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.dataTables.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.tables.js"></script>
<script type="text/javascript">
function start(dbid){
	var text=$("#a"+dbid).text();
	if(text.indexOf("播放")!=-1){
		$("#a"+dbid).text("停止");
		$('#myaudio'+dbid)[0].play();
	}else {
		$("#a"+dbid).text("播放");
		$('#myaudio'+dbid)[0].pause();
	}
}
</script>
</html>
