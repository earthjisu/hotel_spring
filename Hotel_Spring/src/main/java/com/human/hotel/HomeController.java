package com.human.hotel;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SqlSession sqlSession;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String doViewBooking() {
		return "booking";
	}
	@RequestMapping("/room")
	public String doViewRoom() {
		return "room";
	}
	@ResponseBody
	@RequestMapping(value="/availList",produces="application/text;charset=utf-8")
	public String doAvailList(HttpServletRequest req) {
		String checkin_date=req.getParameter("checkin_date");
		String checkout_date=req.getParameter("checkout_date");
		int booked_people=Integer.parseInt(req.getParameter("booked_people"));
		int room_type=Integer.parseInt(req.getParameter("room_type"));
		System.out.println(checkin_date);
		System.out.println(checkout_date);
		iHotel hotel=sqlSession.getMapper(iHotel.class);
		ArrayList<HotelDTO> arAvail=hotel.getAvailList(room_type, booked_people, checkin_date, checkout_date);
		JSONArray ja=new JSONArray();
		for(int i=0;i<arAvail.size();i++) {
			HotelDTO hdto=arAvail.get(i);
			JSONObject jo=new JSONObject();
			jo.put("room_name",hdto.getRoom_name());
			jo.put("room_number", hdto.getRoom_number());
			jo.put("type_name",hdto.getType_name());
			jo.put("avail_people",hdto.getAvail_people());
			jo.put("price", hdto.getPrice());
			ja.add(jo);
		}
		
		return ja.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/bookList",produces="application/text;charset=utf-8")
	public String doBookList(HttpServletRequest req) {
		String checkin=req.getParameter("checkin_date");
		String checkout=req.getParameter("checkout_date");
		int room_type=Integer.parseInt(req.getParameter("room_type"));
		int booked_people=Integer.parseInt(req.getParameter("b_people"));
		iHotel hotel=sqlSession.getMapper(iHotel.class);
		ArrayList<HotelDTO> arBook=hotel.getBookList(room_type, booked_people, checkin, checkout);
		JSONArray ja=new JSONArray();
		for(int i=0;i<arBook.size();i++) {
			HotelDTO hdto=arBook.get(i);
			JSONObject jo=new JSONObject();
			jo.put("avail_people", hdto.getAvail_people());
			jo.put("booking_number", hdto.getBooking_number());
			jo.put("room_name", hdto.getRoom_name());
			jo.put("checkin_date", hdto.getCheckin_date());
			jo.put("checkout_date", hdto.getCheckout_date());
			jo.put("booked_people", hdto.getBooked_people());
			jo.put("booking_person",hdto.getBooking_person());
			jo.put("mobile", hdto.getMobile());
			jo.put("total_price", hdto.getTotal_price());
			ja.add(jo);
		}
		System.out.println(ja.toJSONString());
		return ja.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value="/addBook",produces="application/text;charset=utf-8")
	public String doAddBook(HttpServletRequest req) {
		int room_number=Integer.parseInt(req.getParameter("room_number"));
		String checkin_date=req.getParameter("checkin_date");
		String checkout_date=req.getParameter("checkout_date");
		int booked_people=Integer.parseInt(req.getParameter("booked_people"));
		String booking_person=req.getParameter("booking_person");
		String mobile=req.getParameter("mobile");
		int total_price=Integer.parseInt(req.getParameter("total_price"));
		iHotel hotel=sqlSession.getMapper(iHotel.class);
		hotel.addBook(room_number, booked_people, total_price, booking_person, mobile, checkin_date, checkout_date);
		return "0";
	}
	@ResponseBody
	@RequestMapping(value="/updateBook",produces="application/text;charset=utf-8")
	public String doupdateBook(HttpServletRequest req) {
		int booked_people=Integer.parseInt(req.getParameter("booked_people"));
		String booking_person=req.getParameter("booking_person");
		String mobile=req.getParameter("mobile");
		int booking_number=Integer.parseInt(req.getParameter("booking_number"));
		iHotel hotel=sqlSession.getMapper(iHotel.class);
		hotel.updateBook(booked_people, booking_person, mobile, booking_number);
		return "0";
	}
	@ResponseBody
	@RequestMapping(value="/deleteBook",produces="application/text;charset=utf-8")
	public String doDeleteBook(HttpServletRequest req) {
		int booking_number=Integer.parseInt(req.getParameter("booking_number"));
		iHotel hotel=sqlSession.getMapper(iHotel.class);
		hotel.deleteBook(booking_number);
		return "0";
	}
}
