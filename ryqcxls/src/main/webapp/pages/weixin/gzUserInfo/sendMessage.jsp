<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>群发消息</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yz.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/qrCode.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yzbase.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yzsendmessage.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/artDialogMaster/css/ui-dialog.css">
<script src="${ctx }/widgets/artDialogMaster/lib/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack4.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
.clearfix{
		width: 99%;
	}
	.app-inner{
		margin: 0 0 0 1px;
	}
</style>
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
			<div class="page-with-sidebar-content">
				<div class="app__content js-app-main" style="width: 100%">
					<div class="weixin-mass" >
						<div class="form-horizontal form-task">
							<div class="clearfix">
						        <div class="control-group task-filter pull-left" style="padding-top: 12px;">
						            <label class="control-label">发送给：</label>
						            <div class="controls">
						                <div class="filter-tag">
						            	  <c:if test="${all==true }">
							                  <div class="filter-tag-name">所有人</div>
						                  </c:if>
						                	<c:if test="${param.type==1 }">
							                	<c:forEach var="weixinGzuserinfo" items="${weixinGzuserinfos }">
								                    <div class="filter-tag-name">${weixinGzuserinfo.nickname }</div>
							                	</c:forEach>
						                	</c:if>
						                	<c:if test="${param.type==2 }">
							                	<c:forEach var="selectParam" items="${selectParams }">
								                    <div class="filter-tag-name">${selectParam }</div>
							                	</c:forEach>
						                	</c:if>
						                    <a href="${ctx }/weixinGzUserInfo/queryList" class="edit-filter-tag">去筛选</a>
						                </div>
						                <c:if test="${all==false }">
							                <p class="help-desc">
							                    您正准备向 <span>${fn:length(weixinGzuserinfos) }</span> 人发送信息（非群发）
							                </p>
							                <c:if test="${fn:length(weixinGzuserinfos)>10000 }">
								                <p class="help-desc">
								                   图文消息的一次最多10000个,超出10000人员将分为多条发送
								                </p>
							                </c:if>
						                </c:if>
						                <c:if test="${all==true }">
						                	（群发）
						                </c:if>
						            </div>
						        </div>
						        <div class="common-helps-entry pull-right">
						        </div>
						    </div>
							<div id="js_msgSender" class="msg_sender" style="margin: 0 30px; border: 1px solid #e7e7eb; ">
								<div class="msg_tab">
									 <ul class="tab_navs">
									 	 <li class="tab_nav tab_appmsg width5 selected" style=" background-color: #fff;">
										    <a onclick="return false;" href="javascript:void(0);">&nbsp;<i class="icon_msg_sender"></i><span class="msg_tab_title">图文消息</span></a>
									    </li>
									    <li class="tab_nav tab_text width5 ">
										    <a onclick="return false;" href="javascript:void(0);">&nbsp;<i class="icon_msg_sender"></i><span class="msg_tab_title">文字</span></a>
									    </li>
									 </ul>
									 <div class="tab_panel">
									 	<div class="tab_content inner">
									 		<div class="js_appmsgArea inner" >
										 		<div class="tab_cont_cover jsMsgSendTab" data-index="0" id="tab_cont_cover" style="${empty(wechatNewsTemplate)==true?'':'display: none;' }">
										 			<div class="media_cover">
										 				<span class="create_access">
										 					<a class="add_gray_wrp jsMsgSenderPopBt" data-index="0" data-type="10" href="javascript:;" onclick="selectNewsItem('2332')">
										 						<i class="icon36_common add_gray"></i>
										 						<strong>从素材库中选择</strong>
										 					</a>
										 				</span>
										 			</div>
										 			<div class="media_cover">
										 				<span class="create_access">
										 					<a class="add_gray_wrp jsMsgSenderPopBt" onclick="window.location.href='${ctx }/wechatNewsItem/addMore'" data-index="0" data-type="10" href="javascript:;">
										 						<i class="icon36_common add_gray"></i>
										 						<strong>新建图文消息</strong>
										 					</a>
										 				</span>
										 			</div>
										 		</div>
										 		<c:if test="${!empty(wechatNewsTemplate)}">
										 			<c:if test="${wechatNewsTemplate.type==1 }">
												 	  <div class="msg-item-wrapper" id="msg-item-wrapper">
											               <div class="msg-item">
											                 <h4 class="msg-t"><a href="javascript:void(-1)" class="i-title" >${wechatNewsTemplate.title }</a></h4>
											                 <p class="msg-meta"><span class="msg-date">${fn:substring(wechatNewsTemplate.addtime,0,10) }</span></p>
											                 <c:forEach items="${wechatNewsTemplate.wechatNewsitems }" var="weixinNewsitem">
											                	 <div class="cover">
											                    <p class="default-tip" style="display:none">封面图片</p>
											                   	 	<img src="${weixinNewsitem.thumbUrl }" class="i-img" style=""> </div>
											                  	<p class="msg-text">${weixinNewsitem.digest }</p>
											                 </c:forEach>
											               </div>
											                <div class="appmsg_mask" style="display: none;"></div>
															<i class="icon_card_selected" style="display: none;">已选择</i>
											           </div>
											         </c:if>
											         <c:if test="${wechatNewsTemplate.type==2 }">
											         	<div class="msg-item-wrapper" id="msg-item-wrapper">
												                <div class="msg-item multi-msg">
												                	<c:forEach var="weixinNewsitem" items="${wechatNewsTemplate.wechatNewsitems }" varStatus="i">
												                		<c:if test="${i.index==0 }" var="status">
														                  <div class="appmsgItem">
														                    <h4 class="msg-t"><a href="javascript:void(-1)" class="i-title" >${weixinNewsitem.title }</a></h4>
														                     <p class="msg-meta"><span class="msg-date">${fn:substring(wechatNewsTemplate.addtime,0,10) }</span></p>
														                    <div class="cover">
														                      <p class="default-tip" style="display:none">封面图片</p>
														                      <img src="${weixinNewsitem.thumbUrl }" class="i-img" style=""> </div>
														                    <p class="msg-text"></p>
														                  </div>
													                  </c:if>
													                  <c:if test="${status==false }">
														                  <div class="rel sub-msg-item appmsgItem"> 
														                  	<span class="thumb"> <img src="${weixinNewsitem.thumbUrl }" class="i-img" style=""> </span>
														                    <h4 class="msg-t"> <a href="javascript:void(-1)"  class="i-title">${weixinNewsitem.title }</a> </h4>
														                  </div>
												                      </c:if>                                  	   
													               </c:forEach>
												               </div>
												              <div class="appmsg_mask" style="display: none;"></div>
												             <i class="icon_card_selected" style="display: none;">已选择</i>
											              </div>
											         </c:if>
											         <a  href="javascript:void(-1)" id="deleteMedia">删除</a>
										 		</c:if>
										 		<c:if test="${empty(wechatNewsTemplate) }">
											 		<div class="msg-item-wrapper" id="msg-item-wrapper" style="display: none;">
											 		</div>
										 			<a style="display: none;" href="javascript:void(-1)" id="deleteMedia">删除</a>
									 			</c:if>
									 		</div>
									 	</div>
									 	
									 	<div class="tab_content inner" style="display:none; padding: 0;">
									    	<div class="js_textArea inner no_extra">
										    	<div class="emotion_editor">
											    	<div contenteditable="true" onkeyup="sendText(this)" class="edit_area js_editorArea" style="overflow-y: auto; overflow-x: hidden;"></div>
												    <div class="editor_toolbar">
												        <!-- <a class="icon_emotion emotion_switch js_switch" href="javascript:void(0);">表情</a> -->
												        <p class="editor_tip js_editorTip" style="margin: 0">还可以输入<em>600</em>字</p>
												    </div>
												</div>
											</div>
									    </div>
									 </div>
								</div>
							</div>
							<div style="display: none; width: 540px;" id="templateId">
								<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;">
									<tr style="height: 40px;" height="20">
										<td id="messageError" colspan="3" style="text-align: left;color: red;" width="280">
											关注公众号后，才能接收图文消息预览
										</td>
									</tr>
									<tr style="height: 40px;" height="30" id="imageTr">
										<td colspan="3" style="text-align: left;" width="280">
											<input type="text" id="wechatId" name="wechatId" value="" placeholder="请输入微信号/QQ号/手机号" style="width: 320px;">
										</td>
									</tr>
									<tr style="height: 20px;" height="20">
										<td id="messageError" colspan="3" style="text-align: left;display: none;color: red;" width="280">
											填写名称错误！
										</td>
									</tr>
								</table>
							</div>
							<div id="js_msgSender" class="msg_sender" style="margin: 0 30px;margin-top:30px; border: 0px  ">
									<a href="javascript:void(-1)" class="btn btn-primary"	onclick="if(valid()){$.utile.submitForm('frmId','${ctx}/wechatSendMessage/save')}">
										群发</a>
									<a class="btn btn-success" onclick="preview()">
										预览
									</a> 
									<a class="btn btn-inverse" onclick="window.history.go(-1)">
										返回
									</a>
							</div>
							<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
								<c:if test="${empty(wechatNewsTemplate) }">
									<input type="hidden" value="" id="newsItemTemplateId" name="newsItemTemplateId">
								</c:if>
								<c:if test="${!empty(wechatNewsTemplate) }">
									<input type="hidden" value="${wechatNewsTemplate.dbid }" id="newsItemTemplateId" name="newsItemTemplateId">
								</c:if>
								<input type="hidden" value="${openIds }" id="openIds" name="openIds" >
								<c:if test="${all==true }">
									<input type="hidden" value="1" id="sendType" name="sendType" >
								</c:if>
								<c:if test="${all==false }">
									<input type="hidden" value="3" id="sendType" name="sendType" >
								</c:if>
								<input type="hidden" value="mpnews" id="msgType" name="msgType" >
								<input type="hidden" value="" id="content" name="content" >
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript">
function valid(){
	var openIds=$("#openIds").val();
	var msgType=$("#msgType").val();
	var content=$("#content").val();
	if(null==openIds||openIds==''){
		alert("请选择用户组或推广渠道");
		return false;
	}
	/* if(null!=groupId&&groupId==''){
		alert("请选择用户组");
		return false;
	} */
	if(msgType=='mpnews'){
		if(null!=newsItemTemplateId&&newsItemTemplateId==''){
			alert("请选择发送内容");
			return false;
		}
	}
	if(msgType=='text'){
		if(null!=content&&content==''){
			alert("请填写发送内容!");
			return false;
		}
	}
	return true;
}
function sendText(v){
	var content=$(v).text();
	var length=content.length;
	if(600-length>0){
		var html=$(".js_editorTip").html();
		if(html.indexOf("超过")!=-1){
			html=html.replace("已经超过","还可以输入");
			$(".js_editorTip").text("");
			$(".js_editorTip").append(html);
		}
		$(".js_editorTip").find("em").css("color","").text(600-length);
	}else{
		var html=$(".js_editorTip").html();
		if(html.indexOf("输入")!=-1){
			html=html.replace("还可以输入","已经超过");
			$(".js_editorTip").text("");
			$(".js_editorTip").append(html);
		}
		$(".js_editorTip").find("em").css("color","red").text(length-600);
	}
	$("#content").val("");
	$("#content").val(content);
}
$().ready(function() {
	var message="${message}";
	if(null!=message&&message!=""){
		alert(message);
		window.history.go(-1);
		return false;
	}
	$("#deleteMedia").bind("click",function(){
		 $("#tab_cont_cover").show();
        $("#deleteMedia").hide();
        $("#msg-item-wrapper").hide();
        $("#msg-item-wrapper").text("");
	})
	$(".tab_navs").find("li").each(function(i){
		$(this).bind("click",function(){
			$(".selected").removeClass("selected");
			if(i==0){
				$("#msgType").val("");
				$("#msgType").val("mpnews");
			}
			if(i==1){
				$("#msgType").val("");
				$("#msgType").val("text");
			}
			$(this).addClass("selected");
			$(".tab_content").each(function(j){
				if(i==j){
					$(this).show();
				}else{
					$(this).hide();
				}
			})
		})
	})
});
function selectGroup(groupid,name){
	var html=name+"<span class=\"caret\"></span>";
	$("#addToGrop").text("");
	$("#addToGrop").append(html);
	$("#groupId").val("");
	$("#groupId").val(groupid);
}
function selectSpreadDetail(spreadDetailId,name){
	var html=name+"<span class=\"caret\"></span>";
	$("#addToSpreadDetail").text("");
	$("#addToSpreadDetail").append(html);
	$("#spreadDetailId").val("");
	$("#spreadDetailId").val(spreadDetailId);
}
function selectNewsItem(tempId){
	var path="";
	art.dialog.open('${ctx}/wechatSendMessage/selectNewsItem', {
	    title: '选择素材',
	    width:"1024px",
	    height:"520px",
	    lock : true,
		fixed : true,
	    init: function () {
	    	var iframe = this.iframe.contentWindow;
	    	var top = art.dialog.top;// 引用顶层页面window对象
	    },
	    ok: function () {
	    	var iframe = this.iframe.contentWindow;
	    	if (!iframe.document.body) {
	        	alert('iframe还没加载完毕呢')
	        	return false;
	        };
	       var newsItem= iframe.document.getElementById('newsItem').value;
	       var newsItemTemplateId= iframe.document.getElementById('newsItemTemplateId').value;
	       if(null!=newsItemTemplateId&&newsItemTemplateId.length>0){
		        $("#tab_cont_cover").hide();
		        $("#deleteMedia").show();
		        $("#msg-item-wrapper").show();
		        $("#msg-item-wrapper").append(newsItem);
		        $("#newsItemTemplateId").val(newsItemTemplateId);
		    	$(".msg-item-wrapper").find(".appmsg_mask").remove();
				$(".msg-item-wrapper").find(".icon_card_selected").remove();
		       	return true;
	       }else{
	    	   alert("请选择素材后点击【确定】按钮");
	    	   return false;
	       }
	    },
	    cancel: true
	});
}
function preview(){
	if(validPreview()==false){
		return ;
	}
	top.art.dialog({
	    title: '设置图片名称',
	    content: document.getElementById('templateId'),
	    lock : true,
		fixed : true,
	    ok: function () {
	    	var wechatId=window.parent.document.getElementById("wechatId").value;
	    	var newsItemTemplateId=window.document.getElementById("newsItemTemplateId").value;
	    	var msgType=window.document.getElementById("msgType").value;
	    	var content=window.document.getElementById("content").value;
	    	if(null==wechatId||wechatId==''){
	    		$(window.parent.document.getElementById("imageTr")).css("color","red");
	    		$(window.parent.document.getElementById("imageTr")).find("input").css("border-color","red");
	    		$(window.parent.document.getElementById("messageError")).show();
	    		return false;
	    	}
	    	var url='${ctx}/wechatSendMessage/preview';
	    	var params={"wechatId":wechatId,"newsItemTemplateId":newsItemTemplateId,"msgType":msgType,"content":content};
	    	$.post(url,params,function callBack(data) {
				if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
					$.utile.tips(data[0].message);
					return true;
				}
				if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
					$.utile.tips(data[0].message);
					// 保存失败时页面停留在数据编辑页面
				}
			});
    		
			
	    },
	    cancel:function(){
			return true;
	    }
	});
}
function validPreview(){
	var msgType=$("#msgType").val();
	var newsItemTemplateId=$("#newsItemTemplateId").val();
	var content=$("#content").val();
	if(msgType=='mpnews'){
		if(null!=newsItemTemplateId&&newsItemTemplateId==''){
			alert("请选择发送内容");
			return false;
		}
	}
	if(msgType=='text'){
		if(null!=content&&content==''){
			alert("请填写发送内容!");
			return false;
		}
	}
	return true;
}
</script>
</body>
</html>
