package com.postgre.choongsam.controller;

import java.io.File;
import java.io.IOException;
import java.util.Random;
import java.util.UUID;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.postgre.choongsam.configuration.RSAUtil;
import com.postgre.choongsam.dto.Login_Info;
import com.postgre.choongsam.dto.RSA;
import com.postgre.choongsam.dto.User_Info;
import com.postgre.choongsam.service.LjmService;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LjmController {
	
	private final LjmService ljs;
	private final JavaMailSender mailSender;
	private final PasswordEncoder passwordEncoder;
	
		// 로그인 페이지 이동
		@RequestMapping(value =  "view_Ljm/loginForm")
		public String showLoginPage(HttpSession session, Model model) {
			RSAUtil rsaUtil = new RSAUtil();
			RSA rsa = rsaUtil.createRSA();
		    session.setAttribute("RSAprivateKey", rsa.getPrivateKey());
		    model.addAttribute("publicKeyModulus", rsa.getModulus());
		    model.addAttribute("publicKeyExponent", rsa.getExponent());
			return "view_Ljm/loginForm";
		}
		
		// 로그인 처리
		@RequestMapping(value = "view_Ljm/login")
		public String login(
		                    @RequestParam("user_id") String user_id,
		                    @RequestParam("password") String password, 
		                    Model model,
		                    HttpSession session, 
		                    HttpServletRequest request) {            
		    System.out.println("로그인 컨트롤러 이동");

		    System.out.println("user_id -> " + user_id);
		    
		    // 패스워드 암호화
		    // String encPasswd = passwordEncoder.encode(password);
		    // System.out.println("encPasswd" + encPasswd);
	    
		    Login_Info login_info = ljs.login(user_id, password); // 로그인 정보 조회
		    User_Info user_Info = null;
		   		    		    
		    // 로그인 실패
		    if (login_info == null) {
		        System.out.println(user_id + "로그인 실패");
		        model.addAttribute("loginError", "아이디 또는 비밀번호가 잘못되었습니다.");
		        model.addAttribute("user_id", user_id);
		        System.err.println("로그인 실패");
		        return "view_Ljm/loginForm"; 
		    }
		    
		    // 탈퇴한 사용자 여부 체크
		    user_Info = ljs.getUserStatus(user_id);  // getUserStatus 메서드 호출
		    if ("1".equals(user_Info.getDel_state())) { // 탈퇴한 사용자
		        model.addAttribute("loginError", "탈퇴한 회원입니다.");
		        model.addAttribute("user_id", user_id); // 입력한 아이디를 다시 전달
		        return "view_Ljm/loginForm";
		    }

		    // 기존 세션 무효화 후 새로운 세션 생성        
		    session.invalidate();
		    session = request.getSession(true);

		    // 회원 번호, 회원 아이디, 회원 분류를 세션에 저장
		    session.setAttribute("user_seq", login_info.getUser_seq()); // 세션에 회원 번호 저장
		    session.setAttribute("user", login_info.getUser_id()); // 세션에 회원 아이디 저장
		    session.setAttribute("usertype", login_info.getUser_status()); // 세션에 회원 분류 저장

		    // 유저 이름 가져오기
		    String user_name = ljs.getUserName(login_info.getUser_seq());
		    session.setMaxInactiveInterval(60 * 60); // 60분 동안 활동이 없으면 세션 만료
		    session.setAttribute("user_name", user_name);
		    
		    System.out.println("user_name -->" + user_name);
		    System.out.println("로그인 성공");
		    return "redirect:/"; // 로그인 성공 시 리다이렉트
		}

		
		// 관리자 로그인 처리
				@RequestMapping(value = "view_Ljm/adminLogin")
				public String adminLogin(
									@RequestParam("user_id") String user_id,
									@RequestParam("password") String password, Model model,
									HttpSession session, HttpServletRequest request) {			
					System.out.println("관리자로그인 컨트롤러 이동");
					
					System.out.println("user_id -> "+ user_id);
					Login_Info login_info = new Login_Info();
					User_Info user_Info = new User_Info();
					
					login_info = ljs.adminLogin(user_id, password);
					
					System.out.println(user_id + "컨트롤러 로그인 성공");
					
					// 로그인 실패
					if (login_info == null) {
						System.out.println(user_id + "로그인 실패");
						model.addAttribute("loginError", "관리자만 로그인이 가능합니다.");
						model.addAttribute("user_id", user_id);
						System.err.println("로그인 실패");
						return "view_Ljm/adminLoginForm"; 
					}
					
					// 로그인 실패
					if (login_info.getUser_status() != 1003) {
						System.out.println(user_id + "로그인 실패");
						model.addAttribute("loginError", "관리자만 로그인이 가능합니다.");
						model.addAttribute("user_id", user_id);
						System.err.println("로그인 실패");
						return "view_Ljm/adminLoginForm"; 
					}					
					
					// 기존 세션 무효화 후 새로운 세션 생성		
					session.invalidate();
					session = request.getSession(true);

					// 회원 번호, 회원 아이디, 회원 분류를 세션에 저장
					session.setAttribute("user_seq", login_info.getUser_seq()); // 세션에 회원 번호 저장
					session.setAttribute("user", login_info.getUser_id()); // 세션에 회원 아이디 저장
					session.setAttribute("usertype", login_info.getUser_status()); // 세션에 회원 분류 저장
					

					// 유저 이름 가져오기
					String user_name = ljs.getUserName(login_info.getUser_seq());

					session.setMaxInactiveInterval(60 * 60); // 60분 동안 활동이 없으면 세션 만료
					session.setAttribute("user_name",user_name);
					System.out.println("user_name -->"+user_name);
					System.out.println("로그인 성공");
					return "redirect:/"; // 로그인 성공 시 리다이렉트

				}		
		
		// 관리자 로그인 페이지 이동
		@RequestMapping(value =  "view_Ljm/adminLoginForm")
		public String showAdminLoginPage() {
			return "view_Ljm/adminLoginForm";
		}
		
		// 로그아웃
		@RequestMapping(value = "view_Ljm/logout")
		public String logout(HttpSession session, Model model) {
			// 세션 해제
			session.invalidate();
			System.out.println("로그아웃 성공");
			return "redirect:/"; // 로그아웃 성공 시 메인화면으로 리다이렉트
		}
		
		// 아이디 찾기 페이지 이동
		@GetMapping(value =  "view_Ljm/findId")
		public String findIdPage() {
			return "view_Ljm/findId"; 
		}
		
		// 아이디 찾기
		@RequestMapping(value = "view_Ljm/findIdResult")
		public String findId(@RequestParam("user_name") String user_name, @RequestParam("email") String email, Model model) {
			System.out.println("LjmController findId() start...");
			
			System.out.println("LjmController findId() user_name -> " + user_name);
			System.out.println("LjmController findId() email -> " + email);
			
			model.addAttribute("user_name", user_name);
		    model.addAttribute("email", email);
		    
			User_Info user_info = new User_Info();
			user_info.setUser_name(user_name);
			user_info.setEmail(email);
			
			String user_id = ljs.findId(user_info);
			
			if (user_id != null) {
				model.addAttribute("find_id", user_id);
				model.addAttribute("userCheckMessage", "회원님의 정보로 가입된 아이디는 아래와 같습니다.");
			} else {
				model.addAttribute("userCheckMessage", "입력하신 회원 정보와 일치하는 아이디가 존재하지 않습니다.");
			}
			
			return "view_Ljm/findIdResult";			
		}
		
		// 비밀번호 찾기 페이지 이동
		@GetMapping(value =  "view_Ljm/findPw")
		public String findPwPage() {
			return "view_Ljm/findPw";
		}
		
		// 비밀번호 찾기
		@RequestMapping(value = "view_Ljm/findPwResult")
		public String findPw(@ModelAttribute User_Info user_info, Model model) {
			System.out.println("LjmController findPw() start...");
			
			System.out.println("LjmController findPw() user_name -> " + user_info.getUser_id());
			System.out.println("LjmController findPw() email -> " + user_info.getEmail());
			
			// 사용자 확인
			User_Info user = ljs.findPw(user_info);
			if (user != null) {
				String user_id = user.getUser_id();
				String tempPassword = ljs.createTempPassword(user_id);
				System.out.println("LjmController tempPassword tempPassword : " + tempPassword);

				// 이메일로 비밀번호 발송
				int result = ljs.sendTempPw(user_id, tempPassword);
				System.out.println("LjmController tempPassword result >>> " + result);
				model.addAttribute("user_id", user_id);
				model.addAttribute("userCheckMessage", "입력하신 이메일로 임시 비밀번호가 발급되었습니다.");
			} else {
				model.addAttribute("userCheckMessage", "입력하신 회원 정보가 존재하지 않습니다.");
			}

			return "view_Ljm/findPwResult";	
		}

			
		// 회원가입 페이지 (이용약관) 이동
		@GetMapping(value =  "view_Ljm/signup1")
		public String showSignupPage1() {
			return "view_Ljm/signup1";
		}
		
		// 회원가입 페이지 (정보입력) 이동
		@GetMapping(value =  "view_Ljm/signup2")
		public String showSignupPage2() {
			return "view_Ljm/signup2";
		}
		
		// 아이디 중복 체크
		@GetMapping(value = "view_Ljm/confirmId")
		@ResponseBody // Ajax
		public int confirmId(@RequestParam("user_id") String user_id) {
			System.out.println("LjmController confirmId() start...");
			int result = ljs.confirmId(user_id);
			return result;
		}
		
		// 회원가입 처리
		@RequestMapping(value = "view_Ljm/signup")
		public String signup(@ModelAttribute Login_Info login_Info, User_Info user_info, 
		                     @RequestParam(value = "profileImage", required = false) MultipartFile profileImage,
		                     HttpServletRequest request,  // HttpServletRequest 추가
		                     Model model) {
		    System.out.println("signup Start...");

		    // 프로필 사진 파일이 첨부된 경우에만 파일 업로드 처리
		    if (profileImage != null && !profileImage.isEmpty()) {
		        // 프로필 사진 파일을 업로드할 경로 지정 (서버의 실제 경로 사용)
		        String uploadDir = request.getServletContext().getRealPath("/chFile/user/");

		        // UUID로 고유한 파일 이름 생성 (확장자 추출)
		        String originalFileName = profileImage.getOriginalFilename();
		        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
		        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;  // UUID + 확장자

		        // 파일 경로 설정
		        String profileAddr = uploadDir + uniqueFileName;  // /WEB-INF/chFile/user/UUID.png

		        // 파일을 저장할 디렉토리 생성
		        File dir = new File(uploadDir);
		        if (!dir.exists()) {
		            dir.mkdirs();  // 폴더가 없다면 생성
		        }

		        // 파일 저장
		        try {
		            File file = new File(uploadDir + uniqueFileName);
		            profileImage.transferTo(file);  // 파일 저장
		            System.out.println("파일 업로드 성공: " + file.getAbsolutePath());
		        } catch (IOException e) {
		            e.printStackTrace();
		            model.addAttribute("msg", "파일 업로드에 실패했습니다.");
		            return "main";
		        }

		        // 프로필 이미지 경로와 이름을 로그인 정보 및 사용자 정보에 세팅
		        user_info.setProfile_addr(profileAddr);  // DB에 저장할 프로필 주소
		        user_info.setProfile_name(uniqueFileName);  // DB에 저장할 프로필 파일명 (UUID)
		    } else {
		        // 파일이 첨부되지 않은 경우 프로필 정보를 비워두거나 기본값 설정
		        user_info.setProfile_addr(null);
		        user_info.setProfile_name(null);
		    }

		    // 회원가입 처리 (DB에 저장 등)
		    int signupResult = ljs.signup(login_Info, user_info);
		    System.out.println("LjmController signupResult -> " + signupResult);

		    if (signupResult > 0) {
		        return "view_Ljm/signup3";  // 회원가입 성공 후 이동할 페이지
		    } else {
		        model.addAttribute("msg", "회원가입에 실패하였습니다.");
		        return "main";  // 회원가입 실패 후 이동할 페이지
		    }
		}

}
