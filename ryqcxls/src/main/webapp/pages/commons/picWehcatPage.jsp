<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
	.pager-nav{
		color: #fb6969
	}
</style>
<c:if test="${not empty page && not empty page.result}">
	<div class="pager">
        <div class="pager-left">
            <div class="pager-first"><a class="pager-nav" onclick="cwSearchPagingOrder(1,'${page.pageSize}');">首页</a></div>
             <c:choose>
			    <c:when test="${page.currentPageNo==1}">
		            <div class="pager-pre"><a class="pager-nav" style="color: #CCC">上一页</a></div>
			    </c:when>
			    <c:otherwise>
		            <div class="pager-pre"><a class="pager-nav" onclick="cwSearchPagingOrder(${page.currentPageNo-1},'${page.pageSize}');">上一页</a></div>
			    </c:otherwise>
		    </c:choose>
        </div>
        <div class="pager-cen">
        	${page.currentPageNo}/${page.totalPageCount }
        </div>
        <div class="pager-right">
        	<c:choose>
		     	<c:when test="${page.currentPageNo==page.totalPageCount}">
	            	<div class="pager-next"><a class="pager-nav" style="color: #CCC">下一页</a></div>
		     	</c:when>
			    <c:otherwise>
	            	<div class="pager-next"><a class="pager-nav" onclick="cwSearchPagingOrder(${page.currentPageNo+1},'${page.pageSize}');">下一页</a></div>
			    </c:otherwise>
		    </c:choose>
            <div class="pager-end"><a class="pager-nav" onclick="cwSearchPagingOrder(${page.totalPageCount},'${page.pageSize}');">尾页</a></div>
        </div>
    </div>
</c:if>
<script type="text/javascript">
function getValue(){
	var curPage=$("#curPage").val();
	return curPage;
}
function cwSearchPagingOrder(curPage,pageSize){
	var qForm=$("#pageForm");
    if(typeof(qForm)=="undefined") return;
    if(typeof(curPage)!="undefined" && curPage!=null && curPage!=""){
      $("#page").val(curPage);
    }
    if(typeof(pageSize)!="undefined" && pageSize!=null && pageSize!=""){
      $("#limit").val(pageSize);
    }
    qForm.submit();
}
</script>