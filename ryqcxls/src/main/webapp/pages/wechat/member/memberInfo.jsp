<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" type="text/css"  href="${ctx }/css/weixin.css"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"  src="${ctx }/widgets/utile/weixin.js"></script>
<title>完善会员资料</title>
<script type="text/javascript">
function validateFrm(){
	var name=$("#name").val();
	var phone=$("#mobilePhone").val();
	if(name==''||name.length<=0){
		$("#name").focus();
		return false;
	}
	if(phone==''||phone.length<=0){
		$("#mobilePhone").focus();
		return false;
	}else{
		if(checkMobilePhone(phone)==true||checkPhone(phone)==true){
		}else{
			$("#mobilePhone").focus();
			return false;
		}
	}
	return true;	
}
function ajaxSubmit(url){
	var state=validateFrm();
	if(state){
		var params = $("#frmId").serialize();
		$.post(url,params,function callBack(data) {
			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
				// 保存数据成功时页面需跳转到列表页面
				$("#message").addClass("alert alert-success");
				$("#message").text(data[0].message);
				$("#message").css("display","");
				$("#message").show();
				$("#subButton").attr("onclick","")
				$("#subButton").find("a").css("color","#E3E0D5");
				window.setTimeout("window.location.href='"+data[0].url+"'",3000);
			}
			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
				// 保存失败时页面停留在数据编辑页面
				$("#message").addClass("alert alert-error");
				$("#message").text(data[0].message);
				$("#message").css("display","");
				$("#message").show();
			}
			return;
		});
	}
}
</script>
</head>
<body>
  <div class="formContent">
  	<div id="message" class="" style="display: none;">
  	</div>
  	<form action="" id="frmId" method="post">
  		<input type="hidden" value="${param.wechat_id }" id="microId" name="member.microId">
  		<input type="hidden" value="${member.dbid }" id="dbid" name="member.dbid">
  		<input type="hidden" value="${memberInfo.dbid }" id="memberInfoId" name="memberInfo.dbid">
  	<%-- 	<div class="memberInput frist" style="margin-top: 12px;">
  			<label><input type="radio" checked="checked" name="member.hasCar" id="hasCar" value="1" ${member.hasCar==1?'checked="checked"':'' }/> 我有奇瑞车</label>
  			<label><input type="radio" name="member.hasCar" id="hasCar" ${member.hasCar==2?'checked="checked"':'' }  value="2" /> 我没车</label>
  			<label><input type="radio" name="member.hasCar" id="hasCar" value="3" ${member.hasCar==3?'checked="checked"':'' }/> 我有车</label>
  		</div> --%>
  		<div class="memberLabel" style="margin-top: 24px;">
  			<label><span style="color: red;">*</span>会员名称</label>
  		</div>
  		<div class="memberInput">
  			<input type="text"  placeholder="请填写您的真实姓名" name="member.name" id="name" value="${member.name }" class="textfield" />
  		</div>
  		<div class="memberLabel">
  			<label><span style="color: red;"></span>车型</label>
  		</div>
  		<div class="memberInput">
  			<input type="text" placeholder="您的车型" name="member.car" id="car"  value="${member.car }" class="textfield" />
  		</div>
  		<div class="memberLabel">
  			<label><span style="color: red;"></span>车牌号</label>
  		</div>
  		<div class="memberInput">
  			<input type="text" placeholder="您的车牌号" name="member.carNo" id="carNo"  value="${member.carNo }" class="textfield" />
  		</div>
  		<div class="memberLabel">
  			<label>性别</label>
  		</div>
  		<div class="memberInput" style="height: 30px;">
  			<c:if test="${!empty(member) }">
	  			<label for="sex1"><input type="radio"  name="member.sex" id="sex1" value="男" ${member.sex=='男'?'checked="checked"':'' }/> 男</label>
	  			&nbsp;&nbsp;&nbsp;&nbsp;
	  			<label for="sex2"><input type="radio" name="member.sex" id="sex2" value="女" ${member.sex=='女'?'checked="checked"':'' } /> 女</label>
  			</c:if>
  			<c:if test="${empty(member) }">
	  			<label for="sex1"><input type="radio" checked="checked" name="member.sex" id="sex1" value="男" /> 男</label>
	  			&nbsp;&nbsp;&nbsp;&nbsp;
	  			<label for="sex2"><input type="radio" name="member.sex" id="sex2" value="女" /> 女</label>
  			</c:if>
  		</div>
  		<div class="memberLabel">
  			<label>生日</label>
  		</div>
  		<div class="memberInput">
  			<input type="date" placeholder="请输入生日" name="member.birthday" id="birthday" value='<fmt:formatDate value="${member.birthday }" pattern="yyyy-MM-dd"/>' class="textfield" />
  		</div>
  		<div class="memberLabel">
  			<label>地区</label>
  		</div>
  		<div class="memberInput" id="areaLabel">
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
  		</div>
  		<div class="memberLabel">
  			<label>详细地址</label>
  		</div>
  		<div class="memberInput">
  			<input type="text" placeholder="请输详细地址" name="memberInfo.address" id="address" value="${ memberInfo.address}"  class="textfield" />
  		</div>
  		<div class="dataDiv">
  			<div class="button" id="subButton" onclick="ajaxSubmit('${ctx}/memberWechat/saveMemeber')"><a href="javascript:void(-1)">完善资料</a></div>
  		</div>
  	</form>
  </div>
  
<script type="text/javascript">
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
</script>
</body>
</html>
