<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx }/widgets/artDialogMaster/css/ui-dialog.css">
<link href="${ctx }/css/weixin/yz.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/qrCode.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yzimage.css" type="text/css" rel="stylesheet"/>
<script src="${ctx }/widgets/artDialogMaster/lib/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js?1"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script src="${ctx }/widgets/artDialogMaster/dist/dialog-min.js"></script>
<script src="${ctx }/widgets/artDialogMaster/dist/dialog-plus-min.js"></script>
<script src="${ctx }/pages/sta/staAssessmentIndex/staAssessment.js?now=${now}"></script>
<style type="text/css">
	.clearfix{
		width: 99%;
	}
	.app-inner{
		margin: 0 0 0 1px;
	}
	a.new-window {
    	color: blue;
	}
	a {
	    color: #38f;
	    cursor: pointer;
	}
	input[type="text"] {
	    font-size: 12px;
	    margin-bottom: 0px;
	}
	select {
	    font-size: 12px;
	    margin-bottom: 0px;
	}
	.weixin-scan .rule-group::after {
		position: absolute;
		top: 35px;
		bottom: 10px;
		left: 76%;
		border-right: 0px solid #d7d7d7
	}
</style>
<title>渠道管理</title>
</head>
<body class="bodycolor">
<div class="location" style="border-bottom: 1px solid #ccc;height: 40px;line-height: 40px;">
	<img src="${ctx}/images/homeIcon.png"/ style="margin-bottom: 2px;"> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">主页</a>-
	<a href="javascript:void(-1);" onclick="">指标管理</a>
