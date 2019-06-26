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
<script type="text/javascript" src="${ctx }/pages/cust/customer/customer.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	#carColor{
		width: 280px;
	}
</style>
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/customer/customerShoppingRecordqueryList'">客户管理</a>-
	<a href="javascript:void(-1)" class="current">
		来店登记
	</a>
</div>
<div id="frmContent" class="frmContent">
   <form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
   	<input type="hidden" name="red" id="red" value="0">
   	<input type="hidden" name="customerBussi.dbid" id="customerBussiDbid" >
   	<input type="hidden" name="customerLastBussi.dbid" id="customerLastBussiId" >
   	<input type="hidden" name="customerRecordId" id="customerRecordId" value="${customerRecord.dbid }">
   	<div class="frmTitle" onclick="showOrHiden('contactTable')">基础档案</div>
	   <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr>
				<td class="formTableTdLeft">登记时间：</td>
				<td>
						<input type="text"  readonly="readonly" class="largeX text" name="customerShoppingRecord.comeInDate" id="comeInDate"  value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd HH:mm" />'  />
				</td>
				<td class="formTableTdLeft">客户来源：</td>
				<td >
					<input type="hidden" id="customerInfromId" name="customerInfromId" value="${customerRecord.customerInfrom.dbid }">
					<input type="text" readonly="readonly" id="customerRecordName" class="largeX text" name="customerRecordName" value="${customerRecord.customerInfrom.name }">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">客户姓名：</td>
				<td>
					<input type="text" class="mideaX text" name="customer.name" id="name"  value="${customerRecord.name }" checkType="string,1,20" placeholder="请输入客户姓名"  tip="客户姓名不能为空！请输入客户姓名！"/>
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
				<td class="formTableTdLeft">常用手机号：</td>
				<td>
					<c:if test="${empty(customerRecord.mobilePhone) }">
						<input type="text" readonly="readonly" class="largeX text" name="customer.mobilePhone" id="mobilePhone"  value="${param.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
					</c:if>
					<c:if test="${!empty(customerRecord.mobilePhone) }">
						<input type="text" readonly="readonly" class="largeX text" name="customer.mobilePhone" id="mobilePhone"  value="${customerRecord.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
					</c:if>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">品牌：</td>
				<td>
					<select id="brandId" name="brandId" class="largeX text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
						<option value="">请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${customerRecord.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft" >意向车型：</td>
				<td id="carModelLabel">
					<c:if test="${!empty(customerRecord)&&!empty(customerRecord.brand) }" var="status">
						<select id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${customerRecord.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							</c:forEach>
						</select>
						<select id="carModelId" name="carModelId" class="mideaX text" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }" ${customerRecord.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${status==false }">
						<select id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1"  tip="请选择车系">
							<option value="">请先选择品牌...</option>
						</select>
					</c:if>
				</td>
			</tr>
			<c:if test="${enterprise.bussiType==3 }" var="statusss">
				<tr>
					<td class="formTableTdLeft">具体车型：</td>
					<td>
						<c:if test="${!empty(customerRecord) }" >
							<input type="text" class="largeX text" name="customer.carModelStr" id="carModelStr"  value="${customerRecord.carModelStr }" onfocus="ajaxCarModel('carModelStr')" checkType="string,1,50" placeholder="请输入车型"  tip="请输入车型！"/>
						</c:if>
						<c:if test="${empty(customerRecord) }" >
							<input type="text" class="largeX text" name="customer.carModelStr" id="carModelStr"  value="${customer.carModelStr }" onfocus="ajaxCarModel('carModelStr')" checkType="string,1,50" placeholder="请输入车型"  tip="请输入车型！"/>
						</c:if>
					</td>
					<td class="formTableTdLeft">指导价：</td>
					<td>
						<input type="text" class="largeX text" name="customer.navPrice" id="navPrice"  value="${customer.navPrice }" checkType="float"  tip="请输入指导价"/>
						<span style="color: red;">*</span>
					</td>
				</tr>
			</c:if>
			<c:if test="${customerRecord.customerType.dbid==3&&!empty(customerRecord.carModels) }">
				<tr>
					<td class="formTableTdLeft">
						留资车型
					</td>
					<td colspan="3">
						<span style="color: red;">${customerRecord.carModels }</span>
					</td>
				</tr>
			</c:if>
			<tr>
				<td class="formTableTdLeft">意向级别：</td>
				<td >
					<select id="customerPhaseId" name="customerPhaseId" class="largeX text" checkType="integer,1" tip="请选择客户意向级别" onchange="writeResultShow(this.value)">
						<option value="">请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
							<option value="${customerPhase.dbid }" >${customerPhase.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">同城交叉客户：</td>
				<td >
						<select id="cityCrossCustomerId" name="cityCrossCustomerId" class="largeX text" checkType="integer,1" tip="请选择同城交叉客户">
						<option value="">请选择...</option>
						<c:forEach var="cityCrossCustomer" items="${cityCrossCustomers }">
							<option value="${cityCrossCustomer.dbid }" ${customer.cityCrossCustomer.dbid==cityCrossCustomer.dbid?'selected="selected"':'' } >${cityCrossCustomer.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr id="carColorTr" style="display: none;">
				<td class="formTableTdLeft">购车颜色:&nbsp;</td>
				<td id="carColorId">
					<select id="carColor" name="carColor" class="largeX text"  checkType="integer,1">
						<option value="0">请选择...</option>
						<c:forEach var="carColor" items="${carColors }">
							<option value="${carColor.dbid }" >${carColor.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">地域：</td>
				<td id="areaLabel" colspan="3">
					<input type="hidden" name="areaId" value="${memberInfo.area.dbid }" id="areaId">
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
				
			</tr>
			<tr>
				<td class="formTableTdLeft">身份证地址：</td>
				<td colspan="3">
					<input  name="customer.address" class="largeXXX text" id=address title="" value="${customer.address }" placeholder="请填写街道地址"></input>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea  name="customer.note" id="note"	 class="textarea largeXXX text" title=""  tip="请填写一点备注吧">${customer.note }</textarea>	
				</td>
			</tr>
		</table>
	<c:if test="${customerRecord.customerType.dbid==1 }">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">来店登记</div>
			 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
				<tr>
				    <td class="formTableTdLeft">进店时间：</td>
					<td>
						<input type="text" name="customerShoppingRecord.comeInTime" id="comeInTime" value="${customerRecord.comeInTime }" class="largeX text" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择到店时间">
						<span style="color: red;">*</span>
					</td>
					<td>
						离店时间：
					</td>
					<td>
						<input type="text" name="customerShoppingRecord.farwayTime" id="farwayTime" value="${customerRecord.comeInTime }" class="largeX text" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});"  checkType="string,1" tip="请选择到店时间">
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">停留时间：</td>
					<td>
						<select id="waitingTime" name="customerShoppingRecord.waitingTime" class="largeX text">
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
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">
						客户随行人数：
					</td>
					<td>
						<select id="customerNum" name="customerShoppingRecord.customerNum" class="largeX text">
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
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">是否试驾<span style="color: red;">*</span>：</td>
					<td colspan="1">
						<label><input  type="radio"  id="tryCarStatus" name="tryCarStatus" ${customer.tryCarStatus==2?'checked="checked"':'' }   value="1">已试驾</label>
						<label><input  type="radio"  id="tryCarStatus" name="tryCarStatus"    value="1">未试驾</label>
					</td>
					<td class="formTableTdLeft">
						试驾专员：
					</td>
					<td>
						<input name="customerShoppingRecord.tryDriver"  class="largeX text" id="tryDriver"  value="${customerShoppingRecord.tryDriver }" ></input>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">客户是否有车：</td>
					<td >
						<label ><input  type="checkbox" id="isGetCar" name="customerShoppingRecord.isGetCar"  ${customerShoppingRecord.isGetCar==true?'checked="checked"':'' } value="true"> 客户是否有车</label>
					</td>
					 <td class="formTableTdLeft">客户车型：</td>
					<td>
						<input  type="text" class="largeX text" id="carModel" name="customerShoppingRecord.carModel"   value="${customerShoppingRecord.carModel }">
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">购车时间：</td>
					<td>
						<select id="trackingPhaseId" name="trackingPhaseId" class="largeX text">
							<option value="">请选择...</option>
							<c:forEach var="trackingPhase" items="${trackingPhases }">
								<option value="${trackingPhase.dbid }" ${customerBussi.trackingPhase.dbid==trackingPhase.dbid?'selected="selected"':'' } >${trackingPhase.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr style="height: 100px;">
					<td class="formTableTdLeft">接待经过：</td>
					<td  colspan="3">
						<textarea class="largeXXX text" style="height: 92px;" name="customerShoppingRecord.receptionExperience" id="receptionExperience"  value="">${customerShoppingRecord.receptionExperience }</textarea>
					</td>
				</tr>
			</table>
		</c:if>
		<div class="formButton">
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#red').val(0);if(validateFrm()){$.utile.submitAjaxForm('frmId','${ctx}/customer/saveCustomerShoppingRecord')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
		    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
		</div>
</form>                            
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
	$.post("${ctx}/carSeriy/ajaxCarSeriyByStatus?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}
function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	$("#carColorId").text("");
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/carModel/ajaxCarModelBySeriyStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
	$.post("${ctx}/carColor/ajaxCarColorStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carColorId").append(data);
		}
	});
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
function writeResultShow(value){
	if(value==1){
		$("#carColorTr").show();
	}else{
		$("#carColorTr").hide();
	}
}
</script>
</html>
