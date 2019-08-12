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
<title>快捷创建客户</title>
</head>
<body>
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">添加客户资料</span>
    <a class="go_home" href="${ctx }/qywxCustomer/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
 <form action="" id="frmId" name="frmId" method="post" target="_self">
<input type="hidden" id="customerBussiId" name="customerBussi.dbid" value="">
<input type="hidden" id="customerId" name="customer.dbid" value="">
<input type="hidden" id="type" name="type" value="1">
<input type="hidden" name="customerLastBussi.dbid" id="customerLastBussiId" >
<input type="hidden" name="customerShoppingRecord.dbid" id="customerShoppingRecordDbid" value="${customerShoppingRecord.dbid }">
<input type="hidden" name="customerRecordId" id="customerRecordId" value="${customerRecord.dbid }">
<div class="navbar">
	<div class="bd" style="height: 100%;">
	    <div class="weui_tab">
	        <div class="weui_navbar">
	            <div class="weui_navbar_item weui_bar_item_on">
	                基础信息
	            </div>
	            <c:if test="${customerRecord.customerType.dbid==1 }">
		            <div class="weui_navbar_item">
		                来店登记
		            </div>
	            </c:if>
	        </div>
        <div class="weui_tab_bd weui_tab_bd_on">
			<div class="weui_cells weui_cells_form">
			        <div class="weui_cell">
			            <div class="weui_cell_hd">
			            	<label class="weui_label" style="width: 80px;color: red;">客户来源</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
				            <input type="hidden" id="customerInfromId" name="customerInfromId" value="${customerRecord.customerInfrom.dbid }">
							<input type="text" readonly="readonly" id="customerRecordName" class="largeX text" name="customerRecordName" value="${customerRecord.customerInfrom.name }">
			            </div>
			        </div>
			        <div class="weui_cell">
			            <div class="weui_cell_hd">
			            	<label class="weui_label" style="width: 80px;color: red;">客户姓名</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
				            <c:if test="${customer.orderContract.status>=1}" var="status">
				                <input type="text" class="weui_input" readonly="readonly" id="name" name="customer.name" value="${customerRecord.name }" placeholder="客户姓名" checkType="string,2,12">
				            </c:if>
				            <c:if test="${status==false}">
				                <input type="text" class="weui_input" id="name" name="customer.name" value="${customerRecord.name }" placeholder="客户姓名" checkType="string,2,12">
				            </c:if>
			            </div>
			        </div>
			         <div class="weui_cell">
			            <div class="weui_cell_hd">
			            	<label class="weui_label" style="width: 80px;color: red;">电话</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
			              <c:if test="${empty(customerRecord.mobilePhone) }">
								<input type="text" readonly="readonly" class="weui_input" name="customer.mobilePhone" id="mobilePhone"  value="${param.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
							</c:if>
							<c:if test="${!empty(customerRecord.mobilePhone) }">
								<input type="text" readonly="readonly" class="weui_input" name="customer.mobilePhone" id="mobilePhone"  value="${customerRecord.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
							</c:if>
			            </div>
			        </div>
			        <div class="weui_cell weui_cell_select weui_select_after">
			            <div class="weui_cell_hd" style="color: red;">
			               	称呼
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
			                <select class="weui_select" id="sex" name="customer.sex" checkType="string,1,1" error="请选称呼">
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
			            <div class="weui_cell_bd weui_cell_primary">
			                <c:if test="${customer.lastResult==1 }" var="status">
								<input type="hidden" readonly="readonly" class="weui_input" name="brandId" id="brandId" value="${customerBussi.brand.dbid }" />
								<input type="text" readonly="readonly" class="weui_input" name="brandName" id="brandName" value="${customerBussi.brand.name }" checkType="string,1,200" tip="请选择意向车型！"/>
							</c:if>
							<c:if test="${status==false }">
								<select class="weui_select"  onchange="ajaxCarSeriy(this.value)" id="brandId" name="brandId" checkType="integer,1" error='请选择品牌'>
							  		<option value="">请选择...</option>
								  	<c:forEach var="brand" items="${brands }">
										<option value="${brand.dbid }" ${customerRecord.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
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
										<option value="${carSeriy.dbid }" ${customerRecord.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
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
										<option value="${carModel.dbid }" ${customerRecord.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
									</c:forEach>
								</select>
							</c:if>
			            </div>
			        </div>
			      <c:if test="${customerRecord.customerType.dbid==3&&!empty(customerRecord.carModels) }">
					<div class="weui_cell">
			            <div class="weui_cell_hd">
			               	<label class="weui_label" style="width: 100%;color: red;">
							留资车型
							<span style="color: red;">${customerRecord.carModels }</span>
							</label>
						</div>
					</div>
				</c:if>
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
			            	<label class="weui_label" style="width: 80px;color: red;">意向级别</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
				           <select id="customerPhaseId" name="customerPhaseId" class="weui_select" checkType="integer,1" tip="请选择客户意向级别" onchange="writeResultShow(this.value)">
								<option value="">请选择...</option>
								<c:forEach var="customerPhase" items="${customerPhases }">
									<option value="${customerPhase.dbid }" >${customerPhase.name }</option>
								</c:forEach>
							</select>
			            </div>
			        </div>
			          <div class="weui_cell" id="carColorTr" style="display: none;">
			            <div class="weui_cell_hd">
			               	<label class="weui_label" style="width: 80px;color: red;">购车颜色</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
							<select id="carColor" name="carColor" class="weui_select"  >
								<option value="0">请选择...</option>
								<c:forEach var="carColor" items="${carColors }">
									<option value="${carColor.dbid }" >${carColor.name }</option>
								</c:forEach>
							</select>
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
        <c:if test="${customerRecord.customerType.dbid==1 }">
	        <div class="weui_tab_bd">
	        	<br>
	        	<br>
				<div class="weui_cells weui_cells_form">
					 <div class="weui_cell">
	            		<div class="weui_cell_hd">
			            	<label class="weui_label" style="width: 80px;color: red;">进店时间</label>
			            </div>
			            <div class="weui_cell_bd weui_cell_primary">
							<input type="text" name="customerShoppingRecord.comeInTime" id="comeInTime" value="${customerRecord.comeInTime }" class="weui_input" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" >
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
									<option value="1" ${customerRecord.customerNum==1?'selected="selected"':'' } >1人</option>
									<option value="2" ${customerRecord.customerNum==2?'selected="selected"':'' }>2人</option>
									<option value="3" ${customerRecord.customerNum==3?'selected="selected"':'' }>3人</option>
									<option value="4" ${customerRecord.customerNum==4?'selected="selected"':'' }>4人</option>
									<option value="5" ${customerRecord.customerNum==5?'selected="selected"':'' }>5人</option>
									<option value="6" ${customerRecord.customerNum==6?'selected="selected"':'' }>6人</option>
									<option value="7" ${customerRecord.customerNum==7?'selected="selected"':'' }>7人</option>
									<option value="8" ${customerRecord.customerNum==8?'selected="selected"':'' }>8人</option>
									<option value="9" ${customerRecord.customerNum==9?'selected="selected"':'' }>9人</option>
									<option value="10" ${customerRecord.customerNum==10?'selected="selected"':'' }>10人以上</option>
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
    </c:if>
</div>
</div>
</div>
<div class="buttomBar" >
    <input type="button" name="mobileCommit" value="创建并返回线索列表" id="showTooltips1" class="weui_btn weui_btn_warn" onclick="$('#type').val(1);if(validateFrm()){ajaxSubmit('${ctx}/qywxCustomer/save','frmId')}" >
    <input type="button" name="mobileCommit" value="创建并返回客户列表" id="showTooltips2" class="weui_btn weui_btn_warn" onclick="$('#type').val(2);if(validateFrm()){ajaxSubmit('${ctx}/qywxCustomer/save','frmId')}">
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
	$.post("${ctx}/carColor/ajaxCarColorStatus?carSeriyId="+value+"&dateTime="+new Date()+"&type=2",{},function (data){
		if(data!="error"){
			$("#carColor").empty();
			$("#carColor").append(data);
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
function writeResultShow(value){
	if(value==1){
		$("#carColorTr").show();
	}else{
		$("#carColorTr").hide();
	}
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
	var type=$("#type").val();
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
					$("#showTooltips"+type).attr("onclick",url2);
					$("#showTooltips"+type).removeClass("weui_btn_disabled");
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
				$("#showTooltips"+type).attr("onclick",url2);
				var jqXHR=jqXHR;
				var textStatus=textStatus;
			}, 
			beforeSend : function(jqXHR, configs){
				url2=$(".butSave").attr("onclick");
				$("#showTooltips"+type).attr("onclick","");
				$("#showTooltips"+type).addClass("weui_btn_disabled");
				var jqXHR=jqXHR;
				var configs=configs;
			}, 
			error : function(jqXHR, textStatus, errorThrown){
					alert("系统请求超时");
					$("#showTooltips"+type).attr("onclick",url2);
					$("#showTooltips"+type).removeClass("weui_btn_disabled");
			}
		});
	}
}
</script>
</html>