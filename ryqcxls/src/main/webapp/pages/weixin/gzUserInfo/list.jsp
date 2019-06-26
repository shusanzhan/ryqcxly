<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yz.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/qrCode.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yzbase.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/artDialogMaster/css/ui-dialog.css">
<script src="${ctx }/widgets/artDialogMaster/lib/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack4.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script src="${ctx }/widgets/artDialogMaster/dist/dialog-min.js"></script>
<script src="${ctx }/widgets/artDialogMaster/dist/dialog-plus-min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/select2/js/select2.min.js"></script>
<script src="${ctx }/pages/weixin/gzUserInfo/gzUserInfo.js?date=${now}"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
	.clearfix{
		width: 99%;
	}
	.app-inner{
		margin: 0 0 0 1px;
	}
</style>
<title>粉丝管理</title>
</head>
<body class="bodycolor">

<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">粉丝管理</a>
</div>
<div class="app">
	<div class="app-inner clearfix">
		<div class="app-init-container">
			<div id="js-app-content" class="app__content app-fans-search fans-search-basic" style="width: 100%">
		        <div class="js-app-inner hide" style="display: block;width: 100%;">
		            <div id="js-filter" class="filter-wrap">
		                <table>
		                    <tbody>
		                        <tr>
		                            <th>关键词：</th>
		                            <td>
		                                <form name="searchPageForm" id="searchPageForm" class="form-horizontal" action="${ctx}/weixinGzUserInfo/queryList" method="post">
										    <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
										    <input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
										    <input type="hidden" id="parentMenu" name="parentMenu" value='${param.parentMenu}'>
		                                    <input name="key" type="text" class="txt" placeholder="微信昵称" value="${param.key }">
		                                    <input name="eventStatus" id="eventStatus" type="hidden" value="${param.eventStatus }">
		                                    <input name="gender" id="gender" type="hidden" value="${param.gender }">
						                    <input name="loc" id="loc" type="hidden" value="${param.loc }">
						                    <input name="points" id="points" type="hidden" value="${param.points }">
						                    <input name="level" id="level" type="hidden" value="${param.level }">
						                    <input name="tag" id="tag" type="hidden" value="${param.tag }">
		                                    <input name="gzTime" id="gzTime" type="hidden" value="${param.gzTime }">
		                                    <input name="latestConsume" id="latestConsume" type="hidden" value="${param.latestConsume }">
		                                    <input name="totalBuy" id="totalBuy" type="hidden" value="${param.totalBuy }">
		                                    <input name="average" id="average" type="hidden" value="${param.average }">
						                    <input type="hidden" name="memberIds" id="memberIds" value="${memberIds }">
		                                </form>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th>账户：</th>
		                            <td>
		                                <ul class="js-filter-account items-ul">
		                                <c:if test="${empty(param.eventStatus)||fn:contains(param.eventStatus,'-1m') }">
										    <li data-tag="-1m" class="active">
										        <span>不限</span>
										    </li>
										</c:if>
		                                <c:if test="${!empty(param.eventStatus)&&!fn:contains(param.eventStatus,'-1m') }">
										    <li data-tag="-1m" >
										        <span>不限</span>
										    </li>
										</c:if>
										    <li data-tag="2" ${param.eventStatus==2?'class="active"':'' }>
										        <span>已跑路</span>
										    </li>
										    <li data-tag="1" ${param.eventStatus==1?'class="active"':'' }>
										        <span>已关注</span>
										    </li>
										</ul>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th>性别：</th>
		                            <td>
		                                <ul class="js-filter-gender items-ul">
		                                	<c:if test="${empty(param.gender)||fn:contains(param.gender,'-1m') }">
											    <li data-tag="-1m" class="active">
											        <span>不限</span>
											    </li>
		                                	</c:if>
		                                	<c:if test="${!empty(param.gender)&&!fn:contains(param.gender,'-1m') }">
											    <li data-tag="-1m">
											        <span>不限</span>
											    </li>
		                                	</c:if>
										    <li data-tag="1" ${param.gender==1?'class="active"':'' }>
										        <span>男</span>
										    </li>
										    <li data-tag="2" ${param.gender==2?'class="active"':'' }>
										        <span>女</span>
										    </li>
										    <li data-tag="-1m" ${param.gender=='-1m'?'class="active"':'' }>
										        <span>未知</span>
										    </li>
										</ul>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th>地域：</th>
		                            <td>
		                                <ul class="js-filter-city items-ul">
		                                	<c:if test="${empty(locParams)||fn:length(locParams)<=0 }" var="status">
											    <li data-tag="m1" class="active">
											        <span>不限</span>
											    </li>
										        <li data-tag="江浙沪">
										            <span>江浙沪</span>
										        </li>
										        <li data-tag="珠三角">
										            <span>珠三角</span>
										        </li>
										        <li data-tag="港澳台">
										            <span>港澳台</span>
										        </li>
										        <li data-tag="北京">
										            <span>北京</span>
										        </li>
										        <li data-tag="上海">
										            <span>上海</span>
										        </li>
										        <li data-tag="广州">
										            <span>广州</span>
										        </li>
										        <li data-tag="深圳">
										            <span>深圳</span>
										        </li>
										        <li data-tag="京津">
										            <span>京津</span>
										        </li>
		                                	</c:if>
		                                	<c:if test="${status==false }">
		                                		 <li data-tag="m1" >
											        <span>不限</span>
											    </li>
		                                		<c:forEach items="${locParams }" var="locparam">
		                                			<li data-tag="${locparam }" class="active">
											            <span>${locparam }</span>
											        </li>
		                                		</c:forEach>
		                                	</c:if>
										    <li class="js-more custom-more" id="jsmoreCitySelect" onclick="selectCity()">
										        <span>更多...</span>
										    </li>
										</ul>
		                            </td>
		                        </tr>
		                        <tr>
                            <th>本店积分：</th>
                            <td>
                                <ul class="js-filter-points items-ul">
	                                <c:if test="${empty(param.points)||fn:contains(param.points,'-1m') }">
									    <li data-tag="-1m" class="active">
									        <span>不限</span>
									    </li>
									</c:if>
	                                <c:if test="${!empty(param.points)&&!fn:contains(param.points,'-1m') }">
									    <li data-tag="-1m" >
									        <span>不限</span>
									    </li>
									</c:if>
							
								    <li data-tag="0-100" ${fn:indexOf(param.points,'0-100')!=-1?'class="active"':'' }>
								        <span>0-100</span>
								    </li>
								    <li data-tag="101-200" ${fn:indexOf(param.points,'101-200')!=-1?'class="active"':'' }>
								        <span>101-200</span>
								    </li>
								    <li data-tag="201-500" ${fn:indexOf(param.points,'201-500')!=-1?'class="active"':'' }>
								        <span>201-500</span>
								    </li>
								    <li data-tag="501-1000" ${fn:indexOf(param.points,'501-1000')!=-1?'class="active"':'' }>
								        <span>501-1000</span>
								    </li>
								    <li data-tag="1000+" ${fn:indexOf(param.points,'1000+')!=-1?'class="active"':'' }>
								        <span>1000+</span>
								    </li>
								    <c:if test="${pointStatus==true }">
									    <li id="pointSel" data-tag="${param.points }" class="active">
									        <span>${param.points }</span>
									    </li>
								    </c:if>
								    <li class="js-custom custom-more hide" id="pointSerl" onclick="piontSelf()">
								        <span>自定义...</span>
								    </li>
								
								
								</ul>
                            </td>
                        </tr>
                        <tr>
                            <th>会员卡等级：</th>
                            <td>
                                <ul class="js-filter-level items-ul">
                                	<c:if test="${empty(param.level)||fn:contains(param.level,'ml')}">
									    <li data-tag="ml" class="active">
									        <span>不限</span>
									    </li>
                                	</c:if>
                                	<c:if test="${!empty(param.level)&&!fn:contains(param.level,'ml')}">
									    <li data-tag="ml" >
									        <span>不限</span>
									    </li>
                                	</c:if>
							    	<c:forEach var="memberShipLevel" items="${memberShipLevels }">
								        <li data-tag="${memberShipLevel.dbid }" ${fn:contains(param.level,memberShipLevel.dbid)==true?'class="active"':'' }>
								            <span>${memberShipLevel.name }</span>
								        </li>
							    	</c:forEach>
								</ul>
                            </td>
                        </tr>
                        <tr>
                            <th>会员标签：</th>
                            <td>
                                <ul class="js-filter-user-tag items-ul">
                                	<c:if test="${empty(param.tag)||fn:contains(param.tag,'tm')}">
									    <li data-tag="tm" class="active">
									        <span>不限</span>
									    </li>
								    </c:if>
								    <c:if test="${!empty(param.tag)&&!fn:contains(param.tag,'tm')}">
									    <li data-tag="tm" >
									        <span>不限</span>
									    </li>
                                	</c:if>
								  	<c:forEach var="tag" items="${tags }">
								        <li data-tag="${tag.dbid }" ${fn:indexOf(param.tag,tag.dbid)!=-1?'class="active"':'' }>
								            <span>${tag.name }</span>
								        </li>
							    	</c:forEach>
								</ul>
                            </td>
                        </tr>
                        <tr>
                            <th>关注时间：</th>
                            <td>
                                <ul class="js-filter-follow-time items-ul">
                               	 <c:if test="${empty(param.gzTime)||fn:contains(param.gzTime,'gm')}">
								    <li data-tag="gm" class="active">
								        <span>不限</span>
								    </li>
								 </c:if>
								 <c:if test="${!empty(param.gzTime)&&!fn:contains(param.gzTime,'gm')}">
									    <li data-tag="gm" >
									        <span>不限</span>
									    </li>
                                	</c:if>
								    <li data-tag="1w" ${!empty(param.gzTime)&&fn:indexOf(param.gzTime,'1w')!=-1?'class="active"':'' }>
								        <span>1周内</span>
								    </li>
								    <li data-tag="2w" ${!empty(param.gzTime)&&fn:indexOf(param.gzTime,'2w')!=-1?'class="active"':'' }>
								        <span>2周内</span>
								    </li>
					 			    <li data-tag="1m" ${!empty(param.gzTime)&&fn:indexOf(param.gzTime,'1m')!=-1?'class="active"':'' }>
								        <span>1个月内</span>
								    </li>
								    <li data-tag="2m" ${!empty(param.gzTime)&&fn:indexOf(param.gzTime,'2m')!=-1?'class="active"':'' }>
								        <span>2个月内</span>
								    </li>
								    <li data-tag="3m" ${!empty(param.gzTime)&&fn:indexOf(param.gzTime,'3m')!=-1?'class="active"':'' }>
								        <span>3个月内</span>
								    </li>
								    <li data-tag="+6m" ${!empty(param.gzTime)&&fn:contains(param.gzTime,'+6m')==true?'class="active"':'' }>
								        <span>6个月内</span>
								    </li>
								    <li data-tag="-6m" ${!empty(param.gzTime)&&fn:indexOf(param.gzTime,'-6m')!=-1?'class="active"':'' }>
								        <span>6个月前</span>
								    </li>
								    <c:if test="${gzTimeStatus==true }">
									    <li id='gzTimeSf' data-tag="${param.gzTime }" class="active">
									        <span>${param.gzTime }</span>
									    </li>
								    </c:if>
								    <li class="js-custom custom-more"   id="gzTimeSelf" onclick="gzTimeSelf()">
								        <span>自定义...</span>
								    </li>
								</ul>
                            </td>
                        </tr>
                        <tr>
                            <th>最近消费：</th>
                            <td>
                                <ul class="js-filter-latest-consume items-ul">
                               	 	<c:if test="${empty(param.latestConsume)||fn:contains(param.latestConsume,'gm')}">
									    <li data-tag="gm" class="active">
									        <span>不限</span>
									    </li>
								    </c:if>
								    <c:if test="${!empty(param.latestConsume)&&!fn:contains(param.latestConsume,'gm')}">
								    	<li data-tag="gm">
									        <span>不限</span>
									    </li>
								    </c:if>
								   <li data-tag="1w" ${!empty(param.latestConsume)&&fn:indexOf(param.latestConsume,'1w')!=-1?'class="active"':'' }>
								        <span>1周内</span>
								    </li>
								    <li data-tag="2w" ${!empty(param.latestConsume)&&fn:indexOf(param.latestConsume,'2w')!=-1?'class="active"':'' }>
								        <span>2周内</span>
								    </li>
					 			    <li data-tag="+1m" ${!empty(param.latestConsume)&&fn:indexOf(param.latestConsume,'+1m')!=-1?'class="active"':'' }>
								        <span>1个月内</span>
								    </li>
								    <li data-tag="-1m" ${!empty(param.latestConsume)&&fn:indexOf(param.latestConsume,'-1m')!=-1?'class="active"':'' }>
								        <span>1个月前</span>
								    </li>
								    <li data-tag="-2m" ${!empty(param.latestConsume)&&fn:indexOf(param.latestConsume,'-2m')!=-1?'class="active"':'' }>
								        <span>2个月前</span>
								    </li>
								    <li data-tag="-3m" ${!empty(param.latestConsume)&&fn:indexOf(param.latestConsume,'-3m')!=-1?'class="active"':'' }>
								        <span>3个月前</span>
								    </li>
				 				    <li data-tag="-6m" ${!empty(param.latestConsume)&&fn:indexOf(param.latestConsume,'-6m')!=-1?'class="active"':'' }>
								        <span>6个月前</span>
								    </li>
								     <c:if test="${lastConsumeStatus==true }">
									    <li id="latestConsumeSf" data-tag="${param.latestConsume }" class="active">
									        <span>${param.latestConsume }</span>
									    </li>
								    </c:if>
								    <li class="js-custom custom-more" id="latestConsumeSelf" onclick="latestConsumeSelf()">
								        <span>自定义...</span>
								    </li>
								</ul>
                            </td>
                        </tr>
                        <tr>
                            <th>购买次数：</th>
                            <td>
                                <ul class="js-filter-total-buy items-ul">
                                	<c:if test="${empty(param.totalBuy)||fn:contains(param.totalBuy,'gm')}">
									    <li data-tag="gm" class="active">
									        <span>不限</span>
									    </li>
									</c:if>
                                	<c:if test="${!empty(param.totalBuy)&&!fn:contains(param.totalBuy,'gm')}">
									    <li data-tag="gm">
									        <span>不限</span>
									    </li>
									</c:if>
								    <li data-tag="1+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'1+')!=-1?'class="active"':'' }>
								        <span>1+</span>
								    </li>
								    <li data-tag="2+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'2+')!=-1?'class="active"':'' }>
								        <span>2+</span>
								    </li>
								    <li data-tag="3+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'3+')!=-1?'class="active"':'' }>
								        <span>3+</span>
								    </li>
								    <li data-tag="4+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'4+')==0?'class="active"':'' }>
								        <span>4+</span>
								    </li>
								    <li data-tag="5+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'5+')==0?'class="active"':'' }>
								        <span>5+</span>
								    </li>
								    <li data-tag="10+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'10+')==0?'class="active"':'' }>
								        <span>10+</span>
								    </li>
								    <li data-tag="15+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'15+')==0?'class="active"':'' }>
								        <span>15+</span>
								    </li>
								    <li data-tag="20+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'20+')!=-1?'class="active"':'' }>
								        <span>20+</span>
								    </li>
								    <li data-tag="30+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'30+')!=-1?'class="active"':'' }>
								        <span>30+</span>
								    </li>
								    <li data-tag="50+" ${!empty(param.totalBuy)&&fn:indexOf(param.totalBuy,'50+')!=-1?'class="active"':'' }>
								        <span>50+</span>
								    </li>
								    <c:if test="${totalBuyStatus==true }">
									    <li id="totalBuySf" data-tag="${param.totalBuy }" class="active" >
									        <span>${param.totalBuy }</span>
									    </li>
								    </c:if>
								    <li class="js-custom custom-more" id="totalBuySelf" onclick="totalBuySelf()">
								        <span>自定义...</span>
								    </li>
								</ul>
                            </td>
                        </tr>
                        <tr>
                            <th>商品均价：</th>
                            <td>
                                <ul class="js-filter-average items-ul">
								    <c:if test="${empty(param.average)||fn:contains(param.average,'gm')}">
									    <li data-tag="gm" class="active">
									        <span>不限</span>
									    </li>
									</c:if>
                                	<c:if test="${!empty(param.average)&&!fn:contains(param.average,'gm')}">
									    <li data-tag="gm">
									        <span>不限</span>
									    </li>
									</c:if>
								    <li data-tag="50-" ${param.average=='50-'?'class="active"':'' }>
								        <span>50-</span>
								    </li>
								    <li data-tag="50-80" ${param.average=='50-80'?'class="active"':'' }>
								        <span>50-80</span>
								    </li>
								    <li data-tag="80-150" ${param.average=='80-150'?'class="active"':'' }>
								        <span>80-150</span>
								    </li>
								    <li data-tag="150-200" ${param.average=='150-200'?'class="active"':'' }>
								        <span>150-200</span>
								    </li>
								    <li data-tag="200-300" ${param.average=='200-300'?'class="active"':'' }>
								        <span>200-300</span>
								    </li>
								    <li data-tag="300-500" ${param.average=='300-500'?'class="active"':'' }>
								        <span>300-500</span>
								    </li>
								    <li data-tag="500-1000" ${param.average=='500-1000'?'class="active"':'' }>
								        <span>500-1000</span>
								    </li>
								    <li data-tag="1000+" ${param.average=='1000+'?'class="active"':'' }>
								        <span>1000+</span>
								    </li>
								    <c:if test="${averageStatus==true }">
									    <li id="averageSf" data-tag="${param.average }" class="active" }>
									        <span>${param.average }</span>
									    </li>
								    </c:if>
								    <li class="js-custom custom-more" id="averageSelf" onclick="averageSelf()">
								        <span>自定义...</span>
								    </li>
								</ul>
                            </td>
                        </tr>
		                    </tbody>
		                </table>
		                <div class="btn-actions">
		                    <button type="button" onclick="$('#searchPageForm')[0].submit()" class="js-filter-btn btn btn-primary" data-loading-text="请稍候...">筛选</button>
		                    <button type="button" onclick="sysGzuserInfo()" class="js-filter-btn btn btn-primary" data-loading-text="请稍候...">同步数据</button>
		                </div>
		            </div>
            <div class="widget">
			    <div class="widget-head">
			        <h3 class="widget-title">筛选结果 (共 ${page.totalCount } 人)</h3>
			    </div>
    <div class="widget-body">
        <div class="list-wrap">
            <table class="table ui-table-list js-list-table">
                <thead>
                    <tr>
                        <th>
                            <div class="td-cont">
                                <label class="checkbox inline th-check-all">
                                    <input type="checkbox" class="js-check-all" onclick="selectAll(this,'id')">
                                </label>
                                <span class="th-check-title">粉丝</span>
                            </div>
                        </th>
                        <th>
                            <div class="td-cont">
                            </div>
                        </th>
                        <th>
                            <div class="td-cont">
                                会员卡<span class="orderby-arrow"></span>
                            </div>
                        </th>
                        <th class="with-5words">
                            <div class="td-cont">
                                积分<span class="orderby-arrow"></span>
                            </div>
                        </th>
                        <th>
                            <div class="td-cont">
                              关注时间<span class="orderby-arrow">↓</span>
                            </div>
                        </th>
                        <th>
                            <div class="td-cont">
                               最后对话<span class="orderby-arrow"></span>
                            </div>
                        </th>
                        <th>
                            <div class="td-cont">
                               最后购买<span class="orderby-arrow"></span>
                            </div>
                        </th>
                        <th class="with-2words">
                            <div class="td-cont">
                                购次<span class="orderby-arrow"></span>
                            </div>
                        </th>
                       <!--  <th class="with-2words">
                            <div class="td-cont">
                                <a href="?fans%2Fsearch%2Fbasic=&amp;oc=avg&amp;om=desc">均价<span class="orderby-arrow"></span></a>
                            </div>
                        </th> -->
                        <th class="opts">
                            <div class="td-cont">操作</div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach items="${page.result }" var="weixinGzUserInfo">
                		<c:set value="${weixinGzUserInfo.member }" var="member"></c:set>
                       <tr >
                        <td class="td-thumb">
                            <div class="td-cont">
                            	<c:if test="${weixinGzUserInfo.eventStatus==2 }">
                            		<div class="fans-died">
                                        已跑路
                                    </div>
                            	</c:if>
                                <label class="list-item-select">
                                     <input type="checkbox" class="js-check-toggle" name="id" id="id1" value="${member.dbid }">
                                </label>
                                <a class="new-window" target="_blank" >
                                  <img src="${weixinGzUserInfo.headimgurl }" alt="">
                                </a>
                            </div>
                        </td>
                        <td class="td-username">
                            <div class="td-cont">
                                <p>
                                    <!-- <a class="js-fans-nickname new-window" target="_blank" href="//koudaitong.com/v2/weixin/message/talk#list&amp;p=1&amp;type=new&amp;orderby=created_time&amp;order=desc&amp;fans_id=2214590287"> -->
                                    <a class="js-fans-nickname new-window" target="_blank" onclick="window.location.href='${ctx}/member/information?dbid=${member.dbid}&type=1'">
                                        ${weixinGzUserInfo.nickname }
                                    </a>
                                </p>
                                <p>
                                    <span class="c-gray">
                                    	<c:if test="${weixinGzUserInfo.sex==1 }">
											先生
										</c:if>
										<c:if test="${weixinGzUserInfo.sex==2 }">
											女士
										</c:if>
                                    </span>
                                </p>
                            </div>
                        </td>
                        <td class="td-level">
                            <div class="js-level-name td-cont" id="level${member.dbid }">
                            	${member.memberShipLevel.name }
                             </div>
                        </td>
                        <td>
                            <div class="td-cont" id="totalPoint${member.dbid }">
                               ${member.totalPoint }
                             </div>
                        </td>
                        <td class="time">
                            <div class="td-cont">
                               <fmt:formatDate value="${weixinGzUserInfo.addtime }" pattern="yyyy-MM-dd"/>
                               <br>
                               <fmt:formatDate value="${weixinGzUserInfo.addtime }" pattern="HH:ss:mm"/>
                            </div>
                        </td>
                        <td class="time">
                            <div class="td-cont">
	                            <c:if test="${empty(member.lastContactDate) }">
	                            	无
	                            </c:if>
	                            <c:if test="${!empty(member.lastContactDate) }">
	                               <fmt:formatDate value="${member.lastContactDate }" pattern="yyyy-MM-dd"/>
	                               <br>
	                               <fmt:formatDate value="${member.lastContactDate }" pattern="HH:ss:mm"/>
	                           	</c:if>
                             </div>
                        </td>
                        <td class="time">
                            <div class="td-cont">
                            <c:if test="${empty(member.lastBuyDate) }">
                            	无
                            </c:if>
                             <c:if test="${!empty(member.lastBuyDate) }">
                               <fmt:formatDate value="${member.lastContactDate }" pattern="yyyy-MM-dd"/>
                               <br>
                               <fmt:formatDate value="${member.lastContactDate }" pattern="HH:ss:mm"/>
                             </c:if>
                            </div>
                        </td>
                        <td>
                            <div class="td-cont">
                                ${member.totalBuy }
                            </div>
                        </td>
                      <%--   <td>
                            <div class="td-cont">
                                ${member.average }
                            </div>
                        </td> --%>
                        <td class="opts">
                            <div class="td-cont">
                                <p>
                                   <a class="js-single-opts-level" href="javascript:void(0);" onclick="setMemberShipLevel(${member.dbid},${member.memberShipLevel.dbid })">设会员</a>
                                            <span>-</span>
                                     <a class="js-single-opts-tag" href="javascript:void(0);" id="js-single-opts-tag${member.dbid}" onclick="setMemberTags(${member.dbid})">加标签</a>
                                            <span>-</span>
                                     <a class="js-single-opts-point" href="javascript:void(0);" onclick="setMemberPoint(${member.dbid})">给积分</a>
                               </p>
                               <p>
                                   <!--  <a href="//koudaitong.com/v2/weixin/message/talk#list&amp;p=1&amp;type=new&amp;orderby=created_time&amp;order=desc&amp;fans_id=2214590287" target="_blank" class="new-window">
                                        查看对话记录
                                    </a> -->
                                </p>
                             </div>
                        </td>
                    </tr>
                   </c:forEach>                                                                                
                 </tbody>
            </table>

            <div class="js-search-list-pagenavi pagenavi">
                <div id="js-batch-opts" class="batch-opts">
                    <form id="js-batch-opts-form" class="hide" action="${ctx }/weixinGzUserInfo/sendMessage" method="post">
                        <input type="hidden" name="type" id="type" value="1">
                        <input type="hidden" name="qmemberIds" id="qmemberIds" value="">
                        <input type="hidden" name="searchparams" id="searchparams" value="${selectParam }">
                    </form>

                    <div class="dropdown hover">
                        <a href="javascript:void(0);">群发信息<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a class="js-batch-opts-sendmsg" href="javascript:void(0);" onclick="sendMessageChoice(1)">给选中的人发信息</a></li>
                            <li><a class="js-batch-opts-sendmsg-all" href="javascript:void(0);" onclick="sendMessageChoice(2)">给筛选出来的${page.totalCount }人发信息（已跑路除外）</a></li>
                        </ul>
                    </div>
                    
                    <div class="dropdown hover">
                        <a class="js-batch-opts-level-target" href="javascript:void(0);">设会员<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a class="js-batch-opts-level" href="javascript:void(0);" onclick="setMoreMemberShipLevel('给选中的人设会员',1)">给选中的人设会员</a></li>
                            <li><a class="js-batch-opts-level-all" href="javascript:void(0);" onclick="setMoreMemberShipLevel('给筛选出来的${page.totalCount }人设会员',2)">给筛选出来的<span class="js-batch-set-total">${page.totalCount }</span>人设会员</a></li>
                        </ul>
                    </div>

                    <div class="dropdown hover">
                        <a class="js-batch-opts-tag-target" id="js-batch-opts-tag-target" href="javascript:void(0);">加标签<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a class="js-batch-opts-tag" href="javascript:void(0);" onclick="setBatchMemberTags('给选中的人设置标签',1)">给选中的人加标签</a></li>
                            <li><a class="js-batch-opts-tag-all" href="javascript:void(0);" onclick="setBatchMemberTags('给筛选出来的${page.totalCount }人设置标签',2)">给筛选出来的${page.totalCount }人加标签</a></li>
                        </ul>
                    </div>
                    
                    <div class="dropdown hover">
                        <a class="js-batch-opts-point-target" href="javascript:void(0);">给积分<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a class="js-batch-opts-point" href="javascript:void(0);" onclick="setMoreMemberPoint('给选中的人发积分',1)">给选中的人发积分</a></li>
                            <li><a class="js-batch-opts-point-all" href="javascript:void(0);" onclick="setMoreMemberPoint('给筛选出来的${page.totalCount }人发积分',2)">给筛选出来的${page.totalCount }人发积分</a></li>
                            <li><a class="js-batch-clear-point" href="javascript:void(0);" onclick="clearPoint('对选中的人清空积分',1)">对选中的人清空积分</a></li>
                            <li><a class="js-batch-clear-point-all" href="javascript:void(0);" onclick="clearPoint('对筛选出来的${page.totalCount }人清空积分',2)">对筛选出来的${page.totalCount }人清空积分</a></li>
                        </ul>
                    </div>

                </div>
				<div id="fanye">
					<%@ include file="../../commons/commonPagination.jsp" %>
				</div>
	           </div>
        </div>

    	</div>
		</div>
        </div>
   		 </div>
   		</div>
   </div>
