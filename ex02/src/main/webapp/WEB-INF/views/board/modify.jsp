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
		
		if(operation === 'remove') { //remove 버튼을 누르면 remove 페이지로 이동
			formObj.attr("action", "/board/remove");
		}else if(operation === 'list'){ //list 버튼을 누르면 list페이지로 이동
			formObj.attr("action", "/board/list").attr("method", "get");
			formObj.empty(); // 폼태그의 모든 내용 삭제후 get방식으로 이동
		}
		formObj.submit();
	})
})
</script>
<%@include file="../includes/footer.jsp"%>
