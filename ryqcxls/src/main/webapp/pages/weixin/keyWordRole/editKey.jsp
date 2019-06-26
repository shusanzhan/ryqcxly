<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack4.js"></script>
<title>参数二维码设置关键词</title>
</head>
<body >
	<br>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="weixinKeyWordRoleId" id="weixinKeyWordRoleId" value="${param.weixinKeyWordRoleId }">
		<input type="hidden" name="weixinKeyWord.dbid" id="dbid" value="${weixinKeyWord.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" style="width: 60px;">关键词:&nbsp;</td>
				<td ><input type="text" name="weixinKeyWord.keyword" id="keyword"
					value="${weixinKeyWord.keyword }" class="media text" title="关键词"	checkType="string,2,12" tip="长度在2到12个字符之间"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				
				<td class="formTableTdLeft" style="width: 60px;">规则:&nbsp;</td>
				<td >
					<c:if test="${empty(weixinKeyWord) }">
						<label><input type="radio" value="1" id="matchingType" name="weixinKeyWord.matchingType" checked="checked">全匹配</label> 
						<label><input type="radio" value="2" id="matchingType2" name="weixinKeyWord.matchingType" >模糊匹配</label> 
					</c:if>
					<c:if test="${!empty(weixinKeyWord) }">
						<label><input type="radio" value="1" id="matchingType" name="weixinKeyWord.matchingType" ${weixinKeyWord.matchingType==1?'checked="checked"':'' } >全匹配</label> 
						<label><input type="radio" value="2" id="matchingType2" name="weixinKeyWord.matchingType" ${weixinKeyWord.matchingType==2?'checked="checked"':'' } >模糊匹配</label> 
					</c:if>
					<span style="color: red;">*</span>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>