<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="taglib.jsp" %>
<style>
.pagination {
	font-size:12px;
	display:inline-block;
	margin-top: 12px;
	margin-bottom: 20px;
}
.pagination ul{
	border-radius: 4px;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    display: inline-block;
    margin-bottom: 0;
    margin-left: 0;
}
.pagination li{
	display:inline;
}
.pagination li a{
 	background:url(../images/pagebg.png) repeat-x;
	border:1px solid #c6ccd2;
	line-height:1.42857;
	float: left;
	margin-left:-1px;
	padding:6px 8px;
	position:relative;
	text-decoration:none;
	color:#000; 
}
.pagination li a:hover {
	color:#36F;
}
.pagination .active a{
	background:url(../images/pageactive_07.png) repeat-x;
	color:#fff;
}
.pagination .active a:hover{
	color:#fff;
}
.pagination .disabled a{
	border-color:#dddddd;
	color:#999999;
}
.pagination .disabled a:hover{
	color:#999999;
}
</style>
<c:if test="${not empty page && not empty page.result}">
	<div class="pagination">
	 <ul style="float: right;">
		<li>
			<a>
				跳转至<input type="text" onkeyup="this.value=this.value.replace(/\D/g,'');document.all.currentPage.value=this.value;" onafterpaste="this.value=this.value.replace(/\D/g,'');"  maxlength="5" name="curPage" id="curPage"  value="${page.currentPageNo }" size="3" 
				style="width:30px;margin-bottom: 0;padding: 0;height: 12px;line-height: 12px;"/>页
			</a>
		</li>
		<li>
	   	 	<a  href="javascript:void(-1)" onclick="cwSearchPagingOrder(getValue(),'${page.pageSize}');" > 确定</a>
	     </li>
	      
     </ul>
    <ul style="float: right;">
	    <li>
	    	<a href="javascript:void(-1)">
	     	总数${page.totalCount}  
		   </a>
	    </li>
	    <c:if test="${page.currentPageNo==1}" var="status">
	       <li class="disabled"><a href="javascript:void(-1)">上一页</a></li>
	    </c:if>
	    <c:if test="${status==false }">
	        <li><a href="javascript:void(-1)"  onClick="javascript:cwSearchPagingOrder(${page.currentPageNo-1},'${page.pageSize}');return false;">上一页</a></li>
		</c:if>
     <c:choose>
     	<c:when test="${page.currentPageNo==page.totalPageCount}">
        	 <li class="disabled"><a  href="javascript:void(-1)" >下一页</a></li>
     	</c:when>
	    <c:otherwise>
	       <li> <a href="javascript:void(-1)"  onClick="javascript:cwSearchPagingOrder(${page.currentPageNo+1},'${page.pageSize}');return false;">下一页</a></li>
	    </c:otherwise>
    </c:choose>
    </ul>
     <ul style="clear: both;"></ul>
    </div>
</c:if>
<script type="text/javascript">
function getValue(){
	var curPage=$("#curPage").val();
	return curPage;
}
function cwSearchPagingOrder(curPage,pageSize){
	var qForm=$("#searchPageForm");
    if(typeof(qForm)=="undefined") return;
    if(typeof(curPage)!="undefined" && curPage!=null && curPage!=""){
      $("#currentPage").val(curPage);
    }
    if(typeof(pageSize)!="undefined" && pageSize!=null && pageSize!=""){
      $("#paramPageSize").val(pageSize);
    }
    qForm.submit();
}
</script>