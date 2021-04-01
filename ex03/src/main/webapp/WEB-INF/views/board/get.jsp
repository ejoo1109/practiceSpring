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

<!-- 수정, 리스트 페이지로 넘어갈때 넘겨줄 폼 -->
<form id='operForm' action="/board/modify" method="get">
<input type="hidden" id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
<input type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'>
<input type="hidden" name="type" value="<c:out value="${cri.type }"/>"> 
<input type="hidden" name="keyword"	value="<c:out value="${cri.keyword }"/>">
</form>

			</div>
      <!--  end panel-body -->
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
<!-- 댓글 화면 처리 -->
<div class='row'>
	<div class="col-lg-12">
		<!-- /.panel -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New
					Reply</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<ul class="chat">
					<!-- 댓글 시작 -->
					<li class="left clearfix" data-rno="12">
						<div>
							<div class="header">
								<strong class="primary-front">user00</strong> <small
									class="pull-right text-muted">2021-04-01 17:13</small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
					<!-- 댓글 종료 -->
				</ul>
				<!-- ./ end ul -->
			</div>
			<!-- /.panel .chat-panel -->

		</div>
	</div>
	<!-- ./ end row -->
</div>
<!-- 댓글 Modal -->
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" name='reply' value='New Reply!!!!'>
              </div>      
              <div class="form-group">
                <label>Replyer</label> 
                <input class="form-control" name='replyer' value='replyer'>
              </div>
              <div class="form-group">
                <label>Reply Date</label> 
                <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
              </div>
      
            </div>
<div class="modal-footer">
        <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
        <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
      </div>          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.댓글 modal 종료 -->
<script src="/resources/js/reply.js"></script>
<script>

/* console.log("=============");
console.log("JS TEST");
 */
var bnoValue = '<c:out value="${board.bno}"/>';
var replyUL = $(".chat");

	showList(1);
	
	function showList(page) {
		
		replyService.getList({bno:bnoValue, page: page||1}, function(list){
			
		var str="";
		if(list == null || list.length ==0){
			replyUL.html("");
			
			return;
		}
		for (var i=0, len=list.length ||0; i<len; i++) {
			str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
			str +="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
			str +="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
			str +="<p>"+list[i].reply+"</p></div></li>";
		}
		
		replyUL.html(str);
	}); //end function
	
} //end showList

//댓글 작성 버튼시 모달창 띄우기 - 바깥쪽으로 빼두어 매번 jQuery를 호출하지 않게 한다.

var modal = $(".modal");
var modalInputReply = modal.find("input[name='reply']");
var modalInputReplyer = modal.find("input[name='replyer']");
var modalInputReplyDate = modal.find("input[name='replyDate']");

var modalModBtn = $("#modalModBtn");
var modalRemoveBtn = $("#modalRemoveBtn");
var modalRegisterBtn = $("#modalRegisterBtn");

$("#addReplyBtn").on("click", function(e){
	
	modal.find("input").val("");
	//사용자가 NewReply버튼을 클릭하면 입력에 필요없는 항목들은 안보이게 처리하고 모달창을 보이게 한다.
	modalInputReplyDate.closest("div").hide(); 
	modal.find("button[id !='modalCloseBtn']").hide();
	
	modalRegisterBtn.show();
	
	$(".modal").modal("show");
})

//모달창을 이용한 댓글 추가처리
modalRegisterBtn.on("click", function(e){
	var reply = {
			reply: modalInputReply.val(),
			replyer:modalInputReplyer.val(),
			bno:bnoValue
	}
	replyService.add(reply, function(result){
		alert(result);
		
		modal.find("input").val("");
		modal.modal("hide");
		
		showList(1); //댓글 등록후 목록갱신
	})
})
//댓글 클릭시 조회처리
$(".chat").on("click", "li", function(e){
	var rno = $(this).data("rno");
	//console.log(rno); //댓글 클릭시 콘솔확인
	replyService.get(rno, function(reply){
		modalInputReply.val(reply.reply);
		modalInputReplyer.val(reply.replyer);
		modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
		modal.data("rno", reply.rno);
		
		modal.find("button[id !='modalCloseBtn']").hide();
		modalModBtn.show();
		modalRemoveBtn.show();
		
		$(".modal").modal("show");
	})
})

//댓글 모달창의 수정처리 - Ajax로 처리하고 모달창 close , 최신댓글 목록 갱신
modalModBtn.on("click", function(e){
	var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};

	replyService.update(reply, function(result){
		alert(result);
		modal.modal("hide");
		showList(1);
	})

})

//댓글 모달창의 삭제처리 - Ajax로 처리하고 모달창 close , 최신댓글 목록 갱신
modalRemoveBtn.on("click", function(e){
	var rno = modal.data("rno");

	replyService.remove(rno, function(result){
		alert(result);
		modal.modal("hide");
		showList(1);
	})
})


/* //댓글 추가 테스트
 	replyService.add(
		{reply:"JS Test", replyer:"tester", bno:bnoValue},
		function(result){
			alert("RESULT: "+ result);
		}) 
//댓글 조회 테스트
	replyService.getList({bno:bnoValue, page:1}, function(list){
		
		for(var i=0, len=list.length||0; i<len; i++){
			console.log(list[i]);
		}
	});
	 
//댓글 삭제 테스트
	replyService.remove(17, function(count){
		console.log(count);
		
		if (count === "success"){
			alert("REMOVED");
		}
	}, function(err){
		alert("ERROR...");
	}) 

//댓글 수정 테스트
	replyService.update({rno:22, bno: bnoValue, reply:"Modified Reply..."}, 
			function(result) {
		alert("수정 완료...");
	})

//특정 댓글 조회
	replyService.get(10, function(data){
		console.log(data);
	}) */


</script>
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
