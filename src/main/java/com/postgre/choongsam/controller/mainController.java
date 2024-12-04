package com.postgre.choongsam.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.postgre.choongsam.dto.Lecture;
import com.postgre.choongsam.dto.Notice;
import com.postgre.choongsam.dto.User_Info;
import com.postgre.choongsam.service.mainService;


import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class mainController {
	
	private final mainService ms;
	
	
	@GetMapping(value="/")
	public String test(Model model) {
		System.out.println("컨트롤러옴");
		
		User_Info test = ms.test();

		List<Lecture> lecture = ms.getLectureList();
		List<Notice> notice = ms.getNotice();
		
		System.out.println(test);
		
		model.addAttribute("test",test);
		model.addAttribute("lecture", lecture);
		model.addAttribute("notice", notice);
		

		return "main";
	}

}
