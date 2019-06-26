 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>留言记录</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
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
	<a href="javascript:void(-1);" onclick="">留言明细</a>-
	<a href="javascript:void(-1);" onclick="">[${bussiLeaveMessageRecord.wechatUser}]明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<c:if test="${bussiLeaveMessageRecord.dealStatus==2}">
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void(-1)" onclick="window.history.go(-1)">返回</a>
   </div>
   	<div style="clear: both;"></div>
</div>
</c:if>
<br>
<c:if test="${bussiLeaveMessageRecord.dealStatus==1}">
<form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
		<input type="hidden" value="${bussiLeaveMessageRecord.dbid }" id=""bussiLeaveMessageRecordId"" name="bussiLeaveMessageRecordId">
		<div class="control-group">
			<label class="control-label">回复内容：</label>
			<div class="controls">
				<textarea class="input-xlarge" name="dealContent" id="dealContent" value="" checktype="string,1,200" tip="请输入回复内容,1,200个字符" style="width: 92%;height: 80px"></textarea>
			</div>
		</div>
		<div class="form-actions">
			<a href="javascript:void(-1)" class="btn btn-primary" onclick="$.utile.submitForm('frmId','${ctx}/bussiLeaveMessageRecord/saveDetail')">
				<i class="icon-ok-sign icon-white"></i>保存
			</a> <a class="btn btn-inverse" onclick="window.history.go(-1)">
			<i class="icon-hand-left icon-white"></i>返回</a>
		</div>
	</form>
</c:if>
<div id="content" style="margin-left:0px;">
	<div class="container-fluid">
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
					</table>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon">
								<i class="icon-signal"></i>
							</span>
							<h5>留言信息</h5>
						</div>
					</div>
				</div>
				<div class="widget-content">
					<table class="table table-bordered" style="width: 100%;">
						<tr>
							<td>
								昵称
							</td>
							<td>
								${bussiLeaveMessageRecord.wechatUser }
							</td>
							<td>
								留言信息
							</td>
							<td>
								<c:if test="${bussiLeaveMessageRecord.anonymousStatus==1}">
									<span style="color: red;">匿名</span>
								</c:if>
								<c:if test="${bussiLeaveMessageRecord.anonymousStatus==2}">
									${bussiLeaveMessageRecord.name}/${bussiLeaveMessageRecord.mobilePhone}
								</c:if>
							</td>
							<td>
								留言时间
							</td>
							<td>
								<fmt:formatDate value="${bussiLeaveMessageRecord.leaveMessageTime }" pattern="yyyy-MM-dd HH:mm:ss"/>,
							</td>
						</tr>
						<tr>
							<td>
								留言内容
							</td>
							<td colspan="5">
								${bussiLeaveMessageRecord.message }
							</td>
						</tr>
						<c:if test="${bussiLeaveMessageRecord.dealStatus==1 }">
							<tr>
								<td>处理状态</td>
								<td colspan="5">
									<span style="color: red;">待处理</span>
								</td>
							</tr>
						</c:if>
						<c:if test="${bussiLeaveMessageRecord.dealStatus==2 }">
						<tr>
							<td>
								回复人
							</td>
							<td>
								${bussiLeaveMessageRecord.dealPerson }
							</td>
							<td>
								回复时间
							</td>
							<td>
								<fmt:formatDate value="${bussiLeaveMessageRecord.dealTime }" pattern="yyyy-MM-dd HH:mm:ss"/>,
							</td>
							<td>
								回复内容
							</td>
							<td>
								${bussiLeaveMessageRecord.dealContent }
							</td>
						</tr>
						<tr>
							<td>
								回复阅读状态
							</td>
							<td>
								<c:if test="${bussiLeaveMessageRecord.readStatus==1 }">
									<span style="color: red">未读</span>
								</c:if>
								<c:if test="${bussiLeaveMessageRecord.readStatus==2 }">
									<span style="color: green">已读</span>
								</c:if>
							</td>
							<td>
								阅读时间
							</td>
							<td>
								<fmt:formatDate value="${bussiLeaveMessageRecord.readTime }" pattern="yyyy-MM-dd HH:mm:ss"/>,
							</td>
						</tr>
						</c:if>
					</table>
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
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
</html>
