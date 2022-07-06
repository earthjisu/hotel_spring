package com.human.hotel;

import java.util.ArrayList;

public interface iHotel {
	ArrayList<HotelDTO> getAvailList(int room_type,int booked_people,String checkin_date,String checkout_date);
	ArrayList<HotelDTO> getBookList(int room_type,int booked_people,String checkin_date,String checkout_date);
	int addBook(int room_number,int booked_people,int total_price,String booking_person,String mobile,String checkin_date,String checkout_date);
	int updateBook(int booked_people,String booking_person,String Mobile,int Booking_number);
	int deleteBook(int booking_number);
}
