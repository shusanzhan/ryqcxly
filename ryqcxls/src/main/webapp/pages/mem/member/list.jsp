<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>会员管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">会员管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/member/add'">添加</a> --%>
		<c:if test="${sessionScope.user.userId=='admin' }">
			<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/member/duplicateData'">重复数据</a>
		</c:if>
		<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/member/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/member/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>会员认证：</label></td>
  				<td>
  					<select class="text small" id="memAuthStatus" name="memAuthStatus"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.memAuthStatus==1?'selected="selected"':'' } >未认证</option>
						<option value="2" ${param.memAuthStatus==2?'selected="selected"':'' } >已认证</option>
					</select>
  				</td>
  				<td><label>车主认证：</label></td>
  				<td>
  					<select class="text small" id="carMasterStatus" name="carMasterStatus"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.carMasterStatus==1?'selected="selected"':'' } >未认证</option>
						<option value="2" ${param.carMasterStatus==2?'selected="selected"':'' } >已认证</option>
					</select>
  				</td>
  				<td><label>经纪人权限：</label></td>
  				<td>
  					<select class="text small" id="agentStatus" name="agentStatus"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.agentStatus==1?'selected="selected"':'' } >未开启</option>
						<option value="2" ${param.agentStatus==2?'selected="selected"':'' } >已开启</option>
					</select>
  				</td>
  				<td><label>会员级别：</label></td>
  				<td>
  					<select class="text small" id="memberShipLevelId" name="memberShipLevelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="memberShipLevel" items="${memberShipLevels }">
							<option value="${memberShipLevel.dbid }" ${param.memberShipLevelId==memberShipLevel.dbid?'selected="selected"':'' } >${memberShipLevel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车牌：</label></td>
  				<td><input type="text" id="carNo" name="carNo" class="text small" value="${param.carNo}"></input></td>
  				<td><label>车型：</label></td>
  				<td><input type="text" id="car" name="car" class="text small" value="${param.car}"></input></td>
  			</tr>
  			<tr>
  				<td><label>车架号：</label></td>
  				<td><input type="text" id="vinNo" name="vinNo" class="text small" value="${param.vinNo}"></input></td>
  				<td><label>昵称：</label></td>
  				<td><input type="text" id="nickName" name="nickName" class="text small" value="${param.nickName}"></input></td>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
  				<td><label>注册日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span3">姓名</td>
			<td class="span2">微信</td>
			<td class="span2">级别</td>
			<td class="span2">车主概况</td>
			<td class="span2">当前积分</td>
			<td class="span2">优惠券(张)</td>
			<td class="span2">预约次数</td>
			<td class="span1">余额</td>
			<td class="span1">推荐人</td>
			<td class="span1">会员认证</td>
			<td class="span1">经纪人权限</td>
			<td class="span1">经纪人类型</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="member" items="${page.result }">
		<c:set value="${member.weixinGzuserinfo }" var="weixinGzuserinfo"></c:set>
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${member.dbid }"/></td>
			<td>
				<img alt="" src="${weixinGzuserinfo.headimgurl }" height="50" width="50" style="float: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)" style="float: left;">
					${member.name }（${member.sex }）
					<br>
					${member.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li><a href="javascript:void(-1)" onclick="window.location.href='${ctx}/member/information?dbid=${member.dbid}&type=1'" >会员明细</a></li>
					      <li><a href="javascript:void(-1)" class="aedit"	onclick="window.location.href='${ctx }/member/edit?dbid=${member.dbid}'">编辑</a></li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/memberTrack/add?memberId=${member.dbid }','添加跟进记录',900,500)">添加跟进记录</a> </li>
					      <c:if test="${member.memType==1 }">
					     	 <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/member/updateMemberType?memberId=${member.dbid}','searchPageForm','您确定【${member.name}】取消员工标记吗')" >取消员工标记</a> </li>
					      </c:if>
					      <c:if test="${member.memType==0 }">
					      	<li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/member/updateMemberType?memberId=${member.dbid}','searchPageForm','您确定【${member.name}】标记为员工吗')" >标记为员工</a> </li>
					      </c:if>
					     <%--  <c:if test="${member.carMasterStatus==2 }">
					     	 <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='/customer/customerFile?dbid=${member.customer.dbid}&type=1'">客户档案</a> </li>
					      </c:if> --%>
					    </ul>
					  </div>
				</div>
			</td>
			<td style="text-align:left;">
				${weixinGzuserinfo.nickname }
				<c:if test="${weixinGzuserinfo.eventStatus==1 }">
					<span style="color: green">关注</span>
				</c:if>
				<c:if test="${weixinGzuserinfo.eventStatus==2 }">
					<span style="color: red;">取消</span>
				</c:if>
				<c:if test="${member.memType==1 }">
					<span style="color: red;">员工</span>
				</c:if>
				<br>
				<fmt:formatDate value="${member.createTime }" pattern="yyyy-MM-dd hh:mm"/>
			</td>
			<td>${member.memberShipLevel.name }</td>
			<td style="text-align: left;">
				<c:if test="${member.carMasterStatus==1||empty(member.memAuthStatus) }">
					<span style="color: red;">未认证</span>|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/member/authMember?memberId=${member.dbid }','会员认证',900,500)">认证</a>
				</c:if>
				<c:if test="${member.carMasterStatus==2 }">
					<span style="color: green">已认证</span>
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/member/authMember?memberId=${member.dbid }','会员认证',900,500)">认证</a>|
					<fmt:formatDate value="${member.carMasterDate }" pattern="yyyy-MM-dd"/>
				</c:if><br>
				<c:if test="${!empty(member.car) }">
					${member.car }<br>
				</c:if>
				<c:if test="${!empty(member.vinNo) }">
					VIN:${member.vinNo }
				</c:if>
				<c:if test="${!empty(member.carNo) }">
					NO:${member.carNo }
				</c:if>
			</td>
			<td>
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/member/information?dbid=${member.dbid}&type=4'" >${member.totalPoint }</a>
			</td>
			<td>
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/member/information?dbid=${member.dbid}&type=3'" >
					<ystech:couponMemberCountTag memberId="${member.dbid }"/>
				</a>
			</td>
			<td>
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/member/information?dbid=${member.dbid}&type=5'" >
					<c:if test="${empty(member.onlineBookingNum) }">
						0
					</c:if>
					<c:if test="${!empty(member.onlineBookingNum) }">
						${member.onlineBookingNum }
					</c:if>
				</a>
			</td>
			<td>
				<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/member/information?dbid=${member.dbid}&type=2'" >
					<ystech:urlEncrypt enCode="${member.balance}"/> 
				</a>
			</td>
			<td>
				<c:if test="${empty(member.parent) }">
					无推荐人
				</c:if>
				<c:if test="${!empty(member.parent)}">
					${member.parent.name }
				</c:if>
			</td>
			<td>
				<c:if test="${member.memAuthStatus==1||empty(member.memAuthStatus) }">
					未认证
				</c:if>
				<c:if test="${member.memAuthStatus==2 }">
					已认证
				</c:if>
			</td>
			<td>
				<c:if test="${member.agentStatus==1||empty(member.agentStatus) }">
					<span style="color: red;">未开启</span>|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/member/stopOrStartAgent?memberId=${member.dbid}','searchPageForm','您确定【${member.name}】开启推荐权限吗')" title="启用">启用</a>
				</c:if>
				<c:if test="${member.agentStatus==2 }">
					<span style="color: green">已开启</span>|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/member/stopOrStartAgent?memberId=${member.dbid}','searchPageForm','您确定【${member.name}】停用推荐权限吗')" title="停用">停用</a>
				</c:if>
				<br>
				层级:${member.level } 引流:${member.totalNum } 
			</td>
			<td>
				${member.spread.name }
			</td>
			<td><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/pointRecord/add?memberId=${member.dbid }&directType=3','调整积分',900,500)">调整积分</a>
				<br>
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/storeMoneyRecord/add?dbid=${member.dbid }&directType=3','会员储值',1024,520)">储值</a>|
				<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.deleteById('${ctx }/member/delete?dbids=${member.dbid}&type=1')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
	 function exportExcel(searchFrm){
			var params;
			if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
				params=$("#"+searchFrm).serialize();
			}
			window.location.href='${ctx}/member/exportExcel?'+params;
		}
</script>
</html>