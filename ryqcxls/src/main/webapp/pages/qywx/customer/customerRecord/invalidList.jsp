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
<title>无效线索管理</title>
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
    <span id="page_title">无效线索管理</span>
      <a class="go_home" href="${ctx }/qywxCustomerRecord/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<c:set value="${page.result }" var="customerRecords"></c:set>
<c:if test="${empty(page.result)||fn:length(page.result)<=0 }" var="status">
	您还未添加线索！
</c:if>
<c:if test="${status==false }">
<div id="wrapper">
	<div id="scroller">
		<div id="thelist">
			<c:forEach items="${customerRecords }" var="customerRecord">
				<div class="orderContrac">
					<div class="title" align="left">
						
						<c:if test="${empty(customerRecord.name) }">
							客户：	
							<c:if test="${empty(customerRecord.customer.name) }">
								无
							</c:if>
							<c:if test="${!empty(customerRecord.customer.name) }">
								${customerRecord.customer.name }（${customerRecord.sex }）
							</c:if>
						</c:if>
						<c:if test="${!empty(customerRecord.name) }">
							客户：	${customerRecord.name }（${customerRecord.sex }）<br>
							联系电话：${customerRecord.mobilePhone }<br>
							所在区域：${customerRecord.address }
						</c:if><br>
		  			</div>
		  			<div class="line"></div>
					<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href='${ctx}/qywxCustomerRecord/view?dbid=${customerRecord.dbid }&type=2'">
						<div style="color:#8a8a8a;padding-left: 5px; ">
							登记日期：<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd"/><br/>
				  			线索类型：
				  			${customerRecord.customerType.name }
							<br>
							<c:if test="${customerRecord.customerType.dbid==1 }">
								进店时间：
							</c:if>
							<c:if test="${customerRecord.customerType.dbid!=1 }">
								来电时间：
							</c:if>
							<c:if test="${customerRecord.customerType.dbid!=1 }">
								<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/> 
							</c:if>
							<c:if test="${customerRecord.customerType.dbid==1 }">
								${customerRecord.comeInTime}
							</c:if>
							<br>
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
							<c:if test="${customerRecord.status==2 }">
								<span style="color: red;">无效</span>
							</c:if>
							<br>
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
				</div>
			</c:forEach>
		</div>
		<div id="pullUp">
			<span class="pullUpIcon"></span><span class="pullUpLabel" id="pullUpLabel">上拉加载更多...</span>
		</div>
	</div>
</div>
</c:if>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxCustomerRecord/queryInvalidList" name="frmId" id="frmId" method="post">
      	<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo+1}'>
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
      	 		<td width="60"><label for="exampleInputName2">登记时间开始</label></td>
      	 		<td width="240">
      	 			<input type="date" class="form-control" id="startTime" name="startTime"  value="${param.startTime }" >~
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">登记时间结束</label></td>
      	 		<td width="240">
  					<input type="date" class="form-control" id="endTime" name="endTime"  value="${param.endTime }">
			    </td>
      	 	</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#currentPage').val(1);$('#frmId')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
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
	var window_w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
	var window_h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
	if($('.go_top').length==0){
	    $('body').append('<a href="#" class="go_top"><img src="${ctx}/images/jm/icon_top.png" data-original=${ctx}/images/jm/icon_top.png" alt=""></a>');
	}
	$(window).scroll(function(e){
	    if(document.body.scrollTop+document.documentElement.scrollTop>window_h){
	        $('.go_top').show();
	    }
	    else{
	        $('.go_top').hide();
	    }
	});
	$('.go_top').click(function(){
	    document.body.scrollTop = 0;
	    document.documentElement.scrollTop = 0;
	    return false;
	})
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
var myScroll,
	pullUpEl, pullUpOffset,
	generatedCount = 0;
/**
 * 滚动翻页 （自定义实现此方法）
 * myScroll.refresh();		// 数据加载完成后，调用界面更新方法
 */
function pullUpAction () {
	setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
		var params = $("#frmId").serialize();
		$.post("${ctx}/qywxCustomerRecord/ajaxInvalidList",params,function callBack(data) {
			if(data.data!='1'){
				$("#currentPage").val(data.pageNo);
			}
			createData(data.data);
			myScroll.refresh();		
		}
		);
	}, 1000);	// <-- Simulate network congestion, remove setTimeout from production!
}
/**
 * 初始化iScroll控件
 */
