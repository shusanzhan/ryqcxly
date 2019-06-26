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
<title>定金结算客户</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车款结算客户</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<%-- <div class="operate">
		 <a class="but button" href="${ctx}/settlementReceipts/queryCustList">添加定金客户</a> 
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div> --%>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/settlementReceipts/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>销售人员：</label></td>
  				<td><input type="text" id="salesman" name="salesman" class="text small" value="${param.salesman}"></input></td>
  				<td><label>客户类型：</label></td>
  				<td>
  					<select class="text small" id="custType" name="custType"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.custType==1?'selected="selected"':'' } >展厅（网销客户）</option>
						<option value="2" ${param.custType==2?'selected="selected"':'' } >二网客户</option>
					</select>
					<%-- <select class="text small" id="advanceTypeId" name="advanceTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="receivablesType" items="${receivablesType }">
							<option value="${receivablesType.dbid }" ${param.advanceTypeId==receivablesType.dbid?'selected="selected"':'' } >${receivablesType.name }</option>
						</c:forEach>
					</select> --%>
  				</td>
  				<td><label>销售员姓名：</label></td>
  				<td><input type="text" id="salesman" name="salesman" class="text small" value="${param.salesman}"></input></td>
  				<td><label>结算日期：</label></td>
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
			<!-- <td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td> -->
			<td class="span2">客户姓名</td>
			<td class="span2">客户电话</td>
			<td class="span2">客户类型</td>
			<td class="span2">收款项目</td>
			<td class="span2">结算方式</td>
			<td class="span2">合同总金额</td>
			<td class="span2">本笔总额</td>
			<td class="span2">车款状态</td>
			<td class="span3">结算操作日期</td>
			<td class="span2">结算操作人</td>
			<td class="span2">销售人员</td>
			<td class="span2">备注</td>
			<td class= "span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="settlementReceipts" items="${page.result }">
		<tr height="32" align="center">
			<%-- <td><input type='checkbox' name="id" id="id1" value="${settlementReceipts.dbid }"/></td> --%>
			<td style="text-align:lcenter;">
				${settlementReceipts.custName }
			</td>
			<td style="text-align:lcenter;">
				${settlementReceipts.custTel }
			</td>
		<%-- 	<td style="text-align:center;">
				<c:if test = "${empty settlementReceipts.licenseNumber}">
					无
				</c:if>
				<c:if test = "${!empty settlementReceipts.licenseNumber}">
					${settlementReceipts.licenseNumber }
				</c:if>
			</td> --%>
			<td style="text-align:center;">
				<c:if test ="${settlementReceipts.custType==1}">
					展厅（网销客户）
				</c:if>
				<c:if test = "${settlementReceipts.custType==2}">
				  二网客户
				</c:if>
			</td>
			<td style="text-align:center;">
				${settlementReceipts.receivableProject }
			</td>
			<td style="text-align:lcenter;">
				${settlementReceipts.settlementType }
			</td>
			
			<td style="text-align:lcenter;">
				<c:if test = "${empty settlementReceipts.totalcontractAmount}">
					0.0
				</c:if>
				<c:if test = "${!empty settlementReceipts.totalcontractAmount}">
					${settlementReceipts.totalcontractAmount }
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test = "${empty settlementReceipts.totalMoney}">
					0.0
				</c:if>
				<c:if test = "${!empty settlementReceipts.totalMoney}">
					${settlementReceipts.totalMoney }
				</c:if>
			</td>
			<td style="text-align:center;">
				${settlementReceipts.settlementState }
			</td>
			<td style="text-align:center;">
				${settlementReceipts.settlementTime }
			</td>
			<td style="text-align:center;">
				${settlementReceipts.settlementPerson }
			</td>
			<td style="text-align:center;">
				${settlementReceipts.salesman }
			</td>
			<td style="text-align:center;">
				<c:if test = "${empty settlementReceipts.remarks}">
					无
				</c:if>
				<c:if test = "${!empty settlementReceipts.remarks}">
					${settlementReceipts.remarks }
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				<a  href="#" >收银</a>
			</td>
			<%-- <td style="text-align:left;">
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
			<td><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/pointRecord/add?memberId=${member.dbid }&directType=3','调整积分',900,500)">调整积分</a>
				<br>
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/storeMoneyRecord/add?dbid=${member.dbid }&directType=3','会员储值',1024,520)">储值</a>|
				<a href="javascript:void(-1)" class="aedit"	onclick="$.utile.deleteById('${ctx }/member/delete?dbids=${member.dbid}&type=1')">删除</a> --%>
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
			window.location.href='${ctx}/settlementReceipts/exportExcel?'+params;
		}
</script>
</html>