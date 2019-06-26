<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>推荐客户</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">推荐客户</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butSave" href="javascript:void(-1);" onclick="window.location.href='${ctx }/recommendCustomer/exportExcel?type=1'">导出EXCEL</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/recommendCustomer/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				 <td>
                    省/市：
                </td>
                 <td>
                 	<select id="proviceId" name="proviceId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="area" items="${provices }">
							<option value="${area.dbid }" ${param.proviceId==area.dbid?'selected="selected"':'' } >${area.name }</option>
						</c:forEach>
					</select>
                </td>
				 <td>
                   城市：
                </td>
                 <td>
                 	<select id="cityId" name=cityId  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="area" items="${citys }">
							<option value="${area.dbid }" ${param.cityId==area.dbid?'selected="selected"':'' } >${area.name }</option>
						</c:forEach>
					</select>
                </td>
				 <td>
                    区域：
                </td>
                 <td>
                 	<select id="areaId" name="areaId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="area" items="${areas }">
							<option value="${area.dbid }" ${param.areaId==area.dbid?'selected="selected"':'' } >${area.name }</option>
						</c:forEach>
					</select>
                </td>
				 <td>
                    经销商状态
                </td>
                 <td>
                 	<select id="companyStatus" name="companyStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1"  ${param.companyStatus==1?'selected="selected"':''}>无</option>
						<option  value="2" ${param.companyStatus==2?'selected="selected"':''}>有</option>
					</select>
                </td>
              </tr>
			<tr>
				 <td>
                    分配状态：
                </td>
                 <td>
                 	<select id="distStatus" name="distStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1"  ${param.distStatus==1?'selected="selected"':''}>待分配</option>
						<option  value="2" ${param.distStatus==2?'selected="selected"':''}>已分配</option>
					</select>
                </td>
				 <td>
                    交易状态：
                </td>
                 <td>
                 	<select id="tradeStatus" name="tradeStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1"  ${param.tradeStatus==1?'selected="selected"':''}>交易中</option>
						<option  value="2" ${param.tradeStatus==2?'selected="selected"':''}>交易成功</option>
						<option  value="3" ${param.tradeStatus==3?'selected="selected"':''}>交易失败</option>
					</select>
                </td>
                <td>
                    经销商：
                </td>
                <td>
                    <input name="compnayName" type="text" id="compnayName" value="${param.compnayName }" class="text small"/>
                </td>
				 <td>
                    经纪人姓名：
                </td>
                <td>
                    <input name="agentName" type="text" id="agentName" value="${param.agentName }" class="text small"/>
                </td>
               </tr>
               <tr>
                <td>
                    客户姓名：
                </td>
                <td>
                    <input name="name" type="text" id="name" value="${param.name }"  class="text small"/>
                </td>
                <td>
                    客户电话：
                </td>
                <td>
                    <input name="mobilePhone" type="text" id="mobilePhone" value="${param.mobilePhone }"  class="text small"/>
                </td>
                 <td><label>推荐开始时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
			</tr>
		 </table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前无数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead class="TableHeader">
		<tr>
			<td class="sn">
					<input type="checkbox" name="title-table-checkbox" id="title-table-checkbox"  onclick="selectAll(this,'id')">
			</td>
			<td class="span2">名称</td>
			<td class="span2">联系电话</td>
			<td class="span3">省（直辖市）-市-区</td>
			<td class="span3">车型</td>
			<td class="span2">经纪人</td>
			<td class="span2">经纪人电话</td>
			<td class="span2">员工</td>
			<td class="span2">经销商</td>
			<td class="span2">推荐时间</td>
			<td class="span2">销售顾问分配状态</td>
			<td class="span2">交易状态</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="recommentCustomer">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${recommentCustomer.dbid }">
				</td>
				<td >
					<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${recommentCustomer.name }（${recommentCustomer.sex }）
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/recommendCustomer/customerFile?dbid=${recommentCustomer.dbid}&type=1'">客户档案</a></li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/recommendCustomer/customerFile?dbid=${recommentCustomer.dbid}&type=4'">操作日志</a> </li>
					    </ul>
					  </div>
					</div>
				</td>
				<td >${recommentCustomer.mobilePhone }</td>
				<td style="text-align: left;">
					${recommentCustomer.province }
					${recommentCustomer.city }
					${recommentCustomer.areaStr }
				</td>
				<td>
					${recommentCustomer.brand.name }
					${recommentCustomer.carSeriy.name }
					${recommentCustomer.carModel.name }
				</td>
				<td>${recommentCustomer.agentName }</td>
				<td>${recommentCustomer.agentPhone }</td>
				<td>
					<c:if test="${empty(recommentCustomer.member.user) }">
						无
					</c:if>
					<c:if test="${!empty(recommentCustomer.member.user) }">
						${recommentCustomer.member.user.realName }
					</c:if>
				</td>
				<td>
					<c:if test="${empty(recommentCustomer.company) }">
						<span style="color: red">未分配</span>
					</c:if>
					<c:if test="${!empty(recommentCustomer.company) }">
						${recommentCustomer.company.name }
					</c:if>
				</td>
				<td>${recommentCustomer.recommendDate }</td>
				<td>
					<c:if test="${recommentCustomer.distStatus==1}">
						<span style="color:#e50541;">待分配</span>
					</c:if>
					<c:if test="${recommentCustomer.distStatus==2}">
						<span style="color:green;">已分配</span>
					</c:if>
				</td>
				<td>
					<c:if test="${recommentCustomer.tradeStatus==1}">
						<span style="color:#e50541;">交易中</span>
					</c:if>
					<c:if test="${recommentCustomer.tradeStatus==2}">
						<span style="color: green;">交易成功</span>
					</c:if>
					<c:if test="${recommentCustomer.tradeStatus==3}">
						<span style="color: red;">交易失败</span>
					</c:if>
				</td>
				<td style="text-align: center;">
					<c:if test="${recommentCustomer.tradeStatus==1}">
						<a href="#" class="aedit" style="color: #2b7dbc" onclick="$.utile.openDialog('${ctx }/recommendCustomer/distriCompnay?dbid=${recommentCustomer.dbid}&currentPage=${page.currentPageNo}&pageSize=${page.pageSize }&type=2','分配客户',720,400)">再分配客户</a>
					</c:if>
					<c:if test="${recommentCustomer.tradeStatus==2}">
						<span style="color: green;">交易成功...</span>
					</c:if>
					<c:if test="${recommentCustomer.tradeStatus==3}">
						<span style="color: red;">交易失败...</span>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
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
	 
	 function sendMms(){
		window.location.href="${ctx}/sms/add";
	 }
</script>
</html>
