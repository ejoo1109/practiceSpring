<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
    
<%@include file="../includes/header.jsp" %>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Board List Page
                            <button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                <!-- 게시판 리스트 반복문 -->
						<c:forEach items="${list}" var="board">
						<tr>
						<td><c:out value="${board.bno}"/></td>
						<!-- 게시글 조회시 가지고 가는 번호 -->
						<td><a class="move" href="<c:out value='${board.bno}'/>">
						<c:out value="${board.title}"/>
						<b>[  <c:out value="${board.replyCnt}" /> ]</b>
						</a>
						</td>
						<td><c:out value="${board.writer}"/></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
						</tr>
						</c:forEach>
                            </table>
                            
               <!-- 검색조건 처리 -->
				<div class="row">
					<div class="col-lg-12">

						<form id="searchForm" action="/board/list" method="get">
							<select name="type">
								<option value=""
								${pageMaker.cri.type == null?'selected':''}>---</option>
								<option value="T"
								${pageMaker.cri.type == 'T'?'selected':''}>제목</option>
								<option value="C"
								${pageMaker.cri.type == 'C'?'selected':''}>내용</option>
								<option value="W"
								${pageMaker.cri.type == 'W'?'selected':''}>작성자</option>
								<option value="TC"
								${pageMaker.cri.type == 'TC'?'selected':''}>제목 or 내용</option>
								<option value="TW"
								${pageMaker.cri.type == 'TW'?'selected':''}>제목 or 작성자</option>
								<option value="TWC"
								${pageMaker.cri.type == 'TWC'?'selected':''}>제목 or 내용 or 작성자</option>
							</select> 
							<input type="text" name="keyword" 	value="${pageMaker.cri.keyword}"/> 
							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" /> 
							<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
							<button class="btn btn-default">Search</button>
						</form>
					</div>
				</div>

				<!-- start 페이지 나누기 -->
                            <div class="text-center">
                            	<ul class="pagination">
                            		<c:if test="${pageMaker.prev}">
                            			<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">이전</a></li>
                            		</c:if>
                            		
                            		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            			<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':''}"><a href="${num}">${num}</a></li> 
                              			
                            		</c:forEach>
                            		
                            		<c:if test="${pageMaker.next}">
                            			<li class="paginate_button next"><a href="${pageMaker.endPage +1}">다음</a></li>
                            		</c:if>
                            	</ul>
                            </div>
                            <!-- end 페이지나누기 -->                               
                            
                            
                              <!-- 모달창 -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                            처리가 완료되었습니다.
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>   <!-- /.modal-content -->
                                </div>  <!-- /.modal-dialog -->
                            </div>   <!-- /.모달끝 -->
                        </div>   <!-- /.panel-body -->
                    </div>   <!-- /.panel -->
                </div>      <!-- /.col-lg-12 -->
            </div>       <!-- /.row -->
<!-- 페이지 링크 값을 넘기기 위한 폼 :
주소줄에 가지고 다녀야하는 값이 여러개여서 폼을 하나짜서 움직임. 
value값 잘 넘어왔는지 확인하려면 F12 source에서 확인 -->
<form id="actionForm" action="/board/list" method='get'>
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
	<input type="hidden" name="type" value="<c:out value="${ pageMaker.cri.type }"/>"> 
	<input type="hidden" name="keyword"	value="<c:out value="${ pageMaker.cri.keyword }"/>">
</form> 
<script>
$(document).ready(function(){
	//컨트롤러 register에서 글 등록 성공시 글번호를 result 에 담아서 보내준다.
	var result = '<c:out value="${result}"/>' 
	
	checkModal(result); // 게시글 번호를 담아 checkModal 함수호출
	history.replaceState({}, null, null); //모달창 등록후 뒤로가기 눌렀을때 모달창 안띄우게 하는방법
	
	//모달창 띄우기
	function checkModal(result) {
		
		if (result === '' || history.state){
			return;
		}
		
		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}
		
		$("#myModal").modal("show");
	}
	
	//글 작성 페이지 이동
	$("#regBtn").on("click", function(){
		self.location = "/board/register";
	})
	
	//페이지 번호를 클릭시 이동
 	var actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click", function(e){
	
		e.preventDefault(); //이벤트막기
		
		var targetPage = $(this).attr("href");
		
		console.log(targetPage)//클릭한 페이지 번호 보여주기
		
		actionForm.find("input[name='pageNum']").val(targetPage); //pageNum 값은 href값으로 변경
		actionForm.submit();
	}) 
	
	//게시물 조회 클릭시 기존 a 태그의 /board/get?bno=bno 을 hidden 으로 전송
	$(".move").on("click", function(e){
		e.preventDefault(); //이벤트막기
		//actionForm에 input 추가하여 경로이동
		//결과값:http://localhost:8080/board/get?pageNum=1&amount=15&bno=776
		actionForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href")+"'>");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
		
	})
	
	//검색버튼의 이벤트처리
	//문제점1. 3페이지에 있다가 검색을 하면 3페이지로 이동
	//문제점2. 검색 후 페이지 이동시 검색조건이 사라짐
	//문제점3. 검색 후 화면에 어떤 조건.키워드를 이용했는지 알 수 없음
	
	//해결1. 검색은 1페이지로 이동하고 검색조건과 키워드를 보이게 처리
	
 	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){
		e.preventDefault();
		console.log("..............click");
		
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}

		searchForm.find("input[name='pageNum']").val(1);
		
		
		searchForm.submit();
	})  
})
</script>
<%@include file="../includes/footer.jsp" %>