/**
 * js의 모듈 패턴
 * 여러 기능들을 모아서 하나의 모듈화
 * 클로저를 이용해서 상태 유지
 * 여러 함수들이 메서드화 되므로 객체지향 구조에 적합
 */

	console.log("Reply Module......");

//댓글 등록- Ajax로 ReplyController 호출하기
//http://localhost:8080/board/get?bno=772
	var replyService = (function() {
		
		function add(reply, callback, error){ //ajax처리후 동작해야 하는 함수
			console.log("add reply.........");
			$.ajax({
				type: 'post',
				url: '/replies/new',
				data: JSON.stringify(reply),
				contentType:"application/json; charset=utf-8",
				success: function(result, status, xhr) {
					if(callback) {callback(result);}
				},
				error: function(xhr, status, er){
					if (error) {error(er);}
				}
			})
		}


//댓글 조회 - getJSON()처리
// getList는 param(bno, page) 파라미터를 전달받아 
//json 목록을 호출 한 후 url 호출시 json확장자로 호출한다.
//http://localhost:8080/board/get?bno=772 -> 콘솔로그로 확인

function getList(param, callback, error) {
	
	var bno = param.bno;
	var page = param.page || 1;
	
	$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
		function(data) {
			if (callback) {
				callback(data);
			}
		}).fail(function(xhr, status, err){
		if(error){
			error();
		}
	});
}

//댓글 삭제
//전송 방식은 DELETE 방식 사용
function remove(rno, callback, error) {
	$.ajax({
		type: 'delete',
		url: '/replies/' + rno,
		success: function(deleteResult, status, xhr) {
			if(callback){
				callback(deleteResult);
			}
		},
		error : function(xhr, status, er) {
			if (error) {
				error(er);
			}
		}
	});
}
//댓글 수정
function update(reply, callback, error) {
	$.ajax({
		type: 'put',
		url : '/replies/' + reply.rno,
		data: JSON.stringify(reply),
		contentType:"application/json; charset=utf-8",
		success:function(result, status, xhr) {
			if(callback){
				callback(result);
			}
		},
		error : function(xhr, status, er){
			if(error){
				error(er);
			}
		}
	})
}
//특정댓글 조회
function get(rno, callback, error) {
	$.get("/replies/" + rno + ".json", function(result) {
		if(callback) {
			callback(result);
		}
	}).fail(function(xhr, status, err) {
		if (error) {
			error();
		}
	})
}

//날짜형식
function displayTime(timeValue){
	var today = new Date();
	
	var gap = today.getTime() - timeValue;
	
	var dateObj = new Date(timeValue);
	var str = "";
	
	if (gap < (1000*60*60*24)){
		
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();
		
		return [(hh>9 ? '': '0') + hh, ':', (mi>9 ? '': '0') + mi,
				 ':', (ss>9 ? '': '0') + ss].join('');
	}else{
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth()+1; //달은 0부터 시작되므로 +1
		var dd = dateObj.getDate();
		
		return [yy, '/', (mm>9 ? '':'0') + mm, '/',
				(dd>9 ? '':'0') + dd].join('');
	}
}
;
		/*모듈 패턴으로 외부에 노출하는 정보 */
	return {
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime
	};
})();