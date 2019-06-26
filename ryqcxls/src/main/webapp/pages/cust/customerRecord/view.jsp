<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>线索添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/jqueryui/themes/base/jquery-ui.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/customerRecord/queryList'">线索管理</a>-
	<a href="javascript:void(-1)" class="current">
		来店登记
	</a>
</div>
<div id="frmContent" class="frmContent">
   <form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
   		 <div class="frmTitle" onclick="showOrHiden('contactTable')">基本信息
   		 	 <a href="javascript:void(-1)"	onclick="goBack()" class="aedit">返回</a>
   		 </div>
		 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
		 	<tr>
				<td><label>创建时间：</label></td>
  				<td>
  					<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/> 
				</td>
				<td class="formTableTdLeft">类型：</td>
				<td>
					${customerRecord.customerType.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">进店时间：</td>
				<td>
					${customerRecord.comeInTime}
				</td>
				<td class="formTableTdLeft">来店目的：</td>
				<td>
					${customerRecord.customerRecordTarget.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">
					客户随行人数：
				</td>
				<td>
					${customerRecord.customerNum}人
				</td>
				<td class="formTableTdLeft">客户是否有效：</td>
				<td>
					<c:if test="${customerRecord.status==2 }">
						<span style="color: red;">无效</span>
					</c:if>
					<c:if test="${customerRecord.status==1 }">
						<span style="color: green;">有效</span>
					</c:if>
				</td>
			</tr>
			<c:if test="${customerRecord.status==1 }">
				<tr>
						<td><label>来店次数：</label></td>
		  				<td>
		  					<c:if test="${customerRecord.comeinNum==1 }">
		  						初次来店
		  					</c:if>
		  					<c:if test="${customerRecord.comeinNum==2 }">
		  						二次来店
		  					</c:if>
						</td>
						 <td><label>到店客户类型：</label></td>
		  				<td>
		  					<c:if test="${customerRecord.comeInType==1 }">
		  						展厅到店
		  					</c:if>
		  					<c:if test="${customerRecord.comeInType==2 }">
		  						网销邀约到店
		  					</c:if>
						</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">客户姓名：</td>
					<td>
						${customerRecord.name }（${customerRecord.sex}）
					</td>
					<td class="formTableTdLeft">常用手机号：</td>
					<td>
						${customerRecord.mobilePhone }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">销售顾问：</td>
					<td  >
						${customerRecord.saler.realName }
					</td>
					<td class="formTableTdLeft">信息来源：</td>
					<td >
						${customerRecord.customerInfrom.name }
					</td>
				</tr>
			</c:if>
			<tr>
				<td class="formTableTdLeft">备注：</td>
				<td  colspan="1">
					${customerRecord.note }
				</td>
			</tr>
			
		</table>
		<c:if test="${customerRecord.status==1 }">
			<div class="frmTitle" onclick="showOrHiden('contactTable')">处理结果</div>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			 	<tr>
					<td class="formTableTdLeft">超时状态：</td>
					<td  >
						<c:if test="${customerRecord.overtimeStatus==1}">
							<span style="color: green;">未超时</span>
						</c:if>
						<c:if test="${customerRecord.overtimeStatus==2}">
							<span style="color: red;">已超时</span>
						</c:if>
					</td>
				</tr>
			 	<tr>
					<td><label>销售顾问：</label></td>
	  				<td>
	  					${customerRecord.saler.realName}
					</td>
					<td><label>部门：</label></td>
	  				<td>
	  					${customerRecord.saler.department.name}
					</td>
				</tr>
			 	<tr>
					<td><label>处理时间：</label></td>
	  				<td>
	  					<fmt:formatDate value="${customerRecord.resultDate }" pattern="yyyy-MM-dd HH:mm"/> 
					</td>
					 <td class="formTableTdLeft">处理状态：</td>
					<td>
						<c:if test="${customerRecord.resultStatus==2 }">
						<span style="color: green;">转为登记</span>
					</c:if>
					<c:if test="${customerRecord.resultStatus==1 }">
						<span style="color: pink;">等待...</span>
					</c:if>
					<c:if test="${customerRecord.resultStatus==4 }">
						<span style="color: red;">无效</span>
					</c:if>
					<c:if test="${customerRecord.resultStatus==3 }">
						<span style="color: green;">已回访车辆</span>
					</c:if>
					</td>
				</tr>
				<tr>
					<c:if test="${customerRecord.resultStatus==4 }">
						<td><label>无效原因：</label></td>
		  				<td>
		  					${customerRecord.customerRecordClubInvalidReason.name }
						</td>
					</c:if>
					<td class="formTableTdLeft">
						备注：
					</td>
					<td>
						${customerRecord.invalidNote}
					</td>
				</tr>
			</table>
	</c:if>
</form>                            
</div>
<!-- Modal -->

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>
