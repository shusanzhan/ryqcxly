<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
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
<script src="${ctx }/pages/pllm/spread/spread.js?now=${now}"></script>
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
</style>
<title>渠道管理</title>
</head>
<body class="bodycolor">

<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">渠道管理</a>
</div>
<div class="app">
	<div class="app-inner clearfix">
		<div class="app-init-container">
			<div class="page-with-sidebar">
					<div class="page-with-sidebar-content">
				        <div class="ui-box" style="position: relative;padding-top: 12px;">
				            <div class="clearfix">
				                <a href="javascript:;" class="js-nav-add-rule ui-btn ui-btn-success pull-left" onclick="editSpreadDetail()">新建二维码</a>
				                <div class="common-helps-entry pull-left">
				                	<form name="searchPageForm" id="searchPageForm" class="form-horizontal" action="${ctx}/spread/queryList" method="post">
						                <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
									    <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
					                	<table cellpadding="0" cellspacing="0" class="searchTable" border="1" >
								  			<tr>
								  				<td><label>渠道：</label></td>
								  				<td>
								  					<select id="spreadId" name="spreadId" class="text small" onchange="$('#searchPageForm')[0].submit()">
								  						<option value="-1">请选择...</option>
								  						<c:forEach items="${spreads }" var="spread2">
									  						<option value="${spread2.dbid }" ${param.spreadId==spread2.dbid?'selected="selected"':'' } >${spread2.name }</option>
								  						</c:forEach>
								  					</select>
												</td>
								  				<td><label>分组：</label></td>
								  				<td>
								  					<select id="spreadGroupId2" name="spreadGroupId" class="text small" onchange="$('#searchPageForm')[0].submit()">
								  						<option value="-1">请选择...</option>
								  						<c:forEach items="${spreadGroups }" var="spreadGruop">
									  						<option value="${spreadGruop.dbid }" ${param.spreadGroupId==spreadGruop.dbid?'selected="selected"':'' } >${spreadGruop.name }</option>
								  						</c:forEach>
								  					</select>
												</td>
								  				<td><label>名称：</label></td>
								  				<td>
								  					<input type="text" id="name" name="name" value="${param.name }" class="text small">
												</td>
								  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
								   			</tr>
								   		</table>
							   		</form>
				                </div>
					       </div>
				        </div>
				        
						
							    
						
        				<div class="app-init">
							<div class="app__content">
							    <div class="weixin-scan">
							       <div id="js-rule-container" class="rule-group-container">
							        <c:forEach var="spreadDetail" items="${page.result }" varStatus="i">
									      <div class="rule-group" id="rule-group${spreadDetail.dbid }">
										        <div class="rule-meta">
												    <h3>
												        <em class="rule-id">${page.totalCount-((page.currentPageNo-1)*page.pageSize+i.index)}）</em>
												        <span class="rule-name" id="rule-name${spreadDetail.dbid }">${spreadDetail.name } </span>
												        <div class="rule-opts">
											        			<div id="operatorIn${spreadDetail.dbid }" style="${spreadDetail.status==1?'display:;':'display: none;'}" >
													                <a href="javascript:;" class="js-edit-rule" onclick="editSpreadDetail(${spreadDetail.dbid})">编辑</a>
													                <span>-</span>
													                <a href="javascript:;" class="js-disable-rule" id="js-disable-rule${spreadDetail.dbid}" onclick="setAvailable(${spreadDetail.dbid},1)">失效</a>
												                </div>
											        			<div id="operatorNot${spreadDetail.dbid }" style="${spreadDetail.status==2?'display:;':'display: none;'}">
												                	<a href="javascript:;" class="js-disable-rule" id="js-disable-rule2${spreadDetail.dbid}" onclick="setAvailable(${spreadDetail.dbid},2)">启用</a>
												                </div>
												        </div>
												    </h3>
												</div>
											<div class="rule-body" id="rule-body${spreadDetail.dbid }" style="${spreadDetail.status==1?'display:;':'display: none;'}">
										   		 <div class="long-dashed"></div>
												    <div class="rule-keywords">
												        <div class="rule-inner">
												            <a href="javascript:;" class="pull-right opt js-download-qrcode" onclick="window.location.href='${ctx}/spread/downloand?dbid=${spreadDetail.dbid}'">下载二维码</a>
												            <h4>扫带参数二维码：</h4>
												            <h5 class="ta-c" >&nbsp;&nbsp;</h5>
												            <h5 class="ta-c" id="spreadDetailSpread${spreadDetail.dbid }">渠道：${spreadDetail.spread.name }</h5>
												            <h5 class="ta-c" id="spreadDetailspreadGroup${spreadDetail.dbid }">分组：${spreadDetail.spreadGroup.name }</h5>
												            
												            <div class="qrcode-container loading">
												                <img src="${spreadDetail.qrcode }">
												            </div>
												            <h4 class="dashed">或发送关键词：</h4>
												            <div class="keyword-container">
												                <div class="info"></div>
												                <div class="keyword-list"></div>
												            </div>
												             <div class="keyword-container">
												             	<c:set value="${spreadDetail.weixinKeyWordRole }" var="weixinKeyWordRole"></c:set>
												             	<c:if test="${fn:length(weixinKeyWordRole.weixinKeyWords)<=0 }" >
															     	<div class="info">
															     		还没有任何关键字!
															     	</div>
												             	</c:if>
												                <div class="keyword-list" id="keyword-list${spreadDetail.dbid }">
												                	<c:forEach items="${weixinKeyWordRole.weixinKeyWords}" var="weixinKeyWord">
														                <div class="keyword input-append" id="keyword${spreadDetail.dbid }${weixinKeyWord.dbid }" >
																		    <a href="javascript:;" class="close--circle" onclick="deleteKey(${weixinKeyWord.dbid },${spreadDetail.dbid })">×</a>
																		    <span class="value" onclick="editKey(${weixinKeyWord.dbid },${spreadDetail.dbid })">${weixinKeyWord.keyword }</span>
																		    <span class="add-on">
																		    	<c:if test="${weixinKeyWord.matchingType==1 }">
																		    		全匹配
																		    	</c:if>
																		    	<c:if test="${weixinKeyWord.matchingType==2 }">
																		    		模糊匹配
																		    	</c:if>
																			</span>
																		</div>
												                	</c:forEach>
																</div>
												            </div>
												            <hr class="dashed">
												            <div class="opt">
												                <a href="javascript:;" class="js-add-keyword" onclick="editKey('',${spreadDetail.dbid })" id="editKey${spreadDetail.dbid }">+ 添加关键词</a>
												            </div>
												        </div>
												    </div>
												    <div class="rule-replies">
												        <div class="rule-inner">
												            <h4>自动回复：
												                <span class="send-method">
												                    随机发送
												                </span>
												                   <!--  目前实现随机发送一条
												                   		<div class="reply-head-opts">
												                       	 	<a href="javascript:;" class="js-edit-send-method">编辑</a>
												                   		</div> 
												                   -->
												            </h4>
												            <div class="reply-container" id="reply-container${weixinKeyWordRole.dbid }" style="display: block;">
													            <div class="info" id=""  style="${fn:length(weixinKeyWordRole.weixinKeyAutoresponses)<=0?'':'display: none;'};">还没有任何回复！</div>
												                <ol class="reply-list" id="reply-list${weixinKeyWordRole.dbid }">
												                	<c:forEach var="weixinKeyAutoresponse" items="${weixinKeyWordRole.weixinKeyAutoresponses }">
												                		<li id="reply-list${weixinKeyWordRole.dbid }${weixinKeyAutoresponse.dbid}">
																			<div class="reply-cont">
																			    <div class="reply-summary">
																			    	<c:if test="${weixinKeyAutoresponse.msgtype=='text' }">
																				        <span class="label label-success">文本</span>
																				        ${weixinKeyAutoresponse.content }
																			    	</c:if>
																			    	<c:if test="${weixinKeyAutoresponse.msgtype=='news' }">
																				        <span class="label label-success">图文</span>
																				        <a href=""  class="new-window">${weixinKeyAutoresponse.templatename }</a>
																			    	</c:if>
																			    </div>
																			</div>
																			<div class="reply-opts">
																				<a class="js-edit-it" href="javascript:;" id="js-add-reply${weixinKeyWordRole.dbid }${weixinKeyAutoresponse.dbid}" onclick="editMessage(${weixinKeyWordRole.dbid },${weixinKeyAutoresponse.dbid})">编辑</a> - 
																				<a class="js-delete-it" href="javascript:;" onclick="deleteAutoResponse(${weixinKeyWordRole.dbid },${weixinKeyAutoresponse.dbid})">删除</a>
																			</div>
																		</li>
												                	</c:forEach>
												                </ol>
												            </div>
												            <hr class="dashed">
												            <div class="opt">
												                <a class="js-add-reply add-reply-menu" id="js-add-reply${weixinKeyWordRole.dbid }" href="javascript:;" onclick="message(${weixinKeyWordRole.dbid })">+ 添加一条回复</a>
												                <span class="disable-opt hide">最多十条回复</span>
												            </div>
												        </div>
												    </div>
												    <div class="rule-tags">
												        <div class="rule-inner">
												            <h4>给粉丝打标签：</h4>
												            <div class="tag-container" id="tag-container${spreadDetail.dbid}">
												                <div class="info"  style="${fn:length(spreadDetail.memTagNames)<=0?'':'display: none;'};">还没有任何标签！</div>
												                <div class="tag-list" id="tag-list${spreadDetail.dbid}">
												                	<c:if test="${!empty(spreadDetail.memTagNames) }">
													                	<c:set value="${fn:split(spreadDetail.memTagNames,',')}" var="tagNames"></c:set>
													                	<c:forEach var="tagName" items="${tagNames }">
													                		<div class="tag">${tagName }</div>
													                	</c:forEach>
												                	</c:if>
												                </div>
												            </div>
												            <hr class="dashed">
												            <div class="opt">
												                <a data-index="8" class="js-edit-tag" href="javascript:;" id="js-edit-tag${spreadDetail.dbid}" onclick="setSpreadDetailTags(${spreadDetail.dbid})">+ 添加标签组</a>
												            </div>
												        </div>
												    </div>
												    <div class="rule-level">
												        <h4>成为指定等级会员：</h4>
												        <hr class="dashed">
												        <div class="rule-inner">
												            <div class="level-container">
												            	<c:if test="${empty(spreadDetail.memberShipLevel) }">
													                <div class="info" id="level-containerinfo${spreadDetail.dbid }" >扫码不调整会员等级</div>
												            	</c:if>
												            	<c:if test="${!empty(spreadDetail.memberShipLevel) }">
													                <div class="info" id="level-containerinfo${spreadDetail.dbid }" style="display: none;">扫码不调整会员等级</div>
												            	</c:if>
												                <div class="level-list" id="level-list${spreadDetail.dbid }">
												                	<c:if test="${!empty(spreadDetail.memberShipLevel)}">
													                	<div class="level">
																		    ${spreadDetail.memberShipLevel.name}
																		    <a class="close-modal small hide js-delete-level" data-index="0" onclick="deleteMemberShipLevel(${spreadDetail.dbid})">×</a>
																		</div>
																	</c:if>
												                </div>
												            </div>
												            <hr class="dashed">
												            <div class="opt">
												                <a class="js-edit-level" href="javascript:;" id="js-edit-level${spreadDetail.dbid }" onclick="editMemberShipLevel(${spreadDetail.dbid })">+ 设置等级</a>
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
    </div>
	   <div id="fanye">
		<%@ include file="../../commons/commonPagination.jsp" %>
	</div>
   </div>
   </div>
