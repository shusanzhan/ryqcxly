<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="description" content="Common Buttons &amp; Icons" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

	<!-- bootstrap & fontawesome -->
	<link rel="stylesheet" href="${ctx}/assets/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${ctx}/assets/css/font-awesome.min.css" />
	<!-- page specific plugin styles -->
	<!-- text fonts -->
	<link rel="stylesheet" href="${ctx}/assets/css/ace-fonts.css" />
	<!-- ace styles -->
	<link rel="stylesheet" href="${ctx}/assets/css/ace.min.css" id="main-ace-style" />

	<!--[if lte IE 9]>
		<link rel="stylesheet" href="${ctx}/assets/css/ace-part2.min.css" />
	<![endif]-->
	<link rel="stylesheet" href="${ctx}/assets/css/ace-skins.min.css" />
	<link rel="stylesheet" href="${ctx}/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
	<!--[if lte IE 9]>
	  <link rel="stylesheet" href="${ctx}/assets/css/ace-ie.min.css" />
	<![endif]-->

	<!-- inline styles related to this page -->

	<!-- ace settings handler -->
	<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx}/assets/js/ace-extra.min.js"></script>

	<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

	<!--[if lte IE 8]>
	<script src="${ctx}/assets/js/html5shiv.min.js"></script>
	<script src="${ctx}/assets/js/respond.min.js"></script>
	<![endif]-->
</head>
<body>
<div class="main-content">
				<!-- #section:basics/content.breadcrumbs -->
				<div class="breadcrumbs" id="breadcrumbs">
					<script type="text/javascript">
						try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
					</script>

					<ul class="breadcrumb">
						<li>
							<i class="ace-icon fa fa-home home-icon"></i>
							<a href="#">主页</a>
						</li>
						<li class="active">客户验证</li>

					</ul><!-- /.breadcrumb -->
				</div>

				<!-- /section:basics/content.breadcrumbs -->
				<div class="page-content">
					<!-- /section:settings.box -->
					<div class="page-content-area">
						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<div class="row" style="margin-top: 32px;">
									<input type="text" name="mobilePhone" id="mobilePhone" placeholder="请输入电话号码" style="width: 260px;" onchange="$('#customerName').val(this.value)" >
									<input type="hidden" name="customerRecordId" id="customerRecordId" value="${param.customerRecordId }" style="width: 260px;">
									<a id="searchPageForm" class="btn btn-info" type="button" onclick="submitFrm()">
										<i class="ace-icon fa fa-check bigger-110"></i>
										验证
									</a>
								</div>
								<div class="space"></div>

						</div><!-- /.row -->
					</div><!-- /.page-content-area -->
				</div><!-- /.page-content -->
			</div>
			</div>
<!--[if !IE]> -->
<div style="display: none; width: 340px;" id="templateId">
<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;">
	<tr style="height: 60px;" height="60">
			<td class="formTableTdLeft" width="120">到店成交:&nbsp;</td>
			<td colspan="3">
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="1">到店成交</label>
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="2">到店未成交</label>
			</td>
		</tr>
	</table>
</div>