function loaded() {
	pullUpEl = document.getElementById('pullUp');	
	pullUpOffset = pullUpEl.offsetHeight;
	
	myScroll = new iScroll('wrapper', {
		scrollbarClass: 'myScrollbar', /* 重要样式 */
		useTransition: false, /* 此属性不知用意，本人从true改为false */
		onRefresh: function () {
		},
		onScrollMove: function () {
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
				pullUpEl.className = 'flip';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '松手开始更新...';
				this.maxScrollY = this.maxScrollY;
			} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				this.maxScrollY = pullUpOffset;
			}
		},
		onScrollEnd: function () {
			 if (pullUpEl.className.match('flip')) {
				pullUpEl.className = 'loading';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载中...';				
				pullUpAction();	// Execute custom function (ajax call?)
			}
		}
	});
	setTimeout(function () { document.getElementById('wrapper').style.left = '0'; }, 800);
}

//初始化绑定iScroll控件 
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
document.addEventListener('DOMContentLoaded', loaded, false); 
function createData(datas){
	var el, li, i;
	el = document.getElementById('thelist');
	if(datas!='1'){
		if(datas.length<10){
			$("#pullUpLabel").text("数据已经加载完毕");
		}
		//var dataValues=$.parseJSON(datas);
		for(i=0;i<datas.length;i++){
			var data=datas[i];
			var valueStr='<div class="orderContrac" id="orderContrac'+data.dbid+'">';
			valueStr=valueStr+'<div class="title" align="left">';
			if(data.name==''||data.name==undefined||data.name=='无'){
				valueStr=valueStr+'客户：无<br/>';
			}else{
				valueStr=valueStr+'客户：'+data.name+'<br/>';
				valueStr=valueStr+'联系电话：<a href="tel:'+data.mobilePhone+'">'+data.mobilePhone+'</a><br>';
				valueStr=valueStr+'所在区域：'+data.address+'<br>';
			}
			valueStr=valueStr+'</div>';
			valueStr=valueStr+'<div class="line"></div>';
			valueStr=valueStr+'<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href=\'${ctx}/qywxCustomerRecord/view?dbid='+data.dbid+'&type=1\'">';
			valueStr=valueStr+'<div style="color:#8a8a8a;padding-left: 5px; ">';
			valueStr=valueStr+'登记日期：'+data.createDate+'<br>';
			valueStr=valueStr+'线索类型：'+data.types+'<br>';
			if(data.type==1){
				valueStr=valueStr+'进店时间：'+data.comeInTime+'<br>';
				valueStr=valueStr+'进店人数：'+data.customerNum+'<br>';
			}
			if(data.type==2){
				valueStr=valueStr+'来电时间：'+data.comeInTime+'<br>';
			valueStr=valueStr+'进店人数：?<br>';
			}
			if(data.status==1){
				valueStr=valueStr+'线索状态：style=\"color: green;\">有效</span><br>';
			}
			if(data.status==2){
				valueStr=valueStr+'线索状态：<span style=\"color: red;\">无效</span><br>';
			}
			valueStr=valueStr+'信息来源：'+data.customerInfromStr+'<br>';
			valueStr=valueStr+'来店次数：'+data.comeinNum+'<br>';
			valueStr=valueStr+'备注：'+data.note+'<br>';
			valueStr=valueStr+'</div>';
			valueStr=valueStr+'</div>';
			valueStr=valueStr+'</div>';
			valueStr=valueStr+'</div>';
			$("#thelist").append(valueStr);
		}
	}else{
		$("#pullUpLabel").text("数据已经加载完毕");
	}
	
}
function vlidateCustomer(customerRecordId){
	$.post('${ctx}/qywxCustomerRecord/vlidateCustomer?customerRecordId='+customerRecordId+'&dateTime='+new Date(),{},function(json){
		var data=json.state;
		if(data==1||data=="1"){
			window.location.href='${ctx }/qywxCustomer/add?customerRecordId='+customerRecordId;
		}
		if(data==2||data=="2"){
			window.location.href='${ctx }/qywxCustomer/add?customerRecordId='+customerRecordId;
		}
		if(data==3||data=="3"){
			window.top.art.dialog({
				content : '系统已经存在【'+json.mobilePhone+'】客户，点击【确定】继续完善客户资料同时标记线索已经处理。',
				icon : 'question',
				width:"320px",
				height:"120px",
				lock : true,
				ok : function() {
					$.post('${ctx}/qywxCustomerRecord/updateCustomerRecord?customerRecordId='+customerRecordId+'&customerId='+json.dbid+'&dateTime='+new Date(),{},function(json){
						var data=json.state;
						if(data==1||data=="1"){
							window.location.href=json.url;
						}
						if(data==0||data=="0"){
							$.utile.tips(json.mesg);
						}
					})
				},
				cancel : true
			})
		}
	})
}
</script>
</html>