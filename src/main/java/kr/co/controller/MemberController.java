package kr.co.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.MemberService;
import kr.co.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	MemberService service;
	
	// 회원가입 GET (회원가입 폼으로 이동)
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception {
		logger.info("get register");
	}
	
	// 회원가입 POST (회원가입 버튼을 눌렀을 때 실행)
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception {
		logger.info("post register");
		
		int result = service.idChk(vo);
		try {
			// 아이디가 존재한다면 회원가입 페이지로
			// 중복확인을 하고나서 아이디를 바꿔서 시도했을때 회원가입 방지
			if(result == 1) {
				return "member/register";
			} else if(result == 0) {
				service.register(vo);
			}
		} catch(Exception e) {
			throw new RuntimeException();
		}
		
		return "redirect:/";
	}
	
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
		logger.info("post login");
		
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo);
		
		if(login != null) {
			session.setAttribute("member", login);
		} else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		}
		
		return "redirect:/board/list";
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	// 회원정보수정 (폼으로 이동)
	@RequestMapping(value = "/memberUpdateView", method = RequestMethod.GET)
	public String registerUpdateView() throws Exception {
		return "member/memberUpdateView";
	}
	
	
	// 회원정보 수정 (처리)
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String registerUpdate(MemberVO vo, HttpSession session) throws Exception {
		service.memberUpdate(vo);
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	// 회원틸퇴 GET (회원탈퇴 페이지로 이동)
	@RequestMapping(value = "/memberDeleteView", method = RequestMethod.GET)
	public String memberDeleteView() throws Exception {
		return "member/memberDeleteView";
	}
	
	// 회원탈퇴 POST (회원탈퇴 처리)
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		
//		MemberVO member = (MemberVO) session.getAttribute("member");
//		// 세션에 있는 비밀번호
//		String sessionPass = member.getUserPass();
//		// vo로 들어오는 비밀번호
//		String voPass = vo.getUserPass();
//		
//		// 세션에 있는 비밀번호와 입력된 비밀번호가 같지 않다면 false
//		if(!(sessionPass.equals(voPass))) {
//			rttr.addFlashAttribute("msg", false);
//			
//			return "redirect:/member/memberDeleteView";
//		}
		
		service.memberDelete(vo);
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	// 패스워드 체크 with ajax + 암호화
	@ResponseBody
	@RequestMapping(value = "/passChk", method = RequestMethod.POST)
	public int passChk(MemberVO vo) throws Exception{
		int result = service.passChk(vo);
		
		return result;
	}
		
	
	// 아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "/idChk", method = RequestMethod.POST)
	public int idChk(MemberVO vo) throws Exception{
		int result = service.idChk(vo);
		
		return result;
	}
	

}
