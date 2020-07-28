package com.VIG.mvc.web.payment;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.payment.PaymentServices;
import com.VIG.mvc.service.user.UserServices;

@Controller
@RequestMapping("/payment/*")
public class PaymentController {
	
	
	@Autowired
	@Qualifier("paymentServicesImpl")
	private PaymentServices paymentServices;
	
	@Autowired
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	public PaymentController() {
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping(value="addPayment", method=RequestMethod.GET)
	public ModelAndView addPayment(@RequestParam("productType") int productType, HttpServletRequest request) throws Exception {
		
		System.out.println("addPayment:GET");
		System.out.println(productType+" : ");
		ModelAndView mav = new ModelAndView();
		
		
		//0: 프라임피드결제 , 1: 비즈니스전환결제, 2:후원결제
		if(productType == 0) {
			//프라임 피드 결제
			mav.setViewName("forward:/payment/addPrimeView.jsp");
			
		}
		
		if(productType == 1) {
			//비즈니스 전환 결제
			mav.setViewName("forward:/payment/addBusinessView.jsp");
			
			
		}
		
		if(productType == 2) {
			//후원 결제
			int feedId = Integer.parseInt(request.getParameter("feedId"));
			System.out.println(feedId);
			Feed feed = feedServices.getFeed(feedId);
			User writer = feed.getWriter();
			System.out.println(writer);
			
			if(writer.getRole().contains("business")) {
			
			mav.setViewName("forward:/payment/addDonationView.jsp");
			
			mav.addObject("feed", feed);
			
			}
			
		}
		
		return mav;
		
	}
	//후원추가
	@RequestMapping(value="addDonation", method=RequestMethod.POST)
	public ModelAndView addDonation(@ModelAttribute("payment") Payment payment, HttpSession session) throws Exception {
		
		
		System.out.println(payment);
		User sessionUser = (User)session.getAttribute("user");
		payment.setBuyer(sessionUser);
		
		
		paymentServices.addPayment(payment);
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/payment/addPayment.jsp");
		mav.addObject("payment", payment);
		
		return mav;
	}
	//프라임피드 1000건 추가
	@RequestMapping(value="addPrime", method=RequestMethod.POST)
	public ModelAndView addPrime(@ModelAttribute("payment") Payment payment, HttpSession session) throws Exception {
		
		System.out.println(payment);
		User sessionUser = (User)session.getAttribute("user");
		
		//feedCount 추가
		int pc = sessionUser.getPrimeCount();
		pc += 1000;
		sessionUser.setPrimeCount(pc);
		//UserServices.updatePrime
		
		payment.setBuyer(sessionUser);
		
		
		
		paymentServices.addPayment(payment);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/payment/addPayment.jsp");
		mav.addObject("payment", payment);
		return mav;
	}
	//비즈니스유저로 변경
	@RequestMapping(value="addBusiness", method=RequestMethod.POST)
	public ModelAndView addBusiness(@ModelAttribute("payment") Payment payment, HttpSession session) throws Exception {
		
		System.out.println(payment);
		User sessionUser = (User)session.getAttribute("user");
		
		//role 변경
		sessionUser.setRole("business");
		//userServices.updateUser
		
		paymentServices.addPayment(payment);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/payment/addPayment.jsp");
		mav.addObject("payment", payment);
		return mav;
	}
	
	
	@RequestMapping(value="getPaymentList", method=RequestMethod.GET)
	public ModelAndView getPaymentList(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
		
		User user = (User) session.getAttribute("user");
		search.setKeyword(user.getUserCode());
		// 현재 페이지값이 없으면 첫번째 페이지로 설정
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		//키워드 데이터가 NULL이라면
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		
		search.setPageSize(pageSize);
		
		System.out.println(search);
		
		List<Payment> list = paymentServices.getPaymentList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), paymentServices.getCountPayment(search) , pageUnit, pageSize);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/payment/getPaymentList.jsp");
		mav.addObject("list", list);
		mav.addObject("resultPage", resultPage);
		
		return mav;
	}
	
	@RequestMapping(value="cancelPayment", method=RequestMethod.GET)
	public ModelAndView cancelPayment(@RequestParam("paymentId") String paymentId) throws Exception {
		
		paymentServices.cancelPayment(paymentId);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/payment/getPaymentList");
		return mav;
	}
	
	

}