</div>
<div id="app-help-container" class="show-help" >
	<div class="help-container-head">
	    <span>经纪人分类</span>
	    <i class="app-help-icon app-help-icon-close"></i>
	    <a href="javascript:void(-1)"  onclick="addSpread()" class="pull-right">
	         创建 <i class="app-help-icon app-help-icon-more"></i>
	     </a>
	</div>
	 <div class="help-container-body" id="spreadDiv">
	    <c:forEach var="spread" items="${spreads }" varStatus="i">
		    <div id="spreadDiv${spread.dbid }">
		        <div class="help-body-title">
		          <div style="float: left;" id="spread">
			           ${i.index+1 }、<span id="spread${spread.dbid }">${spread.name }</span>
		          </div>
		           <div class="rule-opts" style="float: right;padding-right: 12px;">
		                <a href="javascript:;" class="js-edit-rule" onclick="editSpread(${spread.dbid})">编辑</a>
		                <span>-</span>
		                <a href="javascript:;" class="js-edit-rule" onclick="window.location.href='${ctx}/agentSet/edit?spreadId=${spread.dbid}'">设置奖励</a>
		                <c:if test="${spread.status==2 }">
			                <span>-</span>
			                <a href="javascript:;" class="js-disable-rule" onclick="deleteSpread('${ctx}/spread/delete?dbids=${spread.dbid}','${spread.dbid}')">删除</a>
		                </c:if>
			        </div>
			        <div style="clear: both;"></div>
		        </div>
		        <div class="help-body-content" id="spreadDiv">
		        	<p>
			        	<span style="color: #999999;">引流：${spread.spreadNum }</span>&nbsp;&nbsp;
			        	<span style="color: #999999;">扫码：${spread.scanCodeNum }</span>
			        	<span style="color: #999999;">分组数：${fn:length(spread.spreadGroups) }</span>
			       </p>
					<p><a href="javascript:void(-1)" onclick="addSpreadGroup(${spread.dbid})" >创建分组</a></p>
		        	 <div id="spreadDetail${spread.dbid }" class="keyword-list">
		        	 	<c:forEach var="spreadGroup" items="${spread.spreadGroups }">
			        	 	<div class="keyword input-append" id="${spread.dbid }${spreadGroup.dbid}">
							    <a href="javascript:;" class="close--circle" onclick="deleteSpreadGroup('${ctx}/spread/deleteSpreadGroup?dbids=${spreadGroup.dbid}','${spread.dbid}${spreadGroup.dbid}')">×</a>
							   	<span style="color: #000;font-size: 12px;" onclick="eidtSpreadGroup(${spread.dbid },${spreadGroup.dbid})" id="${spread.dbid }${spreadGroup.dbid}Name">${spreadGroup.name }</span>
							</div>
							<!-- 编辑弹窗 -->
							<div class="frmContent" id="spreadGroupId${spread.dbid }${spreadGroup.dbid}" style="display: none;">
								<form action="" name="frmId2" id="frmId${spread.dbid }${spreadGroup.dbid}"  target="_self">
									<s:token></s:token>
									<input type="hidden" name="spreadGroup.dbid" id="spreadGroupDbid" value="${spreadGroup.dbid }">
									<input type="hidden" name="spreadId" id="spreadId" value="${spread.dbid }">
									<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
										<tr height="42">
											<td class="formTableTdLeft">名称:&nbsp;</td>
											<td ><input type="text" name="spreadGroup.name" id="spreadGroupName${spread.dbid }${spreadGroup.dbid}"
												value="${spreadGroup.name }" class="largex text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复"><span style="color: red;">*</span></td>
										</tr>
										<tr height="32">
											<td class="formTableTdLeft">备注:&nbsp;</td>
											<td>
												<textarea class="text textarea"  name="spreadGroup.note" id="spreadGroupNote" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">${spreadGroup.note }</textarea>
											</td>
										</tr>
									</table>
								</form>
							</div>
		        	 	</c:forEach>
					</div>
		        </div>
		        <div class="help-body-split-line"></div>
		    </div>
	    </c:forEach>
	</div> 