</div>
<div class="app">
	<div class="app-inner clearfix">
		<div class="app-init-container">
			<div class="page-with-sidebar">
					<div class="page-with-sidebar-content">
				        <div class="ui-box" style="position: relative;padding-top: 12px;">
				            <div class="clearfix">
				                <a href="javascript:;" class="js-nav-add-rule ui-btn ui-btn-success pull-left" onclick="edit('${ctx}/staAssessmentIndex/edit','添加指标')">添加</a>
				                <div class="common-helps-entry pull-left">
				                	<form name="searchPageForm" id="searchPageForm" class="form-horizontal" action="${ctx}/staAssessmentIndex/queryList" method="post">
						                <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
									    <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
					                	<table cellpadding="0" cellspacing="0" class="searchTable" border="1" >
								  			<tr>
								  				<td><label>名称：</label></td>
								  				<td>
								  					<input type="text" id="name" name="name" value="${param.name }" class="text small">
												</td>
								  				<td style="margin-left: 12px;padding-left: 12px;"><a href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="js-nav-add-rule ui-btn ui-btn-success pull-left">查询</a></td>
								   			</tr>
								   		</table>
							   		</form>
				                </div>
					       </div>
				        </div>
						
        				<div class="app-init">
							<div class="app__content" style="width: 100%;">
							    <div class="weixin-scan">
							       <div id="js-rule-container" class="rule-group-container">
							        <c:forEach var="staAssessmentIndex" items="${page.result }" varStatus="i">
									      <div class="rule-group" id="rule-group${staAssessmentIndex.dbid }">
										        <div class="rule-meta">
												    <h3>
												        <em class="rule-id"></em>
												        <span class="rule-name" id="rule-name${staAssessmentIndex.dbid }">${staAssessmentIndex.name }</span>
												        <div class="rule-opts">
											        			<div>
													                <a href="javascript:;" class="js-edit-rule" onclick="edit('${ctx}/staAssessmentIndex/edit?dbid=${staAssessmentIndex.dbid }','编辑指标',${staAssessmentIndex.dbid })">编辑</a>
														                <span>-</span>
														                <a href="javascript:;" class="js-disable-rule" id="js-disable-rule${staAssessmentIndex.dbid}" onclick="deleteSta(${staAssessmentIndex.dbid})">删除</a>
												                </div>
												        </div>
												    </h3>
												</div>
											<div class="rule-body" id >
										   		 <div class="long-dashed"></div>
												    <div class="rule-keywords">
												        <div class="rule-inner">
												            <h4>指标信息：</h4>
												            <h5 class="ta-c" >&nbsp;&nbsp;</h5>
												            <h5 class="ta-c" >名称：${staAssessmentIndex.name}</h5>
												            <h5 class="ta-c" >类型：${staAssessmentIndex.type==1?'系统':'自助添加' }</h5>
												            <h5 class="ta-c" >行业参考：${staAssessmentIndex.indexNum }</h5>
												            <h5 class="ta-c" >创建时间：<fmt:formatDate value="${staAssessmentIndex.createTime }" pattern="yyyy-MM-dd"/> </h5>
												            <h5 class="ta-c" >修改时间：<fmt:formatDate value="${staAssessmentIndex.modifyTime }" pattern="yyyy-MM-dd"/></h5>
												            <hr class="dashed">
												            <div class="keyword-container">
														     	<div class="info">
														     		<c:if test="${empty(staAssessmentIndex.note) }">
															     		无备注信息
														     		</c:if>
														     		${staAssessmentIndex.note }
														     	</div>
												        	</div>
												        </div>
												    </div>
												    <div class="rule-replies" style="width: 70%">
												        <div class="rule-inner">
												            <h4>指标等级：</h4>
												            <div class="reply-container" id="reply-container${staAssessmentIndex.dbid }" style="display: block;">
													            <div class="info" id="info${staAssessmentIndex.dbid }"  style="${fn:length(staAssessmentIndex.staAssessmentIndexLevels)<=0?'':'display: none;'};">未添加指标等级！</div>
												                <ol class="reply-list" id="reply-list${staAssessmentIndex.dbid }">
												                	<c:forEach items="${staAssessmentIndex.staAssessmentIndexLevels }" var="staAssessmentIndexLevel">
												                		<li id="reply-list${staAssessmentIndex.dbid }${staAssessmentIndexLevel.dbid}">
																			<div class="reply-cont">
																			    <div class="reply-summary">
																			     	<h5 class="ta-c" >名称：${staAssessmentIndexLevel.name }   区间值：${staAssessmentIndexLevel.beginNum }-${staAssessmentIndexLevel.endnum }  指标分：${staAssessmentIndexLevel.scoreNum }</h5>
																			        <div class="info">
																			            公司建议：${staAssessmentIndexLevel.entSugg }<br>
																			     		部门建议：${staAssessmentIndexLevel.depSugg }<br>
																			     		销售顾问建议:${staAssessmentIndexLevel.salSugg }<br>
																				    </div>
																			    </div>
																			</div>
																			<div class="reply-opts">
																				<a class="js-edit-it" href="javascript:;" id="js-add-reply${staAssessmentIndex.dbid }${staAssessmentIndexLevel.dbid}" onclick="editStaLevel(${staAssessmentIndex.dbid },${staAssessmentIndexLevel.dbid},'编辑')">编辑</a> - 
																				<a class="js-delete-it" href="javascript:;" id="js-delete-reply${staAssessmentIndex.dbid }${staAssessmentIndexLevel.dbid}" onclick="deleteStaLevel(${staAssessmentIndex.dbid },${staAssessmentIndexLevel.dbid})">删除</a>
																			</div>
																		</li>
																		</c:forEach>
												                </ol>
												            </div>
												            <hr class="dashed">
												            <div class="opt">
												            	<c:if test="${fn:length(staAssessmentIndex.staAssessmentIndexLevels)<3}" var="status">
												                	<a class="js-add-reply add-reply-menu" id="js-add-reply${staAssessmentIndex.dbid}" href="javascript:;" onclick="editStaLevel(${staAssessmentIndex.dbid })">添加指标等级</a>
													                <span class="disable-opt hide" id="disable-opt${staAssessmentIndex.dbid}">最多三个等级</span>
												            	</c:if>
												            	<c:if test="${fn:length(staAssessmentIndex.staAssessmentIndexLevels)>=3}">
												                	<a class="js-add-reply add-reply-menu hide" id="js-add-reply${staAssessmentIndex.dbid}" href="javascript:;" onclick="editStaLevel(${staAssessmentIndex.dbid })">添加指标等级</a>
													                <span class="disable-opt" id="disable-opt${staAssessmentIndex.dbid}">最多三个等级</span>
												            	</c:if>
												            </div>
												        </div>
												    </div>
											</div>
									</div>
							</c:forEach>
						</div>
		 		</div>
		</div>
		</div>
    </div>	
	   <div id="fanye">
		<%@ include file="../../commons/commonPagination.jsp" %>
	</div>
    </div>
   </div>
   </div>
</div>
<script type="text/javascript">
</script>
</body>
</html>