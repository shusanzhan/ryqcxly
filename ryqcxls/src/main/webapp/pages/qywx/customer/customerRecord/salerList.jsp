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
<link rel="stylesheet" type="text/css" href="${ctx }/widgets/iscroll/scrollbar.css">
<script type="application/javascript" src="${ctx }/widgets/iscroll/iscroll.js"></script>
<title>我的线索列表</title>
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
#wrapper {
	position:absolute; z-index:1;
	top:60px; 
	bottom:48px; left:0;
	width:100%;
	overflow:auto;
}
</style>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">我的线索</span>
      <a class="go_home" href="${ctx }/qywxCustomer/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<c:if test="${empty(page.result)||fn:length(page.result)<=0 }" var="status">
	您还未添加线索！
</c:if>
<c:if test="${status==false }">
	<div style="line-height: 40px;width: 96%;margin: 0 auto;font-size: 16px;">
		<div class="title" align="left">
			查询总数数据   ${page.totalCount} 条
		</div>
	</div>
</c:if>
<c:if test="${status==false }">
	<c:forEach items="${page.result }" var="customerRecord">
		<div class="orderContrac">
			<div class="title" align="left">
				
				<c:if test="${empty(customerRecord.name) }">
					客户：	
					<c:if test="${empty(customerRecord.customer.name) }">
						无
					</c:if>
					<c:if test="${!empty(customerRecord.customer.name) }">
						${customerRecord.customer.name }
					</c:if>
				</c:if>
				<c:if test="${!empty(customerRecord.name) }">
					客户：	${customerRecord.name }<br>
					联系电话：<a href="tel:${customerRecord.mobilePhone }">${customerRecord.mobilePhone }</a><br>
					所在区域：${customerRecord.address }
				</c:if><br>
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href='${ctx}/qywxCustomerRecord/view?dbid=${customerRecord.dbid }&type=1'">
				<div style="color:#8a8a8a;padding-left: 5px; ">
					登记日期：<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd"/><br/>
					<c:if test="${!empty(customerRecord.agentUser) }">
					代办：${customerRecord.agentUser.realName}[代办]<br>
					</c:if>
		  			线索类型：
					${customerRecord.customerType.name }
					<br>
					车型：
					<c:if test="${empty(customerRecord.brand) }">
						<c:if test="${empty(customerRecord.carModels)}">
							-
						</c:if>
						<c:if test="${!empty(customerRecord.carModels)}">
							${customerRecord.carModels }
						</c:if>
					</c:if>
					${customerRecord.brand.name }
					${customerRecord.carSeriy.name }
					${customerRecord.carModel.name }${customerRecord.carModelStr}
					<br>
					进店/来电时间：
					<c:if test="${customerRecord.customerType.dbid!=1 }">
						<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/> 
					</c:if>
					<c:if test="${customerRecord.customerType.dbid==1 }">
						${customerRecord.comeInTime}
					</c:if>
					进店人数：
						<c:if test="${customerRecord.customerType.dbid!=1 }">
							?
						</c:if>
						<c:if test="${customerRecord.customerType.dbid==1 }">
							${customerRecord.customerNum}
							人
						</c:if>
					<br>
					信息来源：${customerRecord.customerInfrom.name }
					<br>
					线索状态：
					<c:if test="${customerRecord.resultStatus==2 }">
						<span style="color: green;">转为登记</span>
					</c:if>
					<c:if test="${customerRecord.resultStatus==1 }">
						<span style="color: pink;">等待...</span>
					</c:if>
					<c:if test="${customerRecord.resultStatus==3 }">
						<span style="color: red;">无效</span>
					</c:if>
					<c:if test="${customerRecord.resultStatus==4 }">
						<span style="color: green;">已绑定</span>
					</c:if><br>
					来店次数：
					<c:if test="${customerRecord.comeinNum==0 }">
						未到店
					</c:if>
					<c:if test="${customerRecord.comeinNum==1 }">
						初次到店
					</c:if>
					<c:if test="${customerRecord.comeinNum==2 }">
						二次来店
					</c:if>
					 <br/>
					 备注：
					${customerRecord.note }
					<br>
				</div>
			</div>
			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;height: 30px;line-height: 30px;">
				<c:if test="${customerRecord.resultStatus==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="vlidateCustomer(${customerRecord.dbid},${customerRecord.customerType.dbid})">转登记</a> 
						|
					<a href="${ctx }/qywxCustomerRecord/invalid?dbid=${customerRecord.dbid}" class="aedit" >线索无效</a>
				</c:if>
				<c:if test="${customerRecord.resultStatus==1 }">
					<c:if test="${sessionScope.user.dbid==customerRecord.user.dbid}">
						| <a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/qywxCustomerRecord/salerEdit?dbid=${customerRecord.dbid}'">编辑</a> 
					</c:if>
				</c:if>
				<c:if test="${customerRecord.resultStatus==2 }">
					<span style="color: green;">已登记</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==3 }">
					<span style="color: green;">已回访</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==4 }">
					<span style="color: red;">线索无效</span>
				</c:if>
			</div>
		</div>
	</c:forEach>
