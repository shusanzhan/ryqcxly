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
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css" type="text/css" />
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
<title>客户来店登记</title>
</head>
<body>
 <form action="" id="frmId" name="frmId" method="post" target="_self">
<input type="hidden" value="${customer.dbid }" id="dbid" name="customer.dbid">
<input type="hidden" value="${param.customerRecordId }" id="customerRecordId" name="customerRecordId">
<input type="hidden" value="${param.type }" id="type" name="type">
<input type="hidden" value="${param.redirectType }" id="redirectType" name="redirectType">
<input type="hidden" value="${customer.lastResult }" id="lastResult" name="customer.lastResult">
<input type="hidden" value="${customerBussi.dbid }" id="customerBussiId" name="customerBussi.dbid">
<input type="hidden" value="${customer.firstCustomerPhase.dbid }" id="firstCustomerPhaseDbid" name="firstCustomerPhaseDbid">
<input type="hidden" value="${customer.orderContractStatus }" id="orderContractStatus" name="customer.orderContractStatus">
<input type="hidden" value="${customer.recommendCustomer.dbid }" id="recommendCustomerId" name="recommendCustomerId">
<input  type="hidden"  class="largeX text" id="bussiStaff" name="customer.bussiStaff"   value="${customer.bussiStaff }">
<div class="navbar">
	<div class="bd" style="height: 100%;">
	    <div class="weui_tab">
	        <div class="weui_navbar">
	            <div class="weui_navbar_item weui_bar_item_on">
	                基础信息
	            </div>
	            <div class="weui_navbar_item">
	                回访登记
	            </div>
	            <div class="weui_navbar_item">
	                来店登记
	            </div>
	            <div class="weui_navbar_item">
	                需求评估
	            </div>
	            <div class="weui_navbar_item">
	                接待结果
	            </div>
	        </div>
        <div class="weui_tab_bd weui_tab_bd_on">
			<div class="weui_cells weui_cells_form">
			        <div class="weui_cell">
			            <div class="weui_cell_hd">
			            	<label class="weui_label" style="width: 80px;color: red;">客户姓名</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
				            <c:if test="${customer.orderContract.status>=1}" var="status">
				                <input type="text" class="weui_input" readonly="readonly" id="name" name="customer.name" value="${customer.name }" placeholder="客户姓名" checkType="string,2,12">
				            </c:if>
				            <c:if test="${status==false}">
				                <input type="text" class="weui_input" id="name" name="customer.name" value="${customer.name }" placeholder="客户姓名" checkType="string,2,12">
				            </c:if>
			            </div>
			        </div>
			         <div class="weui_cell">
			            <div class="weui_cell_hd">
			            	<label class="weui_label" style="width: 80px;color: red;">电话</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
			               <c:if test="${customer.orderContract.status>=1}" var="status">
							  <input type="number"  class="weui_input" id="mobilePhone" name="customer.mobilePhone" pattern="[0-9]*" placeholder="请输入号码" checkType="mobilePhone" value="${customer.mobilePhone }">
						  </c:if>
						  <c:if test="${status==false }">
							  <input type="number"  class="weui_input" id="mobilePhone" name="customer.mobilePhone" pattern="[0-9]*" placeholder="请输入号码" checkType="mobilePhone" value="${customer.mobilePhone }">
						  </c:if>
			            </div>
			        </div>
			        <div class="weui_cell weui_cell_select weui_select_after">
			            <div class="weui_cell_hd" style="color: red;">
			               	称呼
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
			                <select class="weui_select" id="sex" name="customer.sex" checkType="string,1" error="请选称呼">
						  		<option value="-1">请选择...</option>
						  		<option value="男" ${customer.sex=='男'?'selected="selected"':''} >先生</option>
						  		<option value="女" ${customer.sex=='女'?'selected="selected"':''}>女士</option>
							</select>
			            </div>
			        </div>
			       <div class="weui_cell weui_cell_select weui_select_after">
			            <div class="weui_cell_hd">
			               	<label class="weui_label" style="width: 80px;color: red;">品牌</label>
			            </div>
			            <div class="weui_cell weui_cell_select weui_select_after">
			                <c:if test="${customer.lastResult==1 }" var="status">
								<input type="hidden" readonly="readonly" class="weui_input" name="brandId" id="brandId" value="${customerBussi.brand.dbid }" />
								<input type="text" readonly="readonly" class="weui_input" name="brandName" id="brandName" value="${customerBussi.brand.name }" checkType="string,1,200" tip="请选择意向车型！"/>
							</c:if>
							<c:if test="${status==false }">
								<select class="weui_select"  onchange="ajaxCarSeriy(this.value)" id="brandId" name="brandId" checkType="integer,1" error='请选择品牌'>
							  		<option value="">请选择...</option>
							  		<c:forEach var="brand" items="${brands }">
										<option value="${brand.dbid }" ${customerBussi.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
									</c:forEach>
								</select>
							</c:if>
			            </div>
			        </div>
			       <div class="weui_cell weui_cell_select weui_select_after">
			            <div class="weui_cell_hd">
			               	<label class="weui_label" style="width: 80px;color: red;">车系</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
			                <c:if test="${customer.lastResult==1 }" var="status">
								<input type="hidden" readonly="readonly" class="weui_input" name="carSeriyId" id="carSeriyId" value="${customerBussi.carSeriy.dbid }" />
								<input type="text" readonly="readonly" class="weui_input" name="carSeriyName" id="carSeriyName" value="${customerBussi.carSeriy.name }" checkType="string,1,200" tip="请选择意向车型！"/>
							</c:if>
							<c:if test="${status==false }">
								<select class="weui_select"  onchange="ajaxCarModel('carSeriyId')" id="carSeriyId" name="carSeriyId" checkType="integer,1" error='请选择品牌'>
							  		<option value="">请选择...</option>
							  		<c:forEach var="carSeriy" items="${carSeriys }">	  	
							  			<option value="${carSeriy.dbid }" ${carSeriy.dbid==customerBussi.carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							  		</c:forEach>
								</select>
							</c:if>
			            </div>
			        </div>
					<div class="weui_cell">
			            <div class="weui_cell_hd">
			               	<label class="weui_label" style="width: 80px;color: red;">车型</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
			                <c:if test="${customer.lastResult==1 }" var="status">
								<input type="hidden" readonly="readonly" class="weui_input" name="carModelId" id="carModelId" value="${customerBussi.carModel.dbid }" />
								<input type="text" readonly="readonly" class="weui_input" name="carModelName" id="carModelName" value="${customerBussi.carModel.name }" checkType="string,1,200" tip="！"/>
							</c:if>
							<c:if test="${status==false }">
								<select class="weui_select"  id="carModelId" name="carModelId" checkType="integer,1" error='请选择车型'>
							  		<option value="">请选择...</option>
							  		<c:forEach var="carModel" items="${carModels }">	  	
							  			<option value="${carModel.dbid }" ${carModel.dbid==customerBussi.carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
							  		</c:forEach>
								</select>
							</c:if>
			            </div>
			        </div>
			        <c:if test="${enterprise.bussiType==3 }" var="statusss">
				        <div class="weui_cell">
				            <div class="weui_cell_hd">
				            	<label class="weui_label" style="width: 80px">具体车型</label>
				            </div>
				            <div class="weui_cell_bd weui_cell_primary">
					            <input type="text" class="weui_input" name="customer.carModelStr" id="carModelStr"  value="${customer.carModelStr }" onfocus="ajaxCarModel('carModelStr')" checkType="string,1,50" placeholder="请输入车型"  tip="请输入车型！"/>
				            </div>
				        </div>
				        <div class="weui_cell">
				            <div class="weui_cell_hd">
				            	<label class="weui_label" style="width: 80px">指导价</label>
				            </div>
				            <div class="weui_cell_bd weui_cell_primary">
					            <input type="text" class="weui_input" name="customer.navPrice" id="navPrice"  value="${customer.navPrice }" checkType="float"  tip="请输入指导价"/>
				            </div>
				        </div>
					</c:if>
					 <div class="weui_cell">
			            <div class="weui_cell_hd">
			            	<label class="weui_label" style="width: 80px;">意向级别</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
				            <input type="hidden"   name="customerPhaseId" id="customerPhaseId"  value="${customer.customerPhase.dbid }">
							<input type="text" readonly="readonly" class="weui_input"     value="${customer.customerPhase.name }">
			            </div>
			        </div>
			        <c:if test="${customer.orderContract.status>=1}" var="status">
			        	 <div class="weui_cell">
				            <div class="weui_cell_hd">
				            	<label class="weui_label" style="width: 80px">地域</label>
				            </div>
				            <div class="weui_cell_bd weui_cell_primary">
					            <input type="hidden"   name="areaId" id="areaId"  value="${customer.area.dbid }">
								<input type="text" readonly="readonly" class="weui_input"   value="${customer.area.fullName }" >
				            </div>
				        </div>
			        	 <div class="weui_cell">
				            <div class="weui_cell_hd">
				            	<label class="weui_label" style="width: 80px">详细地址</label>
				            </div>
				            <div class="weui_cell_bd weui_cell_primary">
					            <input readonly="readonly"  name="customer.address" class="weui_input" id=address title="" value="${customer.address }" placeholder="请填写街道地址"></input>
				            </div>
				        </div>
					</c:if>
					<c:if test="${status==false }">
						<div class="weui_cell weui_cell_select weui_select_after">
				            <div class="weui_cell_hd" style="width: 80px;">
				               	区域
				            </div>
				            <div class="weui_cell_bd weui_cell_primary" id="areaLabel">
				               <c:if test="${empty(areaSelect) }">
									<select class="weui_select" id="areoD" name="areoD" class="midea text" onchange="ajaxArea(this)">
										<option>请选择...</option>
										<c:forEach items="${areas }" var="area">
											<option  value="${area.dbid }">${area.name }</option>
										</c:forEach>
									</select>
								</c:if>
								<c:if test="${!empty(areaSelect) }">
									${fn:replace(areaSelect,"midea text","weui_select")  }
								</c:if>
				            </div>
				        </div>
						<div class="weui_cell">
				            <div class="weui_cell_hd">
				            	<label class="weui_label" style="width: 80px">详细地址</label>
				            </div>
				            <div class="weui_cell_bd weui_cell_primary">
								<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
					            <input   name="customer.address" class="weui_input" id=address title="" value="${customer.address }" placeholder="请填写街道地址"></input>
				            </div>
				        </div>
				</c:if>
					<div class="weui_cells_title">备注</div>
					<div class="weui_cells weui_cells_form">
				        <div class="weui_cell">
				            <div class="weui_cell_bd weui_cell_primary">
				                <textarea class="weui_textarea" name="customer.note" id="note"	 placeholder="请填写一点备注吧" rows="3">${customer.note }</textarea>
				            </div>
				        </div>
				    </div>
			  </div>  
			  <br>
			  <br>
			  <br>
        </div>
        <div class="weui_tab_bd">
        	<br>
        	<br>
       		<input type="hidden" name="customerTrackId" id="customerTrackId" value="${customerTrack.dbid }">
			<input type="hidden" name="maxDay" id="maxDay" value="">
			<input  type="hidden" name="customerTrack.trackDate" id="trackDate"	value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd HH:mm" />' class="large text" >
			<div class="weui_cells weui_cells_form">
		         <div class="weui_cell weui_cell_select weui_select_after">
		            <div class="weui_cell_hd" style="color: red;">
		               	跟进类型
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
				  		<select class="weui_select"  id="trackType" name="customerTrack.trackType"  checkType="integer,1"  onchange="marketingAct(this.value);tryDriverOper()">
							<option value="-1">请选择...</option>
							<option value="2" selected="selected">普通邀约到店</option>
							<option value="3" ${customerTrack.trackType==3?'selected="selected"':'' }>活动邀约到店 </option>
						</select>
		            </div>
		        </div>
		         <div class="weui_cell weui_cell_select weui_select_after">
		            <div class="weui_cell_hd" style="color: red;">
		               	跟进方法
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
				  		<select id="trackMethod" name="customerTrack.trackMethod" class="weui_select"  checkType="integer,1"  onchange="tryDriverOper()">
							<option value="2" selected="selected">到店</option>
						</select>
		            </div>
		        </div>
		        <div id="marketing" style="display: none;">
			        <div class="weui_cell weui_cell_select weui_select_after">
			            <div class="weui_cell_hd" >
			               	邀约活动
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
					  		<select id="custMarketingActId" name="custMarketingActId" class="weui_select">
								<option value="">请选择...</option>
								<c:forEach var="custMarketingAct" items="${custMarketingActs }">
									<option value="${custMarketingAct.dbid }">${custMarketingAct.name }</option>
								</c:forEach>
							</select>
			            </div>
			        </div>
			        <div class="weui_cell weui_cell_select weui_select_after">
			            <div class="weui_cell_hd" >
			               	邀约结果
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
					  		<select id="turnBackResult" name="customerTrack.turnBackResult" class="weui_select" >
								<option value="-1">请选择...</option>
								<option value="1" selected="selected">接受</option>
							</select>
			            </div>
			        </div>
			      </div>
		        <div class="weui_cell weui_cell_select weui_select_after">
		            <div class="weui_cell_hd" style="color: red;">
		               	更新级别
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
				  		<select id="customerPhaseId" name="customerPhaseId" class="weui_select" checkType="integer,1" onchange="addDate(this.value)">
							<option value="-1">请选择...</option>
							<c:forEach var="customerPhase" items="${customerPhases }">
								<c:if test="${customerPhase.name!='O' }">
									<option value="${customerPhase.dbid }" >${customerPhase.name }</option>
								</c:if>
							</c:forEach>
						</select>
		            </div>
		        </div>
		        <div class="weui_cell" id="nextReservationTimeTr" style="display: none">
            		<div class="weui_cell_hd">
		            	<label class="weui_label" style="width: 80px;color: red;">下次时间</label>
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
			            <input type="text" name="customerTrack.nextReservationTime" id="nextReservationTime" value="" class="weui_input" 	onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'trackDate\')}',maxDate:'#F{$dp.$D(\'maxDay\')}'});" checkType="string,1" tip="请选择下次预约时间">
		            </div>
		        </div>
		      	<div class="weui_cells_title" style="color: red;">跟进内容</div>
				<div class="weui_cells weui_cells_form">
			        <div class="weui_cell">
			            <div class="weui_cell_bd weui_cell_primary">
			                <textarea class="weui_textarea" name="customerTrack.trackContent" id="trackContent"	 placeholder="请填写跟进内容" rows="3" checkType="string,1,2000">${customerTrack.trackContent}</textarea>
			            </div>
			        </div>
			    </div>
		          <div class="weui_cell">
            		<div class="weui_cell_hd">
		            	<label class="weui_label" style="width: 80px">沟通结果</label>
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
			            <input type="text" name="customerTrack.result" id="result" class="weui_input" placeholder="沟通结果">
		            </div>
		        </div>
		          <div class="weui_cell">
            		<div class="weui_cell_hd">
		            	<label class="weui_label" style="width: 80px">反馈问题</label>
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
			           <input type="text" name="customerTrack.feedBackResult" class="weui_input" id="feedBackResult" placeholder="反馈问题">
		            </div>
		        </div>
		          <div class="weui_cell">
            		<div class="weui_cell_hd">
		            	<label class="weui_label" style="width: 80px">处理方式</label>
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
			           <input type="text" name="customerTrack.dealMethod" class="weui_input"  id="dealMethod"	placeholder="处理方式">
		            </div>
		        </div>
		     
			</div>
        </div>
        <div class="weui_tab_bd">
        	<br>
        	<br>
        	<input type="hidden" name="customerShoppingRecord.dbid" id="customerShoppingRecordDbid" value="${customerShoppingRecord.dbid }">
			<div class="weui_cells weui_cells_form">
				 <div class="weui_cell">
            		<div class="weui_cell_hd">
		            	<label class="weui_label" style="width: 80px;color: red;">进店时间</label>
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
			            <c:if test="${empty(customerShoppingRecord.comeInTime) }">
							<input type="text" name="customerShoppingRecord.comeInTime" id="comeInTime" value="${customerRecord.comeInTime }" class="weui_input" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" >
						</c:if>
						<c:if test="${!empty(customerShoppingRecord.comeInTime) }">
							<input type="text" name="customerShoppingRecord.comeInTime" id="comeInTime" value="${customerShoppingRecord.comeInTime }" class="weui_input" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" >
						</c:if>
		            </div>
		        </div>
				 <div class="weui_cell">
            		<div class="weui_cell_hd">
		            	<label class="weui_label" style="width: 80px;color: red;">离店时间</label>
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
						<input type="text" name="customerShoppingRecord.farwayTime" id="farwayTime" value="${customerShoppingRecord.farwayTime }" class="weui_input" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});"  checkType="string,1" >
		            </div>
		        </div>
		        <div class="weui_cell weui_cell_select weui_select_after">
		            <div class="weui_cell_hd" >
		               	停留时间
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
						<select id="waitingTime" name="customerShoppingRecord.waitingTime" class="weui_select">
							<option value="">请选择...</option>
							<option value="1" ${customerShoppingRecord.waitingTime==1?'selected="selected"':'' } >约10分钟</option>
							<option value="2" ${customerShoppingRecord.waitingTime==2?'selected="selected"':'' }>约20分钟</option>
							<option value="3" ${customerShoppingRecord.waitingTime==3?'selected="selected"':'' }>约30分钟</option>
							<option value="4" ${customerShoppingRecord.waitingTime==4?'selected="selected"':'' }>约1小时</option>
							<option value="5" ${customerShoppingRecord.waitingTime==5?'selected="selected"':'' }>约2小时</option>
							<option value="6" ${customerShoppingRecord.waitingTime==6?'selected="selected"':'' }>约3小时</option>
							<option value="7" ${customerShoppingRecord.waitingTime==7?'selected="selected"':'' }>约5小时</option>
							<option value="8" ${customerShoppingRecord.waitingTime==8?'selected="selected"':'' }>约8小时</option>
						</select>
		            </div>
		        </div>
		        <div class="weui_cell weui_cell_select weui_select_after">
		            <div class="weui_cell_hd" >
		               	客户随行人数
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
						<select id="customerNum" name="customerShoppingRecord.customerNum" class="weui_select">
							<option value="">请选择...</option>
							<option value="1" ${customerShoppingRecord.customerNum==1?'selected="selected"':'' } >1人</option>
							<option value="2" ${customerShoppingRecord.customerNum==2?'selected="selected"':'' }>2人</option>
							<option value="3" ${customerShoppingRecord.customerNum==3?'selected="selected"':'' }>3人</option>
							<option value="4" ${customerShoppingRecord.customerNum==4?'selected="selected"':'' }>4人</option>
							<option value="5" ${customerShoppingRecord.customerNum==5?'selected="selected"':'' }>5人</option>
							<option value="6" ${customerShoppingRecord.customerNum==6?'selected="selected"':'' }>6人</option>
							<option value="7" ${customerShoppingRecord.customerNum==7?'selected="selected"':'' }>7人</option>
							<option value="8" ${customerShoppingRecord.customerNum==8?'selected="selected"':'' }>8人</option>
							<option value="9" ${customerShoppingRecord.customerNum==9?'selected="selected"':'' }>9人</option>
							<option value="10" ${customerShoppingRecord.customerNum==10?'selected="selected"':'' }>10人以上</option>
						</select>
		            </div>
		        </div>
		        <div class="weui_cells_title" style="color: red;">是否试驾</div>
		        <c:if test="${customer.tryCarStatus==1||empty(customer.tryCarStatus) }">
		        <div class="weui_cells weui_cells_radio">
			        <label class="weui_cell weui_check_label" for="x11">
			            <div class="weui_cell_bd weui_cell_primary">
			                <p>未试驾</p>
			            </div>
			            <div class="weui_cell_ft">
			                <input type="radio" class="weui_check" name="tryCarStatus" id="x11" ${customer.tryCarStatus==1?'checked="checked"':'' }  value="1">
			                <span class="weui_icon_checked"></span>
			            </div>
			        </label>
			        <label class="weui_cell weui_check_label" for="x12">
			            <div class="weui_cell_bd weui_cell_primary">
			                <p>已试驾</p>
			            </div>
			            <div class="weui_cell_ft">
			                <input type="radio" name="tryCarStatus" class="weui_check" id="x12"  ${customer.tryCarStatus==2?'checked="checked"':'' }   value="2">
			                <span class="weui_icon_checked"></span>
			            </div>
			        </label>
			    </div>
			   </c:if>
			   <c:if test="${customer.tryCarStatus==2 }">
			    	 <div class="weui_cells weui_cells_radio">
				        <label class="weui_cell weui_check_label" for="x12">
				            <div class="weui_cell_bd weui_cell_primary">
				                <p>已试驾</p>
				            </div>
				            <div class="weui_cell_ft">
				                <input type="radio" name="tryCarStatus" class="weui_check" id="x12"  ${customer.tryCarStatus==2?'checked="checked"':'' }   value="2">
				                <span class="weui_icon_checked"></span>
				            </div>
				        </label>
				    </div>
			    </c:if>
			    <div class="weui_cell">
            		<div class="weui_cell_hd">
		            	<label class="weui_label" style="width: 80px">试驾专员</label>
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
						<input name="customerShoppingRecord.tryDriver"  id="tryDriver"  value="${customerShoppingRecord.tryDriver }" class="weui_input" placeholder="试驾专员"></input>
		            </div>
		        </div>
			    <div class="weui_cell">
            		<div class="weui_cell_hd">
		            	<label class="weui_label" style="width: 80px">客户车型</label>
		            </div>
		            <div class="weui_cell_bd weui_cell_primary">
						<input  type="text" class="weui_input" id="carModel" name="customerShoppingRecord.carModel"   value="${customerShoppingRecord.carModel }" placeholder="客户车型">
		            </div>
		        </div>
		        <div class="weui_cells_title">客户是否有车</div>
		        <div class="weui_cells weui_cells_radio">
			        <label class="weui_cell weui_check_label" for="x1">
			            <div class="weui_cell_bd weui_cell_primary">
			                <p>无车</p>
			            </div>
			            <div class="weui_cell_ft">
			                <input type="radio" class="weui_check" name="customerShoppingRecord.isGetCar" id="x1"  ${customerShoppingRecord.isGetCar==false?'checked="checked"':'' } value="false">
			                <span class="weui_icon_checked"></span>
			            </div>
			        </label>
			        <label class="weui_cell weui_check_label" for="x2">
			            <div class="weui_cell_bd weui_cell_primary">
			                <p>有车</p>
			            </div>
			            <div class="weui_cell_ft">
			                <input type="radio" name="customerShoppingRecord.isGetCar" class="weui_check" id="x2"  ${customerShoppingRecord.isGetCar==true?'checked="checked"':'' } value="true">
			                <span class="weui_icon_checked"></span>
			            </div>
			        </label>
			    </div>
		        <div class="weui_cells_title">接待经过</div>
				<div class="weui_cells weui_cells_form">
			        <div class="weui_cell">
			            <div class="weui_cell_bd weui_cell_primary">
			                <textarea class="weui_textarea" rows="3"  name="customerShoppingRecord.receptionExperience" id="receptionExperience"  value="">${customerShoppingRecord.receptionExperience }</textarea>
			            </div>
			        </div>
			    </div>
        	</div>
    </div>
	<div class="weui_tab_bd">
      	<br>
      	<br>
		<div class="weui_cells weui_cells_form">
			<div class="weui_cell weui_cell_select weui_select_after">
	            <div class="weui_cell_hd" >
	              购车关注点
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<select id="buyCarCareId" name="buyCarCareId" class="weui_select">
						<option value="">请选择...</option>
						<c:forEach var="buyCarCare" items="${buyCarCares }">
							<option value="${buyCarCare.dbid }" ${customerBussi.buyCarCare.dbid==buyCarCare.dbid?'selected="selected"':'' } >${buyCarCare.name }</option>
						</c:forEach>
					</select>
	            </div>
	        </div>
			<div class="weui_cell weui_cell_select weui_select_after">
	            <div class="weui_cell_hd" >
	              购车主要目的
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<select id="buyCarTargetId" name="buyCarTargetId" class="weui_select">
						<option value="">请选择...</option>
						<c:forEach var="buyCarTarget" items="${buyCarTargets }">
							<option value="${buyCarTarget.dbid }" ${customerBussi.buyCarTarget.dbid==buyCarTarget.dbid?'selected="selected"':'' } >${buyCarTarget.name }</option>
						</c:forEach>
					</select>
	            </div>
	        </div>
			<div class="weui_cell weui_cell_select weui_select_after">
	            <div class="weui_cell_hd" >
	              购车类型
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<select id="buyCarTypeId" name="buyCarTypeId" class="weui_select">
						<option value="">请选择...</option>
						<c:forEach var="buyCarType" items="${buyCarTypes }">
							<option value="${buyCarType.dbid }" ${customerBussi.buyCarType.dbid==buyCarType.dbid?'selected="selected"':'' } >${buyCarType.name }</option>
						</c:forEach>
					</select>
	            </div>
	        </div>
			<div class="weui_cell weui_cell_select weui_select_after">
	            <div class="weui_cell_hd" >
	              购车类型
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<select id="buyCarBudgetId" name="buyCarBudgetId" class="weui_select">
						<option value="">请选择...</option>
						<c:forEach var="buyCarBudget" items="${buyCarBudgets }">
							<option value="${buyCarBudget.dbid }" ${customerBussi.buyCarBudget.dbid==buyCarBudget.dbid?'selected="selected"':'' } >${buyCarBudget.name }</option>
						</c:forEach>
					</select>
	            </div>
	        </div>
			<div class="weui_cell weui_cell_select weui_select_after">
	            <div class="weui_cell_hd" >
	              主要使用者
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<select id="buyCarMainUseId" name="buyCarMainUseId" class="weui_select">
						<option value="">请选择...</option>
						<c:forEach var="buyCarMainUse" items="${buyCarMainUses }">
							<option value="${buyCarMainUse.dbid }" ${customerBussi.buyCarMainUse.dbid==buyCarMainUse.dbid?'selected="selected"':'' } >${buyCarMainUse.name }</option>
						</c:forEach>
					</select>
	            </div>
	        </div>
	        <div class="weui_cells_title">备注</div>
			<div class="weui_cells weui_cells_form">
		        <div class="weui_cell">
		            <div class="weui_cell_bd weui_cell_primary">
		                <textarea class="weui_textarea" name="customerBussi.note" id="customerBussiNote"	 placeholder="请填写一点备注吧" rows="3">${customerBussi.note}</textarea>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
	<div class="weui_tab_bd">
      	<br>
      	<br>
		<div class="weui_cells weui_cells_form">
			 <div class="weui_cell">
           		<div class="weui_cell_hd">
	            	<label class="weui_label" style="width: 80px">客户性格特征</label>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<input type="text" class="weui_input" name="customerBussi.customerSpecification" id="customerSpecification"  value="${customerBussi.customerSpecification }" placeholder="客户性格特征"></input>
	            </div>
	        </div>
			 <div class="weui_cell">
           		<div class="weui_cell_hd">
	            	<label class="weui_label" style="width: 80px">客户阐述需求</label>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<input type="text" class="weui_input" name="customerBussi.customerNeed" id="customerNeed"   value="${customerBussi.customerNeed }" placeholder="客户阐述需求">
	            </div>
	        </div>
			 <div class="weui_cell">
           		<div class="weui_cell_hd">
	            	<label class="weui_label" style="width: 80px">主要关注竞品</label>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<input type="text"  class="weui_input" name="customerBussi.customerCareAbout" id="customerCareAbout"  value="${customerBussi.customerCareAbout }" placeholder="主要关注竞品">
	            </div>
	        </div>
			 <div class="weui_cell">
           		<div class="weui_cell_hd">
	            	<label class="weui_label" style="width: 80px">其它重点描述</label>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<input type="text" class="weui_input" name="customerBussi.otherMainDescription" id="otherMainDescription"   value="${customerBussi.otherMainDescription }"  placeholder="其它重点描述">
	            </div>
	        </div>
			 <div class="weui_cell">
           		<div class="weui_cell_hd">
	            	<label class="weui_label" style="width: 80px">后续跟进计划</label>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
					<input  type="text" id="afterPlan" name="customerBussi.afterPlan"  class="weui_input"  value="${customerBussi.afterPlan }" placeholder="后续跟进计划">
	            </div>
	        </div>
		</div>
	</div>
