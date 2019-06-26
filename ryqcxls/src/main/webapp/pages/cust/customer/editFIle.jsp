<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>客户添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/jqueryui/themes/base/jquery-ui.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.core.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.widget.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.tabs.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<script type="text/javascript">
$(function() {
	$( "#frmContent" ).tabs();
});
</script>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/customer/queryList'">客户类型</a>-
	<a href="javascript:void(-1)" class="current">
		<c:if test="${customer.dbid>0 }" var="status">编辑客户</c:if>
		<c:if test="${status==false }">添加客户</c:if>
	</a>
</div>
<div id="frmContent" class="frmContent">
    <ul style="list-style: none;">
		<li><a href="#baseInfor">基本信息</a></li>
		<li><a href="#shoppingRecord">来店登记</a></li>
		<li><a href="#needInfo">需求评估</a></li>
		<li><a href="#realtInof">第一次接待结果</a></li>
	</ul>
   <form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
   <div id="baseInfor">
		<c:if test="${customer.orderContract.status>=1}" var="status">
	   		<div class="alert alert-info">
					<strong>提示!</strong> 
					订单已经提交，深色框体内容不可更改！
			</div>
		</c:if>
	   <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<input type="hidden" value="${customer.dbid }" id="dbid" name="customer.dbid">
			<input type="hidden" value="${customer.lastResult }" id="lastResult" name="customer.lastResult">
			<input type="hidden" value="${customer.firstCustomerPhase.dbid }" id="firstCustomerPhaseDbid" name="firstCustomerPhaseDbid">
			<input type="hidden" value="${customer.orderContractStatus }" id="orderContractStatus" name="customer.orderContractStatus">
			<tr>
				<td class="formTableTdLeft">制卡日期：</td>
				<td>
					<c:if test="${empty(customer) }">
						<input type="text" readonly="readonly" class="largeX text" name="customer.createFolderTime" id="createFolderTime"  value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd HH:mm" />'  />
					</c:if>
					<c:if test="${!empty(customer) }">
					<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm" var="createFolderTime"/>
						<input type="text" readonly="readonly"  class="largeX text" name="customer.createFolderTime" id="createFolderTime"  value='${createFolderTime }'  />
					</c:if>
				</td>
				<td class="formTableTdLeft">品牌：</td>
				<td>
					<c:if test="${customer.lastResult==1 }" var="status">
						<input type="hidden" readonly="readonly" class="small text" name="brandId" id="brandId" value="${customerBussi.brand.dbid }" />
						<input type="text" readonly="readonly" class="largeX text" name="brandName" id="brandName" value="${customerBussi.brand.name }" checkType="string,1,200" tip="请选择意向车型！"/>
					</c:if>
					<c:if test="${status==false }">
						<select id="brandId" name="brandId" class="midea text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${customerBussi.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >意向车型：</td>
				<td id="carModelLabel">
					<c:if test="${customer.lastResult==1 }" var="status">
						<input type="hidden" id="carSeriyId" name="carSeriyId" value="${customerBussi.carSeriy.dbid }" />
						<input type="text" readonly="readonly" class="small text" name="carSeriyName" id="carSeriyName" value="${customerBussi.carSeriy.name }" checkType="string,1,200" tip="请选择意向车型！"/>
						<input type="hidden" id="carModelId" name="carModelId" value="${customerBussi.carModel.dbid }" />
						<input type="text" readonly="readonly" class="media text" name="carSeriyName" id="carSeriyName" value="${customerBussi.carModel.name }"  checkType="string,1,200" tip="请选择意向车型！"/>
					</c:if>
					<c:if test="${status==false }">
						<c:if test="${empty(customerBussi) }" var="status">
							<select id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')">
								<option value="">请选择...</option>
								<c:forEach var="carSeriy" items="${carSeriys }">
									<option value="${carSeriy.dbid }" ${customerBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${status==false }">
							<select id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
								<option value="">请选择...</option>
								<c:forEach var="carSeriy" items="${carSeriys }">
									<option value="${carSeriy.dbid }" ${customerBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
								</c:forEach>
							</select>
							<select id="carModelId" name="carModelId" class="mideaX text" checkType="integer,1" tip="请选择意向车型！">
								<option value="">请选择...</option>
								<c:forEach var="carModel" items="${carModels }">
									<option value="${carModel.dbid }" ${customerBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
								</c:forEach>
							</select>
						</c:if>
					</c:if>
				</td>
				<td class="formTableTdLeft">客户来源：</td>
				<td >
					<input type="hidden" name="customerBussi.dbid" id="customerBussiDbid" value="${customerBussi.dbid }" >
					<select id="infoFromId" name="infoFromId" class="midea text" checkType="integer,1" tip="请选择客户来源！">
						<option value="">请选择...</option>
						<c:forEach var="infoFrom" items="${infoFroms }">
							<c:if test="${ infoFrom.dbid>58}">
								<option value="${infoFrom.dbid }" ${customerBussi.infoFrom.dbid==infoFrom.dbid?'selected="selected"':'' } >${infoFrom.name }</option>
							</c:if>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">类型：</td>
				<td>
					<select id="comeType" name="customerShoppingRecord.comeType" class="midea text">
						<option value="">请选择...</option>
							<option value="1"  ${customerShoppingRecord.comeType==1?'selected="selected"':'' } >来店</option>
							<option value="2"  ${customerShoppingRecord.comeType==2?'selected="selected"':'' }>来电</option>
							<option value="3"  ${customerShoppingRecord.comeType==3?'selected="selected"':'' }>活动</option>
							<option value="4"  ${customerShoppingRecord.comeType==4?'selected="selected"':'' }>特卖会</option>
					</select>
				</td>
				<td class="formTableTdLeft">意向级别：</td>
				<td >
					<c:if test="${!empty(customer.lastResult) }">
						<input type="hidden" readonly="readonly" class="largeX text"  name="customerPhaseId" id="customerPhaseId"  value="${customer.customerPhase.dbid }">
						<input type="text" readonly="readonly" class="largeX text"    value="${customer.customerPhase.name }">
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">客户姓名：</td>
				<td>
					<c:if test="${customer.orderContract.status>=1}" var="status">
						<input type="text" class="mediaX text" readonly="readonly" name="customer.name" id="name"  value="${customer.name }" checkType="string,1,20" placeholder="请输入客户姓名"  tip="客户姓名不能为空！请输入客户姓名！"/>
					</c:if>
					<c:if test="${status==false }">
						<input type="text" class="mediaX text"  name="customer.name" id="name"  value="${customer.name }" checkType="string,1,20" placeholder="请输入客户姓名"  tip="客户姓名不能为空！请输入客户姓名！"/>
					</c:if>
					<span style="color: red;">*</span>
					<c:if test="${empty(customer) }">
						<label><input type="radio" id="sex" name="customer.sex" value="男"  checked="checked">男</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="customer.sex" value="女" >女</label>
					</c:if>
					<c:if test="${!empty(customer) }">
						<label><input type="radio" id="sex" name="customer.sex" value="男" ${customer.sex=='男'?'checked="checked"':'' }>男</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="sex2" name="customer.sex" value="女" ${customer.sex=='女'?'checked="checked"':'' } >女</label>
					</c:if>
				</td>
				<td class="formTableTdLeft">同城交叉客户：</td>
				<td >
					<select id="cityCrossCustomerId" name="cityCrossCustomerId" class="midea text" checkType="integer,1" tip="请选择同城交叉客户">
						<option value="">请选择...</option>
						<c:forEach var="cityCrossCustomer" items="${cityCrossCustomers }">
							<option value="${cityCrossCustomer.dbid }" ${customer.cityCrossCustomer.dbid==cityCrossCustomer.dbid?'selected="selected"':'' } >${cityCrossCustomer.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				
			</tr>
			<tr>
				<td class="formTableTdLeft">常用手机号：</td>
				<td>
					<c:if test="${customer.orderContract.status>=1}" var="status">
						<input type="text" class="largeX text" readonly="readonly" name="customer.mobilePhone" id="mobilePhone"  value="${customer.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
					</c:if>
					<c:if test="${status==false }">
						<input type="text" class="largeX text" name="customer.mobilePhone" id="mobilePhone"  value="${customer.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
					</c:if>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">家用电话：</td>
				<td>
					<input type="text" class="largeX text" name="customer.phone" id="phone"  value="${customer.phone }" checkType="string,1,20" canEmpty="Y" tip="请输入家用电话或手机号码，可以为空家用电话格式如：028-62312332"/>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">证件信息：</td>
				<td>
					<c:if test="${customer.orderContract.status>=1}" var="status">
							<input type="hidden" id="paperworkId" name="paperworkId" value="${customer.paperwork.dbid }">						
							<input type="" class="largeX text" id="" name="" value="${customer.paperwork.name }" readonly="readonly">		
					</c:if>
					<c:if test="${status==false }">
							<select id="paperworkId" name="paperworkId" class="midea text">
							<option value="">请选择...</option>
							<c:forEach var="paperwork" items="${paperworks }">
								<option value="${paperwork.dbid }" ${customer.paperwork.dbid==paperwork.dbid?'selected="selected"':'' } >${paperwork.name }</option>
							</c:forEach>
						</select>				
					</c:if>
				</td>
				<td class="formTableTdLeft">证件号码：</td>
				<td>
					<c:if test="${customer.orderContract.status>=1}" var="status">
							<input type="text"  readonly="readonly" class="largeX text" name="customer.icard" id="icard"  value="${customer.icard }" />	
					</c:if>
					<c:if test="${status==false }">
							<input type="text"  class="largeX text" name="customer.icard" id="icard"  value="${customer.icard }" />	
					</c:if>
				</td>
			</tr>
			<tr>
				<c:if test="${customer.orderContract.status>=1}" var="status">
					<td class="formTableTdLeft">地域：</td>
						<td id="areaLabel">
							<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
							<input type="text" class="largeX text" readonly="readonly" value="${customer.area.fullName }" >
						</td>
						<td class="formTableTdLeft">身份证地址：</td>
						<td>
							<input readonly="readonly"  name="customer.address" class="largeX text" id=address title="" value="${customer.address }" placeholder="请填写街道地址"></input>
						</td>
				</c:if>
				<c:if test="${status==false }">
					<td class="formTableTdLeft">地域：</td>
					<td id="areaLabel">
						<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
						<c:if test="${empty(areaSelect) }">
							<select id="areoD" name="areoD" class="midea text" onchange="ajaxArea(this)">
								<option>请选择...</option>
								<c:forEach items="${areas }" var="area">
									<option  value="${area.dbid }">${area.name }</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${!empty(areaSelect) }">
							${areaSelect }
						</c:if>
					</td>
					<td class="formTableTdLeft">地址：</td>
					<td>
						<input  name="customer.address" class="largeX text" id=address title="" value="${customer.address }" placeholder="请填写街道地址"></input>
					</td>
				</c:if>
			</tr>
			<tr>
				
				<td class="formTableTdLeft">生日：</td>
				<td>
					<input type="text" class="largeX text" name="customer.nbirthday" onmouseout="" onFocus="WdatePicker({isShowClear:false,readOnly:true});getBirthdayAge(this.value,'age')" id="nbirthday"  value="<fmt:formatDate value="${customer.nbirthday }"/>" />
				</td>
				<td class="formTableTdLeft" >年龄：</td>
				<td >
					<input type="text"   class="largeX text" name="customer.age" id="age"   value="${customer.age }" placeholder="填写生日自动生成"/>
				</td>
			</tr>
				<tr>
					<td>
						单位信息：
					</td>
					<td>
						<input name="customer.companyName1"  class="largeX text" id="companyName1" title="售出后"  value="${customer.companyName1 }" ></input>
					</td>
					
					<td class="formTableTdLeft">QQ/MSN：</td>
					<td>
						<input type="text"   class="largeX text" name="customer.qq" id="qq" value="${customer.qq }" checkType="qq" canEmpty="Y" tip="请输入QQ！可以为空">
					</td>
				</tr>
			<tr>
			    <td class="formTableTdLeft">家庭情况：</td>
				<td>
					<input  type="text" class="largeX text" id="family" name="customer.family"   value="${customer.family }">
				</td>
				<td class="formTableTdLeft">EMAIL：</td>
					<td>
						<input  type="text" id="email" class="largeX text" name="customer.email"  checkType="email" canEmpty="Y" tip="请输入email，可以为空,email格式如：shu***@163.com"   value="${customer.email }">
					</td>
			</tr>
			
			<tr>
				<td class="formTableTdLeft" >邮编：</td>
				<td >
					<input type="text"  class="midea text" name="customer.zipCode" id="zipCode" checkType="zipCode" canEmpty="Y" tip="请输入邮编,可以为空,邮编格式如：600101"  value="${customer.zipCode }" />
				</td>
				<td class="formTableTdLeft">行业：</td>
				<td>
						<select id="industryId" name="industryId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="industry" items="${industries }">
							<option value="${industry.dbid }" ${customer.industry.dbid==industry.dbid?'selected="selected"':'' } >${industry.name }</option>
						</c:forEach>
					</select>
				</td>
				
			</tr>
			<tr>
				<td class="formTableTdLeft">职业：</td>
				<td>
					<select id="professionId" name="professionId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="profession" items="${professions }">
							<option value="${profession.dbid }" ${customer.profession.dbid==profession.dbid?'selected="selected"':'' } >${profession.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft">学历：</td>
				<td>
						<select id="educationalId" name="educationalId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="educational" items="${educationals }">
							<option value="${educational.dbid }" ${customer.educational.dbid==educational.dbid?'selected="selected"':'' } >${educational.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
			    <td class="formTableTdLeft">业务员：</td>
				<td>
					<input  type="text" readonly="readonly" class="largeX text" id="bussiStaff" name="customer.bussiStaff"   value="${sessionScope.user.realName }">
				</td>
				
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">兴趣爱好：</td>
				<td  colspan="3">
					<textarea type="text" class="largeX text" style="height: 60px;width: 600px;" name="customer.interests" id="interests"  value="">${customer.interests }</textarea>
				</td>
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">备注：</td>
				<td  colspan="3">
					<textarea type="text" class="largeX text" style="height: 92px;width: 600px;" name="customer.note" id="note"  value="">${customer.note }</textarea>
				</td>
			</tr>
		</table>
	</div>
	<div id="shoppingRecord">
		<input type="hidden" name="customerShoppingRecord.dbid" id="customerShoppingRecordDbid" value="${customerShoppingRecord.dbid }">
		 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr>
				
				<td class="formTableTdLeft">进店时间：</td>
				<td>
					<select id="comeInTime" name="customerShoppingRecord.comeInTime" class="midea text" onchange="">
						<option value="">请选择...</option>
						<c:forEach begin="0" end="12" step="1" var="time" varStatus="i">
								<option value="${i.index*2 }" ${customerShoppingRecord.comeInTime==i.index*2?'selected="selected"':'' } >${i.index+8 }:00</option>
								<option value="${i.index*2+1 }"  ${customerShoppingRecord.comeInTime==(i.index*2+1)?'selected="selected"':'' }>${i.index+8 }:30</option>
						</c:forEach>
					</select>
				</td>
				<td>
					离店时间：
				</td>
				<td>
					<select id="farwayTime" name="customerShoppingRecord.farwayTime" class="midea text" onchange="if($('#farwayTime').val()<$('#comeInTime').val()){">
						<option value="">请选择...</option>
						<c:forEach begin="0" end="12" step="1" var="time" varStatus="i">
								<option value="${i.index*2 }" ${customerShoppingRecord.farwayTime==i.index*2?'selected="selected"':'' } >${i.index+8 }:00</option>
								<option value="${i.index*2+1 }"  ${customerShoppingRecord.farwayTime==(i.index*2+1)?'selected="selected"':'' }>${i.index+8 }:30</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				
				<td class="formTableTdLeft">停留时间：</td>
				<td>
					<select id="waitingTime" name="customerShoppingRecord.waitingTime" class="midea text">
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
				</td>
				<td class="formTableTdLeft">
					客户随性人数：
				</td>
				<td>
					<select id="customerNum" name="customerShoppingRecord.customerNum" class="mediaX text">
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
				</td>
			</tr>
			<tr>
			    <td class="formTableTdLeft">设置：</td>
				<td>
					<label><input  type="checkbox"  id="isTryDriver" name="customerShoppingRecord.isTryDriver" ${customerShoppingRecord.isTryDriver==1?'checked="checked"':'' }   value="true"> 是否试驾</label>
					<label><input  type="checkbox"  id="isFirst" name="customerShoppingRecord.isFirst"  ${customerShoppingRecord.isFirst==true?'checked="checked"':'' }  value="true"> 是否首次来店</label>
					<label ><input  type="checkbox" id="isGetCar" name="customerShoppingRecord.isGetCar"  ${customerShoppingRecord.isGetCar==true?'checked="checked"':'' } value="true"> 客户是否有车</label>
				</td>
				<td class="formTableTdLeft">
					试驾专员：
				</td>
				<td>
					<input name="customerShoppingRecord.tryDriver"  class="mediaX text" id="tryDriver"  value="${customerShoppingRecord.tryDriver }" ></input>
				</td>
			</tr>
			<tr>
			    <td class="formTableTdLeft">客户车型：</td>
				<td>
					<input  type="text" class="largeX text" id="carModel" name="customerShoppingRecord.carModel"   value="${customerShoppingRecord.carModel }">
				</td>
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">接待经过：</td>
				<td  colspan="3">
					<textarea type="text" class="largeX text" style="height: 92px;width: 600px;" name="customerShoppingRecord.receptionExperience" id="receptionExperience"  value="">${customerShoppingRecord.receptionExperience }</textarea>
				</td>
			</tr>
		</table>
	</div>
	<div id="needInfo">
		<div class="alert alert-info">
			<strong>提示!</strong> 初次需求评估（根据实际情况填写）！
		</div>
	 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr>
				<td class="formTableTdLeft">购车关注点：</td>
				<td>
					<select id="buyCarCareId" name="buyCarCareId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="buyCarCare" items="${buyCarCares }">
							<option value="${buyCarCare.dbid }" ${customerBussi.buyCarCare.dbid==buyCarCare.dbid?'selected="selected"':'' } >${buyCarCare.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft">购车主要目的：</td>
				<td>
					<select id="buyCarTargetId" name="buyCarTargetId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="buyCarTarget" items="${buyCarTargets }">
							<option value="${buyCarTarget.dbid }" ${customerBussi.buyCarTarget.dbid==buyCarTarget.dbid?'selected="selected"':'' } >${buyCarTarget.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				
				<td class="formTableTdLeft">购车类型：</td>
				<td>
					<select id="buyCarTypeId" name="buyCarTypeId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="buyCarType" items="${buyCarTypes }">
							<option value="${buyCarType.dbid }" ${customerBussi.buyCarType.dbid==buyCarType.dbid?'selected="selected"':'' } >${buyCarType.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft" >购车预算：</td>
				<td >
					<select id="buyCarBudgetId" name="buyCarBudgetId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="buyCarBudget" items="${buyCarBudgets }">
							<option value="${buyCarBudget.dbid }" ${customerBussi.buyCarBudget.dbid==buyCarBudget.dbid?'selected="selected"':'' } >${buyCarBudget.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">主要使用者：</td>
				<td >
					<select id="buyCarMainUseId" name="buyCarMainUseId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="buyCarMainUse" items="${buyCarMainUses }">
							<option value="${buyCarMainUse.dbid }" ${customerBussi.buyCarMainUse.dbid==buyCarMainUse.dbid?'selected="selected"':'' } >${buyCarMainUse.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft">购车时间：</td>
				<td>
					<select id="trackingPhaseId" name="trackingPhaseId" class="midea text">
						<option value="">请选择...</option>
						<c:forEach var="trackingPhase" items="${trackingPhases }">
							<option value="${trackingPhase.dbid }" ${customerBussi.trackingPhase.dbid==trackingPhase.dbid?'selected="selected"':'' } >${trackingPhase.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">备注：</td>
				<td>
					<textarea type="text" class="largeX text" name="customerBussi.note" id="cutNote"  style="height: 92px;width: 600px;">${customerBussi.note }</textarea>
				</td>				
			</tr>
		</table>
	</div>
	<div id="realtInof">
		<div class="alert alert-info">
			<strong>提示!</strong> 结合初次接待洽谈实际情况分析并填写！
		</div>
	 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr style="height: 100px;">
				<td class="formTableTdLeft">客户特征：</td>
				<td>
					<textarea type="text" class="largeX text" name="customerBussi.customerSpecification" id="customerSpecification"    style="height: 92px;width: 600px;">${customerBussi.customerSpecification }</textarea>
				</td>
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">客户需求：</td>
				<td>
					<textarea type="text" class="largeX text" name="customerBussi.customerNeed" id="customerNeed"   style="height: 92px;width: 600px;">${customerBussi.customerNeed }</textarea>
				</td>
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft" >主要关注竞品：</td>
				<td >
					<textarea type="text"  class="largeX text" name="customerBussi.customerCareAbout" id="customerCareAbout"   style="height: 92px;width: 600px;">${customerBussi.customerCareAbout }</textarea>
				</td>
			</tr>
			<tr style="height: 100px;">
				<td class="formTableTdLeft">其它重点描述：</td>
				<td>
					<textarea type="text" class="largeX text" name="customerBussi.otherMainDescription" id="otherMainDescription"   style="height: 92px;width: 600px;">${customerBussi.otherMainDescription }</textarea>
				</td>
			</tr>
				<tr style="height: 100px;">
					<td class="formTableTdLeft">后续跟进计划：</td>
					<td>
						<textarea  type="text" id="afterPlan" name="customerBussi.afterPlan"  class="largeX text"  value="" style="height: 92px;width: 600px;">${customerBussi.afterPlan }</textarea>
					</td>
				</tr>
		</table>
	</div>
</form>                            
<div class="formButton">
		<a href="javascript:void(-1)" id="sbmId"	onclick="if(validateFrm()){$.utile.submitAjaxForm('frmId','${ctx}/customer/save')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
/**
 * 通过生日 获取 年龄
 * @param strBirthday
 * @returns
 */
function getBirthdayAge(strBirthday,targetValue)
{       
    var returnAge;
    strBirthday =  strBirthday.replace(/-/g,"/");
	var oDate1 = new Date(strBirthday);
    var birthYear = oDate1.getYear();
    var birthMonth = oDate1.getMonth() + 1;
    var birthDay = oDate1.getDate();
    
    nowDate = new Date();
    var nowYear = nowDate.getYear();
    var nowMonth = nowDate.getMonth() + 1;
    var nowDay = nowDate.getDate();
    if(nowYear == birthYear)
    {
        returnAge = 0;//同年 则为0岁
    }
    else
    {
        var ageDiff = nowYear - birthYear ; //年之差
        if(ageDiff > 0)
        {
            if(nowMonth == birthMonth)
            {
                var dayDiff = nowDay - birthDay;//日之差
                if(dayDiff < 0)
                {
                    returnAge = ageDiff - 1;
                }
                else
                {
                    returnAge = ageDiff ;
                }
            }
            else
            {
                var monthDiff = nowMonth - birthMonth;//月之差
                if(monthDiff < 0)
                {
                    returnAge = ageDiff - 1;
                }
                else
                {
                    returnAge = ageDiff ;
                }
            }
        }
        else
        {
            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
        }
    }
    $("#"+targetValue).val(returnAge);
}
function ajaxArea(sel){
	var value=$(sel).val();
	$("#areaId").val(value);
	var sle= $(sel).nextAll();
	$(sle).remove();
	$.post("${ctx}/area/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#areaLabel").append(data);
		}
	});
}
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelId").remove();
	$("#carSeriyId").remove();
	$.post("${ctx}/carSeriy/ajaxCarSeriy?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}
function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/carModel/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}
function validateFrm(){
	var comeInTime=$("#comeInTime").val();
	var farwayTime=$("#farwayTime").val();
	if((comeInTime!=null&&comeInTime!="")&&(farwayTime!=null&&farwayTime!="")){
		var one=parseInt(comeInTime);
		var tow=parseInt(farwayTime);
		if(one>=tow){
			alert("离店时间必须大于进店时间！");
			return false;
		}
		return true;
	}
	return true;
	
}
</script>
</html>
