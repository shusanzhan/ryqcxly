<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>公众账号设置添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap.min.css" />
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx }/wxcss/css/block.css"/>
<link rel="stylesheet" href="${ctx }/wxcss/css/block-mul.css"/>
<link rel="stylesheet" href="${ctx }/wxcss/css/global.css?da=${now}"/>
<link rel="stylesheet" href="${ctx }/wxcss/css/font-awesome.min.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
.uploadImage{
	display:block;
	margin-top: 5px;
}
#cboxClose {
    background-color: #000;
    border: 2px solid #fff;
    border-radius: 32px;
    color: #fff;
    font-size: 21px;
    height: 28px;
    margin-left: -15px;
    position: absolute;
    top: 14px;
    width: 28px;
    display: none;
}
</style>
</head>
<body>
<h4 class="headline"><i class="fa fa-home"></i> 新增多图文 <span class="line"></span> </h4>
<div class="block-wrap">
	<div class="pull-left msg-preview" style="width:330px">
      <div class="msg-item-wrapper">
	        <div id="appmsgItem1" class="appmsgItem msg-item">
		          <p class="msg-meta"> <span class="msg-date"></span> </p>
		          <div class="cover">
			            <p class="default-tip" style="">封面图片</p>
			            <h4 class="msg-t"> <span class="i-title">标题</span> </h4>
			            <ul class="abs tc sub-msg-opr">
			              <li class="b-dib sub-msg-opr-item"> <a href="javascript:;" class="th opr-icon edit-icon">编辑</a> </li>
			            </ul>
			            <img class="i-img" src="" style="display:none"> 
		          </div>
		          <p class="msg-text"></p>
		          <input type="hidden" class="rid">
		          <input type="hidden" class="title">
		          <input type="hidden" class="author">
		          <input type="hidden" class="cover">
		          <input type="hidden" class="cover_url">
		          <input type="hidden" class="cover_show" value="1">
		          <textarea class="content" style="display: none;"></textarea>
		          <input type="hidden" class="from_url">
	        </div>
	        <div class="rel sub-msg-item appmsgItem"> 
	        	<span class="thumb"> 
	        		<span class="default-tip" style="">缩略图</span> 
	        		<img src="" class="i-img" style="display:none"> 
	        	</span>
	          <h4 class="msg-t"> 
	          	<span class="i-title">标题</span> 
	          </h4>
	          <ul class="abs tc sub-msg-opr">
	            <li class="b-dib sub-msg-opr-item"> <a href="javascript:;" class="th opr-icon edit-icon">编辑</a> </li>
	            <li class="b-dib sub-msg-opr-item"> <a href="javascript:;" class="th opr-icon del-icon">删除</a> </li>
	          </ul>
	          <input type="hidden" class="rid">
	          <input type="hidden" class="title">
	          <input type="hidden" class="author">
	          <input type="hidden" class="cover">
	          <input type="hidden" class="cover_url">
	          <input type="hidden" class="cover_show" value="1">
	          <textarea class="content" style="display: none;"></textarea>
	          <input type="hidden" class="from_url">
	        </div>
        	<div class="sub-add"> <a href="javascript:;" class="block tc sub-add-btn"> <span class="vm dib sub-add-icon"></span>增加一条</a> </div>
      </div>
    </div>
    <div class="pull-left" >
      <div class="msg-editer-wrapper" style="width: 770px;">
        <div class="msg-editer">
          <form id="appmsg-form" method="post" class="form" enctype="multipart/form-data">
	          <input id="action" name="action" type="hidden" value="add" />
	           <input type="hidden" name="type" id="type" value="2">
	          <div class="msg-content" style="width: 100%;">
		            <label>标题<span class="maroon">*</span><span class="help-inline">(不能超过64个字)</span></label>
		            <div class="msg-item msg-input">
		                <input type="text" id="title" name="title" class="ui-input" />
		            </div>
		            <label>作者<span class="help-inline">(选填)</span></label>
		            <div class="msg-item msg-input">
		                <input type="text" id="author" name="author" class="ui-input" />
		            </div>
		            <label>封面<span class="maroon">*</span><span class="help-inline">(必须上传一张图片,图片大小150*150)</span></label>
		            <div class="msg-item msg-input">
		                <div class="cover-area">
		                  <div class="cover-hd">
		                      	<a  href="#modal-add-event" class="btn btn-success btn-mini " onclick="uploadFile('showPciture','imgShowPciture',false)"><i class="icon-plus icon-white"></i>上传图片</a>
								<input class="input-medium" style="display: none;" type="text" readonly="readonly" name="product.showPciture" id="showPciture" value="${product.showPciture }" />
								<div id="imgArea" class="uploadImage">
									<img alt="" title="" class="cover_url" id="imgShowPciture" src="${product.showPciture  }" width="146" height="146"></img>
									<button type="button" id="cboxClose" class="cboxClose" title="点击删除图片">×</button>
								</div>
		                  </div>
		                  <p id="imgArea" class="cover-bd" style="display:none;">
		                    <img src="" id="img">
		                    <a href="javascript:;" class="vb cover-del" id="delImg">删除</a>
		                  </p>
		                  <label class="checkbox inline"><input type="checkbox" id="cover_show" name="cover_show" value="1" checked="checked"><span class="help-inline" style="line-height: 32px;">封面图片显示在正文中 </span> </label>
		                </div>
		            </div>
		            <label>正文<span class="maroon">*</span><span class="help-inline">(不能超过20000个字)</span></label>
		            <div class="msg-item msg-text">
						<textarea name="contentArea" id="content" class="editor"><p>这是正文</p></textarea>
		            </div>
		            <a id="url-block-link" class="block mt10 mb10">添加原文链接</a>
		            <div id="url-block" style="display:none;">
		              <label>原文链接<span class="help-inline">(请输入正确的URL链接格式)</span></label>
		              <div class="msg-item msg-input">
		                  <input id="from_url" type="text" class="ui-input" name="from_url" />
		              </div>
		            </div>
		            <div class="msg-item msg-button">
		                <input type="submit" class="btn btn-primary" id="save-btn" value="保  存">
		            </div>
	          </div>
          </form>
        </div>
      </div>  
      <span class="abs msg-arrow a-out" style="margin-top: 0px;"></span> 
      <span class="abs msg-arrow a-in" style="margin-top: 0px;"></span>          
    </div>