</div>
<div class="ui-popover-inner clearfix bottom popover-select-city at-right popover-confirm-block" id="popover-select-city" style="display: none;">
    <div class="inner__header" >
      <ul class="items-ul">
        <li data-tag="江浙沪">
            <span>江浙沪</span>
        </li>
        <li data-tag="珠三角">
            <span>珠三角</span>
        </li>
    
        <li data-tag="港澳台">
            <span>港澳台</span>
        </li>
    
        <li data-tag="北京">
            <span>北京</span>
        </li>
    
        <li data-tag="上海">
            <span>上海</span>
        </li>
    
        <li data-tag="广州">
            <span>广州</span>
        </li>
    
        <li data-tag="深圳">
            <span>深圳</span>
        </li>
    
        <li data-tag="京津">
            <span>京津</span>
        </li>
	</ul>
	<ul class="items-ul">
	        <li data-tag="杭州">
	            <span>杭州</span>
	        </li>
	        <li data-tag="温州">
	            <span>温州</span>
	        </li>
	    
	        <li data-tag="宁波">
	            <span>宁波</span>
	        </li>
	    
	        <li data-tag="嘉兴">
	            <span>嘉兴</span>
	        </li>
	    
	        <li data-tag="南京">
	            <span>南京</span>
	        </li>
	    
	        <li data-tag="苏州">
	            <span>苏州</span>
	        </li>
	    
	        <li data-tag="济南">
	            <span>济南</span>
	        </li>
	    
	        <li data-tag="青岛">
	            <span>青岛</span>
	        </li>
	    
	        <li data-tag="大连">
	            <span>大连</span>
	        </li>
	    
	        <li data-tag="无锡">
	            <span>无锡</span>
	        </li>
	    
	        <li data-tag="合肥">
	            <span>合肥</span>
	        </li>
	    
	        <li data-tag="天津">
	            <span>天津</span>
	        </li>
	    
	        <li data-tag="长沙">
	            <span>长沙</span>
	        </li>
	    
	        <li data-tag="武汉">
	            <span>武汉</span>
	        </li>
	    
	        <li data-tag="郑州">
	            <span>郑州</span>
	        </li>
	    
	        <li data-tag="石家庄">
	            <span>石家庄</span>
	        </li>
	    
	        <li data-tag="成都">
	            <span>成都</span>
	        </li>
	    
	        <li data-tag="重庆">
	            <span>重庆</span>
	        </li>
	    
	        <li data-tag="西安">
	            <span>西安</span>
	        </li>
	    
	        <li data-tag="昆明">
	            <span>昆明</span>
	        </li>
	    
	        <li data-tag="南宁">
	            <span>南宁</span>
	        </li>
	    
	        <li data-tag="福州">
	            <span>福州</span>
	        </li>
	    
	        <li data-tag="厦门">
	            <span>厦门</span>
	        </li>
	    
	        <li data-tag="南昌">
	            <span>南昌</span>
	        </li>
	    
	        <li data-tag="东莞">
	            <span>东莞</span>
	        </li>
	    
	        <li data-tag="沈阳">
	            <span>沈阳</span>
	        </li>
	    
	        <li data-tag="长春">
	            <span>长春</span>
	        </li>
	    
	        <li data-tag="哈尔滨">
	            <span>哈尔滨</span>
	        </li>
	    
	</ul>
	<ul class="items-ul">
	        <li data-tag="河北">
	            <span>河北</span>
	        </li>
	    
	        <li data-tag="河南">
	            <span>河南</span>
	        </li>
	    
	        <li data-tag="湖北">
	            <span>湖北</span>
	        </li>
	    
	        <li data-tag="湖南">
	            <span>湖南</span>
	        </li>
	    
	        <li data-tag="福建">
	            <span>福建</span>
	        </li>
	    
	        <li data-tag="江苏">
	            <span>江苏</span>
	        </li>
	    
	        <li data-tag="江西">
	            <span>江西</span>
	        </li>
	    
	        <li data-tag="广东">
	            <span>广东</span>
	        </li>
	    
	        <li data-tag="广西">
	            <span>广西</span>
	        </li>
	    
	        <li data-tag="海南">
	            <span>海南</span>
	        </li>
	    
	        <li data-tag="浙江">
	            <span>浙江</span>
	        </li>
	    
	        <li data-tag="安徽">
	            <span>安徽</span>
	        </li>
	    
	        <li data-tag="吉林">
	            <span>吉林</span>
	        </li>
	    
	        <li data-tag="辽宁">
	            <span>辽宁</span>
	        </li>
	    
	        <li data-tag="黑龙江">
	            <span>黑龙江</span>
	        </li>
	    
	        <li data-tag="山东">
	            <span>山东</span>
	        </li>
	    
	        <li data-tag="山西">
	            <span>山西</span>
	        </li>
	    
	        <li data-tag="陕西">
	            <span>陕西</span>
	        </li>
	    
	        <li data-tag="新疆">
	            <span>新疆</span>
	        </li>
	    
	        <li data-tag="内蒙古">
	            <span>内蒙古</span>
	        </li>
	    
	        <li data-tag="云南">
	            <span>云南</span>
	        </li>
	    
	        <li data-tag="贵州">
	            <span>贵州</span>
	        </li>
	    
	        <li data-tag="四川">
	            <span>四川</span>
	        </li>
	    
	        <li data-tag="甘肃">
	            <span>甘肃</span>
	        </li>
	    
	        <li data-tag="宁夏">
	            <span>宁夏</span>
	        </li>
	    
	        <li data-tag="青海">
	            <span>青海</span>
	        </li>
	    
	        <li data-tag="西藏">
	            <span>西藏</span>
	        </li>
	    
	        <li data-tag="香港">
	            <span>香港</span>
	        </li>
	    
	        <li data-tag="澳门">
	            <span>澳门</span>
	        </li>
	    
	        <li data-tag="台湾">
	            <span>台湾</span>
	        </li>
	    
	</ul>
	<div class="select-all">
	    <label>
	        <input type="checkbox"  class="js-select-all" >全选
	    </label>
	</div>
   </div>
   <div class="inner__content" >
       <a href="javascript:;" class="zent-btn zent-btn-primary zent-btn-small js-save" id="zent-btn-smalljssave" onclick="surceOkc()">确定</a>
       <a href="javascript:;" class="zent-btn zent-btn-small js-cancel" onclick="removeSelectCity()">取消</a>
   </div>
