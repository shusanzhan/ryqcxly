<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
    <!-- Mobile Devices Support @begin -->
    <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
    <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
    <meta content="no-cache" http-equiv="pragma">
    <meta content="0" http-equiv="expires">
    <meta content="telephone=no, address=no" name="format-detection">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- apple devices fullscreen -->
    <link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
    <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack5.js"></script>
    <script src="${ctx }/pages/qywx/customer/customer.js"></script>
    <script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
    	.weui_tab_bd{
    		display: none;
    	}
    	.weui_tab_bd_on{
    		display:block;
    	}
    </style>
<title>到店客户线索确认</title>
</head>
<body>
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">到店客户线索确认</span>
    <a class="go_home" href="${ctx }/qywxCustomer/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
 <div class="row-fluid" style="text-align: left;color: red;border-bottom: 1px solid red;height: 40px;line-height: 40px;font-size: 14px;">
	<h3>
		待处理到店线索
	</h3>
</div>
 <form action="" id="frmId" name="frmId" method="post" target="_self">
<div class="weui_cells weui_cells_form">
		<table class="table table-bordered table-striped">
			<c:forEach var="customerRecord" items="${customerRecords }">
				<tr style="height: 40px;">
					<td class="formTableTdLeft"  colspan="4" style="padding-left: 12px;">
						<label>
							<input type="radio" id="customerRecordId" name="customerRecordId" value="${customerRecord.dbid }">
							<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/>
						<c:if test="${customerRecord.type==1 }">
							<span style="color: red;">来店</span>
						</c:if>
						<c:if test="${customerRecord.type==2 }">
							<span style="color:green;">来电</span>
						</c:if>
						<c:if test="${customerRecord.type==3 }">
							<span style="color: blue;">网销</span>
						</c:if>
						<c:if test="${customerRecord.type==4 }">
							<span style="color:orange;">活动</span>
						</c:if>
						<c:if test="${customerRecord.type==5 }">
							<span style="color:orange;">其他</span>
						</c:if>;
						<c:if test="${customerRecord.type==3 }">
							?
						</c:if>
						<c:if test="${customerRecord.type!=3 }">
							${customerRecord.customerNum}
							人
						</c:if>;
						<c:if test="${customerRecord.comeinNum==0 }">
							未到店
						</c:if>
						<c:if test="${customerRecord.comeinNum==1 }">
							初次到店
						</c:if>
						<c:if test="${customerRecord.comeinNum==2 }">
							二次来店
						</c:if>;
						<c:if test="${customerRecord.type<3 }">
							<c:if test="${customerRecord.overtimeStatus==1 }">
								<span>未超时</span>
							</c:if>
							<c:if test="${customerRecord.overtimeStatus==2 }">
								<span style="color: red">已超时</span>
							</c:if>
						</c:if>
						<c:if test="${customerRecord.type>=3 }">
							-
						</c:if>
						</label>
					</td>
				</tr>
			</c:forEach>
		</table>
		<br>
        <div class="weui_cell">
            <div class="weui_cell_hd">
            	<label class="weui_label" style="width: 80px;color: red;">谈判客户</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
         		<input type="hidden" id="customerId" name="customerId">
				<input type="text" class="weui_input" id="customerName" name="customerName" onfocus="autoCustomer('customerName')" onchange="autoCustomer('customerName')" placeholder="请输入客户名称或电话号码">
            </div>
        </div>
        <div class="weui_cell weui_cell_select weui_select_after">
            <div class="weui_cell_hd" style="color: red;">
                到店结果
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <select class="weui_select" id="comeShopeStatus" name="comeShopeStatus" checkType="integer,1" error="请选到店结果">
			  		<option value="-1">请选择...</option>
			  		<option value="1" >到店成交</option>
			  		<option value="2" >到店未成交</option>
				</select>
            </div>
        </div>
  </div>  
  <br>
  <br>
  <br>
<div class="buttomBar" >
    <a name="mobileCommit" id="showTooltips2" class="weui_btn weui_btn_warn" onclick="customerToRecord()">客户到店登记</a>
    <div style="clear: both;"></div>
</div>	
<br>
     <div id="toast" style="display: none;">
	    <div class="weui_mask_transparent"></div>
	    <div class="weui_toast">
	        <i class="weui_icon_toast"></i>
	        <p class="weui_toast_content">保存数据成功</p>
	    </div>
	</div>
</form>
</body>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".weui_navbar_item").bind("click",function(){
		var j=0;
		$(".weui_navbar_item").each(function(i){
			$(this).removeClass("weui_bar_item_on");
		})
		$(this).addClass("weui_bar_item_on");
		$(".weui_navbar_item").each(function(i){
			var classAttr=$(this).attr("class");
			if(classAttr.indexOf("weui_bar_item_on")>=0){
				j=i;
			}
		})
		$(".weui_tab_bd").each(function(i){
			if(j==i){
				$(this).addClass("weui_tab_bd_on");
			}else{
				$(this).removeClass("weui_tab_bd_on");
			}
		})
	})
})
function autoCustomer(id){
		var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/customer/ajaxCustomer",{
			max: 20,      
	        width: 130,    
	        matchSubset:false,   
	        matchContains: true,  
			dataType: "json",
			parse: function(data) {   
		    	var rows = [];      
		        for(var i=0; i<data.length; i++){      
		           rows[rows.length] = {       
		               data:data[i]       
		           };       
		        }       
		   		return rows;   
		    }, 
			formatItem: function(row, i, total) {   
		       return "<span>姓名："+row.name+"&nbsp;&nbsp;&nbsp;电话："+row.mobilePhone+"&nbsp;&nbsp;销售顾问："+row.saler+"</span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(function(event, data, formatted){
		$("#customerId").val(data.dbid);
		$("#customerName").val(data.name+"（"+data.mobilePhone+"），销售顾问："+data.saler);
		$("#customerName2").val(data.name);
	});
}
function customerToRecord(){
	var customerId=window.document.getElementById("customerId").value;
	var customerName=window.document.getElementById("customerName").value;
	
	if(customerName==undefined||customerName==''){
    	alert("请选择要登记客户");
    	return false;
    }
	var radios=window.document.getElementsByName("customerRecordId");
	var customerRecordId=null;
	for(var i=0;i<radios.length;i++){
      if(radios[i].checked==true) {
    	  customerRecordId=radios[i].value;
           break;
      }
    }
    if(customerRecordId==null){
    	alert("请选择来店线索");
    	return false;
     }
    var comeShopeStatus=$("#comeShopeStatus").val();
    if(comeShopeStatus<0){
        alert("请选择到店结果");
     }
    if(confirm("确定登记【"+customerName+"】客户客户谈判记录吗？")){
		window.location.href= "${ctx }/qywxCustomer/comeShopRecord?customerId="+customerId+"&comeShopeStatus="+comeShopeStatus+"&redirectType=2&customerRecordId="+customerRecordId;
	}
}
</script>
</html>