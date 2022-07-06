<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="resources/css/hotel.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실관리</title>
</head>
<body>
    <table>
        <tr>
        <td class="title">
        	객실관리
            <a href="/hotel">
            예약관리
            </a>
        </td>      
    </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td class="title">
                            <label>객실목록</label>
                        </td>
                    </tr> 
                    <tr>
                        <td>
                            <select style="width: 300px;" size="25" id="roomList">

                            </select>
                        </td>
                    </tr>
                </table>                
            </td>
            <td>
                <table style="height: 800;">
                    <tr>
                        <td class="title">
                            객실명
                        </td>
                        <td>
                            <input type="text" id="room_name">
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                            객실종류
                        </td>
                        <td>
                            <select name="roomType2" id="room_type">
                                <option value=1>SuiteRoom</option>
                                <option value=2>DeluxeRoom</option>
                                <option value=3>FamilyRoom</option>
                                <option value=4>TwinRoom</option>
                                <option value=5>SingleRoom</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="title" >
                            숙박가능인원
                        </td>
                        <td>
                            <input type="number" id="avail_people">명
                        </td>
                    </tr>
                    <tr>
                        <td class="title" >
                            1박요금
                        </td>
                        <td>
                            <input type="number" id="price">원
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:center;">
                            <button id="btn_ok" class="btn btn-primary">등록</button>&nbsp;&nbsp;
                            <button id="btn_delete" class="btn btn-danger" >삭제</button>&nbsp;&nbsp;
                            <button id="btn_clear" class="btn btn-warning" >비우기</button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<script>
$(document)
.ready(function(){
	loadList();
})
.on('click','#btn_ok',function(){
if($('#roomList option:selected').prop('selected')==true){
	$.ajax({
		type:'get',
		url:'updateRoom',
		data:{room_number:$('#roomList option:selected').val(),room_name:$('#room_name').val(),room_type:$('#room_type option:selected').val(),avail_people:$('#avail_people').val(),price:$('#price').val()},
		dataType:'json',
		success:function(data){
			loadList();
			$('#btn_clear').trigger('click');
		}
	})
}
else{
	$.ajax({
		type:'get',
		url:'insertRoom',
		data:{room_name:$('#room_name').val(),room_type:$('#room_type option:selected').val(),avail_people:$('#avail_people').val(),price:$('#price').val()},
		dataType:'json',
		success:function(data){
			loadList();
			$('#btn_clear').trigger('click');
		}
	})
}
})
.on('click','#btn_clear',function(){
	$('#roomList option:selected').prop('selected',false);
	$('#room_name,#room_type,#avail_people,#price').val('');
})
.on('click', '#roomList',function(){
	ar=$('#roomList option:selected').text().split(' ');
	$('#room_name').val(ar[0]);
	for(i=0;i<$('#room_type option').length;i++){
		if(ar[1]==$('#room_type option:eq('+i+')').text()){
			$('#room_type option:eq('+i+')').prop('selected',true);
		}
	}
	$('#avail_people').val(parseInt(ar[2]));
	$('#price').val(parseInt(ar[3]));
	console.log(ar);	
})
.on('click','#btn_delete',function(){
	let room_number=$('#roomList option:selected').val();
	$.ajax({
		type:'get',
		url:'deleteRoom',
		data:'room_number='+room_number,
		dataType:'text',
		success:function(data){
			loadList();
			$('#btn_clear').trigger('click');
		}
	})
})
function loadList(){
	$.ajax({
		type:'get',
		url:'roomList',
		data:'',
		dataType:'text',
		success:function(data){
			$('#roomList').empty().append(data);
		}
	})
}
</script>
</html>