<div style="display: none; width: 340px;" id="template2Id">
	<table id="noLine" border="0"  cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;text-align: left;margin-left: 5px;float: left;">
		<tr style="height: 60px;" height="60">
			<td class="formTableTdLeft" width="120">到店成交:&nbsp;</td>
			<td colspan="3">
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="1">到店成交</label>
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="2">到店未成交</label>
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript">
window.jQuery || document.write("<script src='${ctx}/assets/js/jquery.min.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${ctx}/assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
if('ontouchstart' in document.documentElement) document.write("<script src='${ctx}/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="${ctx}/assets/js/bootstrap.min.js"></script>

<!-- page specific plugin scripts -->

<!-- ace scripts -->
<script src="${ctx}/assets/js/ace-elements.min.js"></script>
<script src="${ctx}/assets/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
jQuery(function($) {
	$('#loading-btn').on(ace.click_event, function () {
		var btn = $(this);
		btn.button('loading')
		setTimeout(function () {
			btn.button('reset')
		}, 2000)
	});

	$('#id-button-borders').attr('checked' , 'checked').on('click', function(){
			$('#default-buttons .btn').toggleClass('no-border');
	});
})
</script>

<!-- the following scripts are used in demo only for onpage help and you don't need them -->
<script type="text/javascript"> ace.vars['base'] = '..'; </script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
/**
 * 功能：判断手机号码
 */
function checkMobilePhone(value) {
	if (value.length == 0)
		return false;
	var valid = false;
	valid = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/.test(value);
	return valid;
}
function submitFrm(){
	var mobilePhone=$("#mobilePhone").val();
	var customerRecordId=$("#customerRecordId").val();
	var st=checkMobilePhone(mobilePhone);
	var customerRecordId="${param.customerRecordId }";
	if(st==true){
		$.post('${ctx}/custCustomer/ajaxValidateMember?mobilePhone='+mobilePhone+"&customerRecordId="+customerRecordId,{},function(json){
			var data=json.state;
			if(data==1||data=="1"){
				window.location.href='${ctx }/custCustomer/validateMember?customerRecordId='+customerRecordId;
			}
			if(data==2||data=="2"){
				window.location.href='${ctx }/custCustomer/addShoppingRecord?customerRecordId='+customerRecordId+"&mobilePhone="+mobilePhone;
			}
			if(data==3||data=="3"){
				window.top.art.dialog({
					content : json.message,
					icon : 'question',
					width:"320px",
					height:"120px",
					lock : true,
					cancel : true
				})
			}
			if(data==4||data=="4"){
				window.top.art.dialog({
					content : '系统已经存在【'+json.mobilePhone+'】客户，点击【确定】继续完成到店记录填写。',
					icon : 'question',
					width:"320px",
					height:"120px",
					lock : true,
					ok : function() {
						//$.utile.openDialog('${ctx}/customerTrack/add?customerId='+json.dbid+'&typeRedirect=5&customerRecordId='+customerRecordId,'添加跟进记录',900,500);
						comeShopeRecord(json.dbid,customerRecordId);
					},
					cancel : true
				})
			}
			if(data==5||data=="5"){
				window.top.art.dialog({
					content : json.message,
					icon : 'question',
					width:"320px",
					height:"120px",
					lock : true,
					cancel : true
				})
			}
			if(data==6||data=="6"){
				window.top.art.dialog({
					content : "该电话号码销售顾问已登记，点击【确定】继续填网销邀约到店谈判记",
					icon : 'question',
					width:"320px",
					height:"120px",
					lock : true,
					ok : function() {
						customerRecordResult(customerRecordId,json.messageHtml);
					},
					cancel : true
				})
			}
		})
	}else{
		$("#mobilePhone").focus();
		alert("输入电话号码格式有误！");
	}
}
document.onkeydown=function(event){ 
	 e = event ? event :(window.event ? window.event : null); 
	 if(e.keyCode==13){ 
		 if(e.keyCode==13){
			 submitFrm();
		 }
	 } 
}  
function comeShopeRecord(customerId,customerRecordId){
	top.art.dialog({
	    title: '客户到店登记',
	    content: document.getElementById('templateId'),
	    lock : true,
		fixed : true,
	    ok: function () {
	    	var comeShopeStatus=window.parent.document.getElementsByName("comeShopeStatus");
	    	var selectvalue="";   //  selectvalue为radio中选中的值
            for(var i=0;i<comeShopeStatus.length;i++){
                if(comeShopeStatus[i].checked==true) {
                	selectvalue=comeShopeStatus[i].value; 
               }
            }
	    	if(null==selectvalue||selectvalue==''){
	    		alert("请选择到店成交状态！");
	    		return false;
	    	}
    		var url='${ctx}/custCustomer/comeShopRecord?customerId='+customerId+'&comeShopeStatus='+selectvalue+"&redirectType=1&customerRecordId="+customerRecordId;
    		window.location.href=url;
			return true;
	    },
	    cancel:function(){
			return true;
	    }
	});
}
function customerRecordResult(customerRecordId,content){
	art.dialog({
	    title: '谈判结果',
	    content: content,
	    width:550,
	    height:240,
		fixed : true,
	    ok: function () {
	    	var doms = document.getElementsByName("customerIdValue");
	    	var customerId=0;
	    	var j=0;
	    	for ( var i = 0; i < doms.length; i++) {
    			if(doms[i].checked){
        			j=i;
        			customerId=doms[i].value;
    			}
	    	}
	    	var customerName=window.document.getElementsByName("customerName")[j].value;
	    	if(customerName==undefined||customerName==''){
		    	alert("请选择要登记客户");
		    	return false;
		    }
		    if(confirm("确定登记【"+customerName+"】客户客户谈判记录吗？")){
		    	$("#customerName2").val(customerName);
		    	comeShopeRecord2(customerId,customerRecordId,1);
			}
			return true;
	    },
	    cancel:function(){
			return true;
	    }
	});
}
function comeShopeRecord2(customerId,customerRecordId,type){
	if(type==undefined||type==''){
		$("#infor").hide();
	}else{
		$("#infor").show();
	}
	top.art.dialog({
	    title: '客户到店登记',
	    content: document.getElementById('template2Id'),
	    lock : true,
	    width:460,
	    height:200,
		fixed : true,
	    ok: function () {
	    	var comeShopeStatus=window.parent.document.getElementsByName("comeShopeStatus");
	    	var selectvalue="";   //  selectvalue为radio中选中的值
            for(var i=0;i<comeShopeStatus.length;i++){
                if(comeShopeStatus[i].checked==true) {
                	selectvalue=comeShopeStatus[i].value; 
               }
            }
	    	if(null==selectvalue||selectvalue==''){
	    		alert("请选择到店成交状态！");
	    		return false;
	    	}
    		var url='${ctx}/custCustomer/comeShopRecord?customerId='+customerId+'&comeShopeStatus='+selectvalue+"&redirectType=2&customerRecordId="+customerRecordId;
    		window.location.href=url;
			return true;
	    },
	    cancel:function(){
			return true;
	    }
	});
}
</script>
			
</body>
</html>