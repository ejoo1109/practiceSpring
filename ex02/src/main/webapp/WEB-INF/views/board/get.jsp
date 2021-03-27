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
      
          <div class="form-group">
            <label>Bno</label> <input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
          </div>
          <div class="form-group">
            <label>Title</label> <input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly="readonly">
          </div>

          <div class="form-group">
            <label>Text area</label>
            <textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${board.content}"/></textarea>
          </div>

          <div class="form-group">
            <label>Writer</label> <input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
          </div>
          
          <button data-oper="modify" class="btn btn-default" >Modify</button>
          <button data-oper="list" class="btn btn-info" >List</button>

<!-- 수정 페이지로 넘어갈때 가지고 다니는 번호 -->
				<form id='operForm' action="/board/modify" method="get">
					<input type="hidden" id='bno' name='bno'
						value='<c:out value="${board.bno}"/>'>
				</form>

			</div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
<script>
$(document).ready(function(){
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		//수정버튼 누르면 수정페이지로 이동
		operForm.attr("action","/board/modify").submit();
	})
	
	$("button[data-oper='list']").on("click", function(e){
		//list로 돌아갈 경우 담고 있는 bno 삭제후 이동
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();
	})
})

</script>
<%@include file="../includes/footer.jsp"%>
