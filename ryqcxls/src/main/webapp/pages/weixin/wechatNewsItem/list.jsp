<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>关注时回复</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx }/css/bootstrap-responsive.min.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${ctx }/css/uniform.css" />
<link rel="stylesheet" href="${ctx }/css/unicorn.main.css" />
<link rel="stylesheet" href="${ctx }/css/unicorn.grey.css"/>
<link rel="stylesheet" href="${ctx }/wxcss/css/block.css"/>
<link rel="stylesheet" href="${ctx }/wxcss/css/global.css?da=${now}"/>
<link rel="stylesheet" href="${ctx }/wxcss/css/font-awesome.min.css"/>
</head>
<body>
<div id="breadcrumb">
	<a href="${ctx }/main/index" title="微商城中心" class="tip-bottom"><i
		class="icon-home"></i>微商城中心</a> <a href="javascript:void(-1)"
		class="current">微信图文</a>
</div>
<br>
<div class="alert alert-error">
	提示：微信图文将图文信息同步至微信公众号后台，所以请先配置好微信公众账号。
</div>
<div class="block-wrap">
  <div class="tj msg-list">
    <!-- list开始 -->
      <div id="addAppmsg" class="tc add-access"> 
	      <a href="${ctx }/wechatNewsItem/add" class="dib vm add-btn">+单图文消息</a> 
	      <a href="${ctx }/wechatNewsItem/addMore" class="dib vm add-btn multi-access">+多图文消息</a> 
      </div>
	 <c:forEach var="wechatNewsTemplate" items="${wechatNewsTemplates }">
	 	<c:if test="${wechatNewsTemplate.type==1 }">
	 	  <div class="msg-item-wrapper">
                <div class="msg-item">
                  <h4 class="msg-t"><a href="" class="i-title" >${wechatNewsTemplate.title }</a></h4>
                  <p class="msg-meta"><span class="msg-date">${fn:substring(wechatNewsTemplate.addtime,0,10) }</span></p>
                  <c:forEach items="${wechatNewsTemplate.wechatNewsitems }" var="wechatNewsitem">
                 	 <div class="cover">
	                    <p class="default-tip" style="display:none">封面图片</p>
	                   	 	<img src="${wechatNewsitem.thumbUrl }" class="i-img" style=""> </div>
	                  	<p class="msg-text">${wechatNewsitem.digest }</p>
                  </c:forEach>
                </div>
                <div class="msg-opr">
                  <ul class="f0 msg-opr-list">
                    <li class="b-dib opr-item"><a class="block tc opr-btn edit-btn" href="${ctx }/wechatNewsItem/edit?dbid=${wechatNewsTemplate.dbid}" data-rid="7200"><span class="th vm dib opr-icon edit-icon">编辑</span></a></li>
                    <li class="b-dib opr-item"><a class="block tc opr-btn del-btn" href="javascript:void(-1)" onclick="$.utile.deleteById('${ctx}/wechatNewsItem/delete?dbids=${wechatNewsTemplate.dbid}','searchPageForm')" data-rid="7200"><span class="th vm dib opr-icon del-icon">删除</span></a></li>
                  </ul>
                </div>
              </div>
         </c:if>
         <c:if test="${wechatNewsTemplate.type==2 }">
         	<div class="msg-item-wrapper">
                <div class="msg-item multi-msg">
                	<c:forEach var="wechatNewsItem" items="${wechatNewsTemplate.wechatNewsitems }" varStatus="i">
                		<c:if test="${i.index==0 }" var="status">
		                  <div class="appmsgItem">
		                    <h4 class="msg-t"><a href="${ctx }/wechatNewsItem/editMore?dbid=${wechatNewsTemplate.dbid}" class="i-title" >${wechatNewsItem.title }</a></h4>
		                    <p class="msg-meta"><span class="msg-date">${fn:substring(wechatNewsTemplate.addtime,0,10) }</span></p>
		                    <div class="cover">
		                      <p class="default-tip" style="display:none">封面图片</p>
		                      <img src="${wechatNewsItem.thumbUrl }" class="i-img" style=""> </div>
		                    <p class="msg-text"></p>
		                  </div>
	                  </c:if>
	                  <c:if test="${status==false }">
		                  <div class="rel sub-msg-item appmsgItem"> 
		                  	<span class="thumb"> <img src="${wechatNewsItem.thumbUrl }" class="i-img" style=""> </span>
		                    <h4 class="msg-t"> <a href="${ctx }/wechatNewsItem/editMore?dbid=${wechatNewsTemplate.dbid}"  class="i-title">${wechatNewsItem.title }</a> </h4>
		                  </div>
                      </c:if>                                  	   
	               </c:forEach>
               </div>
                <div class="msg-opr">
                  <ul class="f0 msg-opr-list">
                    <li class="b-dib opr-item"><a class="block tc opr-btn edit-btn" href="${ctx }/wechatNewsItem/editMore?dbid=${wechatNewsTemplate.dbid}"><span class="th vm dib opr-icon edit-icon">编辑</span></a></li>
                      <li class="b-dib opr-item"><a class="block tc opr-btn del-btn" href="javascript:void(-1)" onclick="$.utile.deleteById('${ctx}/wechatNewsItem/delete?dbids=${wechatNewsTemplate.dbid}','searchPageForm')" data-rid="7200"><span class="th vm dib opr-icon del-icon">删除</span></a></li>
                  </ul>
                </div>
              </div>
         </c:if>
	 </c:forEach>	   
  	  <!-- list结束 -->
  </div>
</div>
	<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
	<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
	<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
	<script src="${ctx }/widgets/bootstrap3/jquery.dataTables.min.js"></script>
	<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
	<script src="${ctx }/widgets/bootstrap3/unicorn.tables.js"></script>
	<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
	<script src="${ctx }/wxcss/js/global.js"></script>
</body>
</html>