</div>
<div class="frmContent" id="spreadGroupId" style="display: none;">
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


</body>

<script type="text/javascript">
$(document).ready(function(){
	bindClick();
})
function sysGzuserInfo(){
		$.ajax({	
			url : "${ctx}/weixinGzUserInfo/sysBathGzuserinfo", 
			data : {}, 
			async : false, 
			timeout : 20000, 
			dataType : "json",
			type:"post",
			success : function(data, textStatus, jqXHR){
				//alert(data.message);
				var obj;
				if(data.message!=undefined){
					obj=$.parseJSON(data.message);
				}else{
					obj=data;
				}
				if(obj[0].mark==1){
					//错误
					$.utile.tips(obj[0].message);
					$(".butSave").attr("onclick",url2);
					return ;
				}else if(obj[0].mark==0){
					$.utile.tips(data[0].message);
					if (target == "_self") {
						setTimeout(
								function() {
									window.location.href = obj[0].url
								}, 1000);
					}
					if (target == "_parent") {
						// 同时关闭弹出窗口
						var parent = window.parent;
						window.parent.frames["contentUrl"].location=obj[0].url;
					}
					// 保存数据成功时页面需跳转到列表页面
				}
			},
			complete : function(jqXHR, textStatus){
				$(".butSave").attr("onclick",url2);
				var jqXHR=jqXHR;
				var textStatus=textStatus;
			}, 
			beforeSend : function(jqXHR, configs){
				url2=$(".butSave").attr("onclick");
				$(".butSave").attr("onclick","");
				var jqXHR=jqXHR;
				var configs=configs;
			}, 
			error : function(jqXHR, textStatus, errorThrown){
					$.utile.tips("系统请求超时");
					$(".butSave").attr("onclick",url2);
			}
		});
	}