</c:if>
<div style="text-align: center;">
	<jsp:include page="${ctx }/pages/commons/wechatPage.jsp"></jsp:include>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxCustomerRecord/querySalerList" name="searchPageForm" id="searchPageForm" method="post">
      	<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
      	 <table>
      	 	<tr height="">
      	 		<td width="60"><label for="exampleInputName2">类型</label></td>
      	 		<td width="240">
	      	 		<select class="form-control " id="customerTypeId" name="customerTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<c:forEach var="customerType" items="${customerTypes }">
							<option value="${customerType.dbid }" ${param.customerTypeId==customerType.dbid?'selected="selected"':'' } >${customerType.name }</option>
						</c:forEach>
					</select>
			    </td>
      	 	</tr>
      	 	
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">来店次数</label></td>
      	 		<td width="240" id="carSeriyDiv">
	      	 		<select class="form-control" id="comeinNum" name="comeinNum" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="0" ${param.comeinNum==0?'selected="selected"':'' } >未到店</option>
						<option value="1" ${param.comeinNum==1?'selected="selected"':'' } >初次来店</option>
						<option value="2" ${param.comeinNum==2?'selected="selected"':'' } >2次来店</option>
					</select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">处理状态</label></td>
      	 		<td width="240" id="carModelDiv">
	      	 		<select class="form-control" id="resultStatus" name="resultStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.resultStatus==1?'selected="selected"':'' } >待处理</option>
						<option value="2" ${param.resultStatus==2?'selected="selected"':'' } >转为登记</option>
						<option value="3" ${param.resultStatus==3?'selected="selected"':'' } >无效</option>
					</select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">姓名</label></td>
      	 		<td width="240">
      	 			<input type="text" class="form-control" id="name" name="name" value="${param.name }">
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">电话</label></td>
      	 		<td width="240">
      	 			<input type="text" class="form-control" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }">
			    </td>
      	 	</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#currentPage').val(1);$('#searchPageForm')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
<div style="display: none; width: 320px;" id="template2Id">
	<table id="noLine" border="0"  cellpadding="0" cellspacing="0" style="width: 300px;margin-top: 5px;text-align: left;margin-left: 5px;float: left;">
		<tr style="height: 60px;" height="60">
			<td class="formTableTdLeft" width="120">到店成交:&nbsp;</td>
			<td colspan="3">
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="1">到店成交</label>
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="2">到店未成交</label>
			</td>
		</tr>
	</table>
</div>
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
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function showSearch(){
	$('.modal-dialog').css({  
        'margin-top':'0','width':'100%','height':'100%'
    });  
	$('.modal-content').css({'border-radius':'0','box-shadow':'0 0 rgba(0, 0, 0, 0.5)'});
	$('#exampleModal').modal();
}
$(function () {
})
function ajaxCarSeriy(val){
		if(val==''||val==undefined){
			$("#carModelId").attr("disabled",true);
			$("#carModelId option").remove(); 
			$("#carModelId").append("<option value=''>请选择...</option>");  
			$("#carSeriyId").attr("disabled",true);
			$("#carSeriyId option").remove(); 
			$("#carSeriyId").append("<option value=''>请选择...</option>"); 
		}else{
			$("#carSeriyId").remove();
			$("#carModelId").attr("disabled",true);
			$("#carModelId option").remove(); 
			$("#carModelId").append("<option value=''>请选择...</option>"); 
			$.post("${ctx}/customerRecordWechat/ajaxCarSeriyContent?brandId="+val+"&dateTime="+new Date(),{},function (data){
				if(data!="error"){
					$("#carSeriyDiv").append(data);
				}
			});
		}
	}

function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/customerRecordWechat/ajaxCarModelBySeriyContent?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelDiv").append(data);
		}
	});
}
</script>
<script type="text/javascript">
function vlidateCustomer(customerRecordId,type){
	$.post('${ctx}/qywxCustomerRecord/vlidateCustomer?customerRecordId='+customerRecordId+'&dateTime='+new Date(),{},function(json){
		var data=json.state;
		if(data==1||data=="1"){
			//进店客户
			window.location.href='${ctx }/qywxCustomerRecord/validateCustomerRecord?customerRecordId='+customerRecordId;
		}
		if(data==2||data=="2"){
			//新增客户
			window.location.href='${ctx }/qywxCustomer/add?customerRecordId='+customerRecordId;
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
					if(type==1){
						comeShopeRecord(json.dbid,customerRecordId);
					}else{
						window.location.href='${ctx}/qywxCustomerTrack/add?customerId='+json.dbid+'&typeRedirect=4&customerRecordId='+customerRecordId;
					}
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
				height:"120px",
				lock : true,
				ok : function() {
					customerRecordResult(customerRecordId,json.messageHtml);
				},
				cancel : true
			})
		}
	})
}
function customerRecordResult(customerRecordId,content){
	art.dialog({
	    title: '谈判结果',
	    content: content,
	    width:350,
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
	    width:320,
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
    		var url= "${ctx }/qywxCustomer/comeShopRecord?customerId="+customerId+"&comeShopeStatus="+selectvalue+"&redirectType=2&customerRecordId="+customerRecordId;
    		window.location.href=url;
			return true;
	    },
	    cancel:function(){
			return true;
	    }
	});
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