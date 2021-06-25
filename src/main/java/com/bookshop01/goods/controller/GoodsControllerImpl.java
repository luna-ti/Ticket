package com.bookshop01.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.common.base.BaseController;
import com.bookshop01.goods.service.GoodsService;
import com.bookshop01.goods.vo.GoodsVO;

import net.sf.json.JSONObject;

@Controller("goodsController")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController   implements GoodsController {
	@Autowired
	private GoodsService goodsService;
	
	//상품리스트 
	@RequestMapping(value="/goodsList.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,
			                           HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "admin_mode"); 
		
		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		
		Map<String,Object> condMap=new HashMap<String,Object>();
		if(section== null) {
			section = "1";
		}
		condMap.put("section",section);
		if(pageNum== null) {
			pageNum = "1";
		}
		condMap.put("pageNum",pageNum);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		Map<String, List<GoodsVO>> GoodsList= goodsService.listGoods();
		mav.addObject("newGoodsList", GoodsList);
		
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate2[0]);
		mav.addObject("endMonth",endDate2[1]);
		mav.addObject("endDay",endDate2[2]);
		
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		return mav;
		
	}
	//sort 테마파크, 박물관 리스트 
	//
	@RequestMapping(value= "/itList.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods2();
		mav.addObject("Map", goodsMap);
		return mav;
	}
	//college
	@RequestMapping(value= "/college.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView coll(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods2();
		mav.addObject("Map", goodsMap);
		return mav;
	}
	//economy
	@RequestMapping(value= "/economy.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView eco(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods2();
		mav.addObject("Map", goodsMap);
		return mav;
	}
	//human
	@RequestMapping(value= "/human.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView hum(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods2();
		mav.addObject("Map", goodsMap);
		return mav;
	}
	//improve
	@RequestMapping(value= "/improve.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView impr(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods2();
		mav.addObject("Map", goodsMap);
		return mav;
	}
	//science
	@RequestMapping(value= "/science.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView sci(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods2();
		mav.addObject("Map", goodsMap);
		return mav;
	}
	//pop
	@RequestMapping(value="/pop.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView pop(HttpServletRequest rq,HttpServletResponse rs) throws Exception
	{	ModelAndView mv = new ModelAndView();
		HttpSession session = rq.getSession();
		String viewName = (String) rq.getAttribute("viewName");
		Map<String,List<GoodsVO>> goodsMap = goodsService.listGoods2();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		
		return mv;
	
	}
	//rock
	@RequestMapping(value="/rock.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView rock(HttpServletRequest rq, HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");
		Map<String,List<GoodsVO>> goodsMap = goodsService.listGoods2();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		return mv;
	}
	//classic
	@RequestMapping(value="/classic.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView classic(HttpServletRequest rq, HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");
		mv.addObject("Map",goodsService.listGoods2());
		mv.setViewName(viewName);
		return mv;
	}
	//newage
	@RequestMapping(value="/newage.do", method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView newage(HttpServletRequest rq, HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");
		mv.addObject("Map",goodsService.listGoods2());
		mv.setViewName(viewName);
		return mv;
	}
	//JAZZ
	@RequestMapping(value="/jazz.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView jazz(HttpServletRequest rq,HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");
		mv.addObject("Map",goodsService.listGoods2());
		mv.setViewName(viewName);
		return mv;
	}
	//others
	@RequestMapping(value="/others.do",method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView others (HttpServletResponse rs,HttpServletRequest rq) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("Map",goodsService.listGoods2());
		String viewName = (String) rq.getAttribute("viewName");
		mv.setViewName(viewName);
		return mv;
	}
	
	
	
	//��ǰ��
	@RequestMapping(value="/goodsDetail.do" ,method = RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		HttpSession session=request.getSession();
		Map goodsMap=goodsService.goodsDetail(goods_id);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsMap", goodsMap);
		GoodsVO goodsVO=(GoodsVO)goodsMap.get("goodsVO");
		addGoodsInQuick(goods_id,goodsVO,session);
		return mav;
	}
	
	@RequestMapping(value="/keywordSearch.do",method = RequestMethod.GET,produces = "application/text; charset=utf8")
	public @ResponseBody String  keywordSearch(@RequestParam("keyword") String keyword,
			                                  HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		//System.out.println(keyword);
		if(keyword == null || keyword.equals(""))
		   return null ;
	
		keyword = keyword.toUpperCase();
	    List<String> keywordList =goodsService.keywordSearch(keyword);
	    
	 // ���� �ϼ��� JSONObject ����(��ü)
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);
		 		
	    String jsonInfo = jsonObject.toString();
	   // System.out.println(jsonInfo);
	    return jsonInfo ;
	}
	
	@RequestMapping(value="/searchGoods.do" ,method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		return mav;
		
	}
	
	private void addGoodsInQuick(String goods_id,GoodsVO goodsVO,HttpSession session){
		boolean already_existed=false;
		List<GoodsVO> quickGoodsList; //�ֱ� �� ��ǰ ���� ArrayList
		quickGoodsList=(ArrayList<GoodsVO>)session.getAttribute("quickGoodsList");
		
		if(quickGoodsList!=null){
			if(quickGoodsList.size() < 4){ //�̸��� ��ǰ ����Ʈ�� ��ǰ������ ���� ������ ���
				for(int i=0; i<quickGoodsList.size();i++){
					GoodsVO _goodsBean=(GoodsVO)quickGoodsList.get(i);
					if(goods_id.equals(_goodsBean.getGoods_id())){
						already_existed=true;
						break;
					}
				}
				if(already_existed==false){
					quickGoodsList.add(goodsVO);
				}
			}
			
		}else{
			quickGoodsList =new ArrayList<GoodsVO>();
			quickGoodsList.add(goodsVO);
			
		}
		session.setAttribute("quickGoodsList",quickGoodsList);
		session.setAttribute("quickGoodsListNum", quickGoodsList.size());
	}
}
