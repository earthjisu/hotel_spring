<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <link rel="stylesheet" href="resources/css/hotel.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약관리</title>
</head>
<body>
    <table>
    <tr>
        <td class="title">
        	예약관리
            <a href="room">
            객실관리
            </a>
        </td>      
    </tr>
        <tr>
            <td>
                 <table>
                    <tr>
                        <td class="title">
                            숙박기간 
                        </td>
                        <td>
                            <input type="date" id="checkin">~<input type="date" id="checkout">
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                            숙박인원
                        </td>
                        <td>
                        <input type="number" min="1" id="b_people">명
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                            객실종류
                        </td>
                        <td>
                            <select name="roomType" id="roomType">
                                <option value=1>SuiteRoom</option>
                                <option value=2>DeluxeRoom</option>
                                <option value=3>FamilyRoom</option>
                                <option value=4>TwinRoom</option>
                                <option value=5>SingleRoom</option>
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:center;">
                            <button id="btn_find" class="btn btn-success">찾기</button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><label class="title">예약가능객실</label></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <select style="width: 300px;" size="20" id="usableRoom">

                            </select>
                        </td>
                    </tr>
                </table>
            </td>


            <td>
                <table>
                     <tr>
                        <td class="title">
                             예약번호
                        </td>
                        <td>
                        <input type="number" id="b_number" readonly>
                        </td>
                    </tr>
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
                            숙박예정인원 
                        </td>
                        <td>
                            <input type="number" min="1" id="b_people2">명
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                            숙박기간 
                        </td>
                        <td>
                            <input type="date" id="b_checkin">~<input type="date" id="b_checkout">
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                            예약자 
                        </td>
                        <td>
                            <input type="text" id="b_person">
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                             모바일 
                        </td>
                        <td>
                            <input type="text" id="mobile">
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                            숙박총액 
                        </td>
                        <td>
                            <input type="number" id="t_price">원
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:center;">
                            <button id="btn_confirm" class="btn btn-primary">예약등록</button>&nbsp;&nbsp;
                            <button id="btn_cancel" class="btn btn-danger">예약취소</button>&nbsp;&nbsp;
                            <button id="btn_clear" class="btn btn-warning" >비우기</button>
                        </td>
                    </tr>
                </table>
            </td>
        
   
            <td>
                <table>
                    <tr>
                        <td class="title"><label>예약내역</label></td>
                    </tr>
                    <tr>
                        <td>
                            <select size=25 id="b_list" style="width:400px;">
                            </select>
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
})
.on('click','#btn_find',function(){
	console.log('checkin='+$('#checkin').val()+'checkout='+$('#checkout').val()+'b_people='+$('#b_people').val())
	let availoption="";
	$.ajax({
		type:'get',
		url:'availList',
		data:{checkin_date:$('#checkin').val(),checkout_date:$('#checkout').val(),booked_people:$('#b_people').val(),room_type:$('#roomType option:selected').val()},
		dataType:'json',
		success:function(data){
			for(i=0;i<data.length;i++){
			list=data[i];
			availoption+="<option value='"+list['room_number']+"'>"+list['room_name']+" "+list['type_name']+" "+
			list['avail_people']+"명 "+list['price']+"원"+"</option>";
			}
			$('#usableRoom').empty().append(availoption);
  			loadBook();
			
		}
	})
})

.on('click','#usableRoom',function(){
	ar=$('#usableRoom option:selected').text().split(' ');
	ar[3]=$.trim(ar[3].replace('원',''));
	console.log(ar);
	$('#room_name').val(ar[0]);
	$('#b_people2').val($('#b_people').val());
	$('#b_checkin').val($('#checkin').val());
	$('#b_checkout').val($('#checkout').val());
	var date1 = new Date($('#b_checkin').val());
	var date2 = new Date($('#b_checkout').val());
	var diffDate = date2.getTime() - date1.getTime();
	var dateDays = diffDate / (1000*60*60*24);
	console.log(dateDays);
	$('#t_price').val(ar[3]*dateDays);
	
})	
.on('click','#b_list',function(){
	ar=$('#b_list option:selected').text().split(' ');
	ar[3]=$.trim(ar[3].replace('명',''));
	ar[6]=$.trim(ar[6].replace('원',''));
	console.log('내역'+ar);
	$('#b_number').val($('#b_list option:selected').val());
	$('#room_name').val(ar[0]);
	$('#b_people2').val(ar[3]);
	$('#b_checkin').val(ar[1]);
	$('#b_checkout').val(ar[2]);
	$('#b_person').val(ar[4]);
	$('#mobile').val(ar[5]);
	$('#t_price').val(ar[6]);	
})
.on('click','#btn_clear',function(){
	$('#usableRoom option:selected').prop('selected',false);
	$('#b_number,#room_name,#b_people2,#b_checkin,#b_checkout,#b_person,#mobile,#t_price').val('');
})

.on('click','#btn_confirm',function(){
	if($('#usableRoom option:selected').prop('selected')==true){
		let ar2=$('#usableRoom option:selected').text().split(' ');
		ar2[2]=$.trim(ar2[2].replace('명',''));		
		if(ar[2]<$('#b_people2').val()){
			alert('숙박 가능 인원을 초과하였습니다');
			return;
		}
		else{
			console.log('booked_people='+$('#b_people2').val()+'total_price='+$('#t_price').val())
		$.ajax({
			type:'get',
			url:'addBook',
			data:{room_number:$('#usableRoom option:selected').val(),booked_people:$('#b_people2').val(),checkin_date:$('#b_checkin').val(),checkout_date:$('#b_checkout').val(),total_price:$('#t_price').val(),booking_person:$('#b_person').val(),mobile:$('#mobile').val()},
			dataType:'json',
			success:function(data){
				loadBook();
				$('#btn_find').trigger('click');
			}
		})
		}
	}
	else if($('#b_list option:selected').prop('selected')==true){
		if($('#b_people2').val()>parseInt($('#b_list option:selected').attr('name'))){
			alert('숙박 가능 인원을 초과하였습니다');
		}
		else{
			console.log('booking_number='+$('#b_number').val()+'booked_people='+$('#b_people2').val())
		$.ajax({
			type:'get',
			url:'updateBook',
			data:{booking_number:$('#b_number').val(),booked_people:$('#b_people2').val(),booking_person:$('#b_person').val(),mobile:$('#mobile').val()},
			dataType:'json',
			success:function(data){
				loadBook();
			}
		})
		}
	}
})
.on('click','#btn_cancel',function(){
	$.ajax({
		type:'get',
		url:'deleteBook',
		data:'booking_number='+$('#b_number').val(),
		dataType:'json',
		success:function(data){
			loadBook();
			$('#btn_clear').trigger('click');
		}
	})
})
.on('click','#usableRoom option',function(){
	$('#b_number,#b_person,#mobile').val('');
})
function loadBook(){
	console.log('load');
	let bookoption="";
	$.ajax({
		type:'get',
		url:'bookList',
		data:{checkin_date:$('#checkin').val(),checkout_date:$('#checkout').val(),b_people:$('#b_people').val(),room_type:$('#roomType option:selected').val()},
		dataType:'json',
		success:function(data){
			for(i=0;i<data.length;i++){
				list=data[i];
				bookoption+="<option name='"+list['avail_people']+"' value='"+list['booking_number']+"'>"+list['room_name']+" "+list['checkin_date']+" "+
				list['checkout_date']+" "+list['booked_people']+"명 "+list['booking_person']+" "+list['mobile']+" "+list['total_price']+"원"+"</option>";
			}
			$('#b_list').empty().append(bookoption);
		}
	})
}


</script>
</html>