</div>
</div>
</div>
<br>
    <div class="weui_btn_area" style="position: fixed;left: 0;bottom:12px;width: 100%;">
        <a class="weui_btn weui_btn_warn" href="javascript:" id="showTooltips" onclick="if(validateFrm()){ajaxSubmit('${ctx}/qywxCustomer/saveComeShopRecord','frmId')}">保存</a>
    </div>
     <div id="toast" style="display: none;">
	    <div class="weui_mask_transparent"></div>
	    <div class="weui_toast">
	        <i class="weui_icon_toast"></i>
	        <p class="weui_toast_content">保存数据成功</p>
	    </div>
	</div>
</form>
</body>
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
function ajaxCarSeriy(val){
	var op="<option>请选择车系...</option>";
	$("#carSeriyId").empty();
	$("#carModelId").empty();
	$("#carSeriyId").append(op);
	$("#carModelId").append(op);
	$.post("${ctx}/qywxCustomer/ajaxCarSeriy?brandId="+val+"&dateTime="+new Date()+"&type=2",{},function (data){
		if(data!="error"){
			$("#carSeriyId").empty();
			$("#carSeriyId").append(data);
		}
	});
}
function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/qywxCustomer/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date()+"&type=2",{},function (data){
		if(data!="error"){
			$("#carModelId").empty();
			$("#carModelId").append(data);
		}
	});
}
function ajaxArea(sel){
	var value=$(sel).val();
	$("#areaId").val(value);
	var sle= $(sel).nextAll();
	$(sle).remove();
	$.post("${ctx}/area/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			var data=data.replace(/midea text/g,'weui_select');
			$("#areaLabel").append(data);
		}
	});
}
function marketingAct(trackType){
	  if(trackType==3){
		  $("#marketing").show();
		  $("#custMarketingActId").attr("checkType","integer,1");
		  $("#turnBackResult").attr("checkType","integer,1");
	  }else{
		  $("#marketing").hide();
		  $("#custMarketingActId").removeAttr("checkType");
		  $("#turnBackResult").removeAttr("checkType");
	  }
}
function addDate(value){
    var d=new Date(); 
    var mm="";
    var dd="";
    $.post("${ctx}/customerPhase/ajax?dbid="+value+"&date="+new Date(),{},function(data){
    	if(0==data||data=='0'){
    		data=30;
    	}
    	data=parseInt(data)
    	d.setDate(d.getDate()+data); 
        var m=d.getMonth()+1; 
        if(m<10){
        	mm="0"+m;
        }else{
        	mm=m;
        }
        if(d.getDate()<10){
        	dd="0"+d.getDate();
        }else{
        	dd=d.getDate();
        }
        $("#nextReservationTimeTr").show();
        $("#maxDay").val(d.getFullYear()+'-'+mm+'-'+dd+' '+d.getHours()+':'+d.getMinutes());
        
    })
  } 