/** 删除封装提示信息方法* */
function operatorDataByDbid(url,conf,type,memberId,memberName) {
	var content="您确定删除选择数据吗？";
	if(null!=conf&&conf!=undefined){
		content=conf;
	}
	try {
		window.top.art.dialog({
			content : content,
			icon : 'question',
			width:"250px",
			height:"80px",
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				var param = getCheckBox();
				$.post(url + "&datetime=" + new Date(),{},callBack);
				function callBack(data) {
					if (data[0].mark == 2) {// 关系存在引用，删除时提示用户，用户点击确认后在退回删除页面
						window.top.art.dialog({
							content : data[0].message,
							icon : 'warning',
							window : 'top',
							width:"250px",
							height:"80px",
							lock : true,
							ok : function() {// 点击去定按钮后执行方法
								$.utile.close();
								return;
							}
						});

					}

					if (data[0].mark == 1) {// 删除数据失败时提示信息
						$.utile.tips(data[0].message);
						return ;
					}
					if (data[0].mark == 0) {// 删除数据成功提示信息
						// 页面跳转到列表页面
						$.utile.tips(data[0].message);
						if(type==1){
							var htl='<span style="color: pink">渠道会员</span><br>';
							htl=htl+'<a href="javascript:void(-1)" class="aedit" onclick="operatorDataByDbid(\'${ctx }/member/saveChanageMemType?memberId='+memberId+'&type=2\',\'您确定【'+memberName+'】转为普通会员吗\',2,'+memberId+',\''+memberName+'\')">转为普通会员</a>'
							$("#memType"+memberId).text("");
							$("#memType"+memberId).append(htl);
						}
						if(type==2){
							var htl='<span style="color: green">普通会员</span><br>';
							htl=htl+'<a href="javascript:void(-1)" class="aedit" onclick="operatorDataByDbid(\'${ctx }/member/saveChanageMemType?memberId='+memberId+'&type=2\',\'您确定【'+memberName+'】转为渠道会员吗\',1,'+memberId+',\''+memberName+'\')">转为渠道会员</a>'
							$("#memType"+memberId).text("");
							$("#memType"+memberId).append(htl);
						}
						return ;
					}
					
				}
			},
			cancel : true
		});
	} catch (e) {
		return;
	}
}
</script>
</html>