</div>
<div class="frmContent" id="spreadId2" style="display: none;">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="spread.dbid" id="dbid" value="${spread.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="spread.name" id="spreadName"
					value="${spread.name }" class="largex text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">政策链接:&nbsp;</td>
				<td ><input type="text" name="spread.policyStateMentUrl" id="policyStateMentUrl"
					value="${spread.policyStateMentUrl }" class="largex text" title="政策链接"	checkType="url" tip="政策链接"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea"  name="spread.note" id="spreadNote" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">${spread.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="frmContent" id="spreadId2" style="display: none;">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="spread.dbid" id="dbid" value="${spread.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="spread.name" id="spreadName"
					value="${spread.name }" class="largex text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea"  name="spread.note" id="spreadNote" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">${spread.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="frmContent" id="divSpreadGroupId" style="display: none;">
	<form action="" name="frmId2" id="frmId2"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="spreadGroup.dbid" id="spreadGroupDbid" >
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="spreadGroup.name" id="spreadGroupName"
					value="${spreadGroup.name }" class="largex text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea"  name="spreadGroup.note" id="spreadGroupNote" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">${spreadGroup.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="frmContent" id="spreadDetailFrm" style="display: none;">
	<form action="" name="spreadDetailForm" id="spreadDetailForm"  target="_self">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">渠道名称:&nbsp;</td>
				<td >
					<select id="spreadGroupId" name="spreadGroupId" class="largeX text" checkType="integer,1" tip="请选择分组">
						<option value="0">请选择...</option>
						<c:forEach var="spread" items="${spreads }">
							<option value="${spread.dbid }"  >${spread.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">分组:&nbsp;</td>
				<td >
					<select id="spreadGroupId" name="spreadGroupId" class="largeX text" checkType="integer,1" tip="请选择分组">
						<option value="0">请选择...</option>
						<c:forEach var="spreadGroup" items="${spreadGroups }">
							<option value="${spreadGroup.dbid }" ${spreadGroup.dbid==spreadDetail.spreadGroup.dbid?'selected="selected"':'' } >${spreadGroup.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="spreadDetail.name" id="name"
					value="${spreadDetail.name }" class="largeX text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="spreadDetail.note" id="note" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">${spreadDetail.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
<!-- 回复内容设置  页面-->
<form action="" id="submitFm" name="submitFm">
 		<input type="hidden" value="" name="weixinKeyAutoresponseDbid" id="weixinKeyAutoresponseDbid">
 		<input type="hidden" value="" name="weixinKeyWordRoleId" id="weixinKeyWordRoleId">
 		<input type="hidden" value="" name="msgdbid" id="msgdbid">
 		<input type="hidden" value="1" name="msgtype" id="msgtype">
 		<input type="hidden" value="" name="msgtext" id="msgtext">
 	</form>
<div class="popover-inner popover-reply" style="overflow: auto;display: none;" id="popover-inner">
    <div class="popover-content">
        <div class="form-horizontal">
            <div class="wb-sender">
                <div class="wb-sender__inner">
                    <div class="wb-sender__input">
						<div class="misc top clearfix">
						    <div class="content-actions clearfix">
						    	<div class="editor-module insert-emotion">
						            <a class="js-open-wx_emotion" data-action-type="emotion" href="javascript:;" onclick="choiceText()">输入文本</a>
						            <div class="emotion-wrapper">
						                <ul class="emotion-container clearfix"></ul>
						            </div>
						        </div>
						    	<div class="editor-module insert-emotion">
						            <a class="js-open-wx_emotion" data-action-type="emotion" href="javascript:;" onclick="selectText()">选择文本</a>
						            <div class="emotion-wrapper">
						                <ul class="emotion-container clearfix"></ul>
						            </div>
						        </div>
						        <div class="editor-module insert-articles">
						            <a class="js-open-articles" data-action-type="articles" href="javascript:;" onclick="selectNewsItem()">选择图文</a>
						            <div class="articles-wrapper"></div>
						        </div>
						    </div>
						</div>
						<div class="content-wrapper" style="display: block;min-height: 120px;">
						    <textarea class="js-txta" cols="50" rows="4" id="js-txta" onkeyup="countWordNum()"></textarea>
						    <div class="js-picture-container picture-container"></div>
						    <div class="complex-backdrop" >
						    	<div class="js-complex-content complex-content" id="js-complex-content" >
						    	</div>
						    </div>
						</div>
						<div class="misc clearfix">
						    <div class="content-actions clearfix">
						        <div class="word-counter pull-right">还能输入 <i>300</i> 个字</div>
						    </div>
						</div>
				</div>
                <div class="wb-sender__actions in-editor">
                    <button class="js-btn-confirm btn btn-primary" onclick="submitForm()">确定</button>
                </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

</script>
</body>
</html>