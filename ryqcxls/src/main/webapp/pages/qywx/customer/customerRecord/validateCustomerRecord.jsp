<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>线索验证</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
	.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
.form-inline tr{
	height: 45px;
}
</style>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">线索验证</span>
</div>
<br>
<br>
<br>
<div class="form-group" >
  <label class="control-label" for="inputWarning1">客户电话</label  >
  	<form action="" id="frmId" name="frmId"></form>
	<input type="hidden" name="customerRecordId" id="customerRecordId" value="${param.customerRecordId }" style="width: 260px;">
	<input  type="tel"  class="form-control" id="mobilePhone" name="mobilePhone"   value="${customerRecord.mobilePhone }"  style="height: 50px;font-size: 16px;">
</div>
<input type="button" name="mobileCommit" value="验证" id="tele_register" class="addbutton" onclick="submitFrm('frmId')">
<br>
<br>
<br>
<br>
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
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function checkMobilePhone(value) {
	if (value.length == 0)
		return false;
	var valid = false;
	valid = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/.test(value);
	return valid;
}
function submitFrm(frmId){
	var mobilePhone=$("#mobilePhone").val();
	var customerRecordId=$("#customerRecordId").val();
	if(checkMobilePhone(mobilePhone)){
		$.post('${ctx}/qywxCustomerRecord/ajaxValidateMember?mobilePhone='+mobilePhone+"&customerRecordId="+customerRecordId,{},function(json){
			var data=json.state;
			if(data=="2"){
				window.location.href = "${ctx }/qywxCustomer/add?mobilePhone="+mobilePhone+"&customerRecordId="+customerRecordId;
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
						comeShopeRecord(json.dbid,customerRecordId)
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
			return;
		})
	}else{
		$("#mobilePhone").focus();
		alert("输入电话号码格式有误！");
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
    		var url='${ctx}/qywxCustomer/comeShopRecord?customerId='+customerId+'&comeShopeStatus='+selectvalue+"&redirectType=1&customerRecordId="+customerRecordId;
    		window.location.href=url;
			return true;
	    },
	    cancel:function(){
			return true;
	    }
	});
}
</script>
</html>