</div>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.cookie.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script src="${ctx }/wxcss/js/global.js"></script>
<script src="${ctx }/wxcss/js/weixin.block.mul.js"></script>
<script src="${ctx }/wxcss/js/jquery.json-2.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//富文本插件
	var editor=CKEDITOR.replace("content");
	$("#cboxClose").bind("click",function(){
		$(".default-tip", window.appmsg).show();
		$("#imgArea").hide();
		$(".cover_url", window.appmsg).val("");
		$(".i-img", window.appmsg).hide();
		$(".cboxClose", window.appmsg).hide();
	})
});
/* $(window).bind('beforeunload',function(){
    return '您输入的内容尚未保存，确定离开此页面吗？';
}); */
function uploadFile(fileUrl,imgeUrl,numState){
	var path="";
	var state=false;
	if(numState==true){
		state=true;
	}
	art.dialog.open(path+'/compoent/uploadConpent?numState='+state, {
	    title: '上传图片',
	    width:"690px",height:"400px",
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
	       var fileUpload= iframe.document.getElementById('fileUpload').value;
	       if(null!=fileUpload&&fileUpload.length>0){
		        $("#"+fileUrl).val(fileUpload);
		        if(null!=imgeUrl&&imgeUrl!=undefined){
		        	 //关闭
			        $("#cboxClose").show();
			        $(".default-tip", window.appmsg).hide();
	    			$(".i-img", window.appmsg).attr("src", fileUpload).show();
	    			$(".default-tip", window.appmsg).hide();
	    			$(".i-img", window.appmsg).attr("src", fileUpload).show();
	    			$("#imgArea").show().find("#imgShowPciture").attr("src", fileUpload);
	    			$(".cover_url", window.appmsg).val(fileUpload);
		        }
		       	return true;
	       }else{
	    	   alert("请选择图片后点击【确定】按钮");
	    	   return false;
	       }
	    },
	    cancel: true
	});
}
</script>
</body>
</html>
