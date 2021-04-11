<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>


<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}

.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
</style>
<body>
	<h1>Upload with Ajax</h1>

<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>

	<div class='uploadResult' id='uploadResult'>
		<ul>

		</ul>
	</div>


	<button id='uploadBtn'>Upload</button>


<!-- 제이쿼리 cdn -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js" 
integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>

<script>
function showImage(fileCallPath){
	  
	  //alert(fileCallPath);
	
	  $(".bigPictureWrapper").css("display","flex").show();
	  
	  $(".bigPicture")
	  .html("<img src='/display?fileName="+ encodeURI(fileCallPath)+"'>")
	  .animate({width:'100%', height: '100%'}, 1000);

	}
	
	$(".bigPictureWrapper").on("click", function(e){
	  $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
/* 	  setTimeout(() => {
	    $(this).hide();
	  }, 1000); */
	  
	  setTimeout(function() {
		  $(".bigPicture").hide();
	  }, 1000);
	  
	});

	//파일 확장자가 exe, sh, zip 일 경우 업로드 제한
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880 //파일 크기가 5MB 이상일 경우 제한

	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	
	//파일 업로드시 목록에 파일명 보여주기
	var uploadResult = $(".uploadResult ul");

	function showUploadedFile(uploadResultArr){
		 
		   var str = "";
		   
		   $(uploadResultArr).each(function(i, obj){
		     
		     if(!obj.image){
		       
		       var fileCallPath =  encodeURIComponent(obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
		       
		       var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
		       
		       str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
		           "<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
		           "<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+
		           "<div></li>"
		           
		     }else{
		       
		       var fileCallPath =  encodeURIComponent(obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
		       
		       var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
		       
		       originPath = originPath.replace(new RegExp(/\\/g),"/");
		       
		       str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
		              "<img src='display?fileName="+fileCallPath+"'></a>"+
		              "<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span>"+
		              "<li>";
		     }
		   });
		   
		   uploadResult.append(str);
		 }
	
	
	//업로드 후 업로드 부분 초기화
	//input type=file이 있는 div를 복사하여 업로드한 후 붙여넣기 한다음 초기화 시켜줌
	var cloneObj = $(".uploadDiv").clone();
		
		
	//upload버튼 누르면 업로드
	$("#uploadBtn").on("click", function(e){
		console.log("파일업로드");
		
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		
		// formData에 첨부파일 데이터를 추가한뒤 formData 자체를 전송
		for(var i=0; i < files.length; i++) {
			//파일이름과 사이즈 체크하여 false반환
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url:'/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result) {
				//alert("Uploaded");
				console.log(result);
				
				showUploadedFile(result); //파일명 목록 보이기
				
				$(".uploadDiv").html(cloneObj.html()); //업로드후 초기화
			}
		}) //$.ajax end
		
	})
	
	//첨부파일 삭제
	$(".uploadResult").on("click","span", function(e){
	   
	  var targetFile = $(this).data("file");
	  var type = $(this).data("type");
	  console.log(targetFile);
	  
	  $.ajax({
	    url: '/deleteFile',
	    data: {fileName: targetFile, type:type},
	    dataType:'text',
	    type: 'POST',
	      success: function(result){
	         alert(result);
	       }
	  }); //$.ajax
	  
	});
</script>
</body>
</html>