<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">Board Read</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Board Read</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
      
      <form role="form" action="/board/modify" method="post">
      <!-- 삭제, 리스트 페이지로 넘어갈때 넘겨줄 페이지번호, 페이지 갯수 -->
<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
<input type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'>
      
          <div class="form-group">
            <label>Bno</label> <input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
          </div>
          <div class="form-group">
            <label>Title</label> <input class="form-control" name='title' value='<c:out value="${board.title}"/>'>
          </div>

          <div class="form-group">
            <label>Text area</label>
            <textarea class="form-control" rows="3" name='content' ><c:out value="${board.content}"/></textarea>
          </div>

          <div class="form-group">
            <label>Writer</label> <input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
          </div>
          
          <button type="submit" data-oper="modify" class="btn btn-default" >Modify</button>
          <button type="submit" data-oper="remove" class="btn btn-info" >Remove</button>
          <button type="submit" data-oper="list" class="btn btn-info" >List</button>

</form>
      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->

<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form");
	
	$('button').on("click", function(e){
		
		e.preventDefault(); // submit 기능 막기
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		//remove 버튼을 누르면 remove 페이지로 이동
		if(operation === 'remove') { 
			formObj.attr("action", "/board/remove");
			
		//list 버튼을 누르면 list페이지로 이동
		}else if(operation === 'list'){ 
			formObj.attr("action", "/board/list").attr("method", "get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			
			//폼태그의 모든 내용 삭제후 pageNum, amount를 담아 get방식으로 이동
			formObj.empty(); 
			formObj.append(pageNumTag);
			formObj.append(amountTag);
		}
		formObj.submit();
	})
})
</script>
<%@include file="../includes/footer.jsp"%>