function validateFrm(){
	var comeInTime=$("#comeInTime").val();
	var farwayTime=$("#farwayTime").val();
	var comeType="${customerRecord.customerType.dbid}";
	if(comeType=="1"){
		var isTryDriver=$("input[type=radio][name='tryCarStatus']:checked").val();
		if(null==isTryDriver||isTryDriver==""||isTryDriver==undefined){
			alert("请选择客户是否试驾");
			return false;
		}
	}
	if((comeInTime!=null&&comeInTime!="")&&(farwayTime!=null&&farwayTime!="")){
		var one=parseInt(comeInTime);
		var tow=parseInt(farwayTime);
		if(tow>one){
			return true;
		}else{
			var timeOne=comeInTime.split(":");
			var timeTwo=farwayTime.split(":");
			var tone=parseInt(timeOne[1])+one*60;
			var ttow=parseInt(timeTwo[1])+tow*60;
			if(ttow>=tone){
				return true;
			}
		}
		alert("离店时间必须大于进店时间！");
		return false;
	}
	return true;
}
function ajaxSubmit(url,frmId){
	var validata = validateForm(frmId);
	if(validata){
		var params = $("#"+frmId).serialize();
		var url2="";
		$.ajax({	
			url : url, 
			data : params, 
			async : false, 
			timeout : 20000, 
			dataType : "json",
			type:"post",
			success : function(data, textStatus, jqXHR){
				var obj;
				if(data.message!=undefined){
					obj=$.parseJSON(data.message);
				}else{
					obj=data;
				}
				if(obj[0].mark==1){
					//错误
					$("#showTooltips").attr("onclick",url2);
					$("#showTooltips").removeClass("weui_btn_disabled");
					alert("保存数据失败!");
					return ;
				}else if(obj[0].mark==0){
					$('#toast').show();
	                setTimeout(function () {
	                    $('#toast').hide();
	                	window.location.href = data[0].url;
	                }, 2000);
				}
			},
			complete : function(jqXHR, textStatus){
				$("#showTooltips").attr("onclick",url2);
				var jqXHR=jqXHR;
				var textStatus=textStatus;
			}, 
			beforeSend : function(jqXHR, configs){
				url2=$(".butSave").attr("onclick");
				$("#showTooltips").attr("onclick","");
				$("#showTooltips").addClass("weui_btn_disabled");
				var jqXHR=jqXHR;
				var configs=configs;
			}, 
			error : function(jqXHR, textStatus, errorThrown){
					alert("系统请求超时");
					$("#showTooltips").attr("onclick",url2);
					$("#showTooltips").removeClass("weui_btn_disabled");
			}
		});
	}
}
</script>
</html>