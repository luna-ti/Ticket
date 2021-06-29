package com.bookshop01.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop01.goods.dao.GoodsDAO;
import com.bookshop01.goods.vo.GoodsVO;
import com.bookshop01.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	
// SORT박물관, 어트랙션...nature,museum,themepark,history,attraction
	@Override
	public Map<String, List<GoodsVO>> SortList() throws Exception {
		Map<String, List<GoodsVO>> goodsMap = new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList = goodsDAO.selectSortList("nature");
		goodsMap.put("nature", goodsList);//자연동물/ 전망대
		goodsList = goodsDAO.selectSortList("museum");
		goodsMap.put("museum", goodsList);//박물관
		goodsList = goodsDAO.selectSortList("themepark");
		goodsMap.put("themepark", goodsList);//테마파크
		goodsList = goodsDAO.selectSortList("history");
		goodsMap.put("history", goodsList);//역사문화명소
		goodsList = goodsDAO.selectSortList("attraction");
		goodsMap.put("attraction", goodsList);//어트랙션
		return goodsMap;
	}
// PLACE 서울 경기 제주.. seoul,ggi, gang,chung,jeolla, sang,jeju
	@Override
	public Map<String, List<GoodsVO>> PlaceList() throws Exception {
		Map<String, List<GoodsVO>> goodsMap = new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList = goodsDAO.selectPlaceList("seoul");
		goodsMap.put("seoul", goodsList);//서울
		goodsDAO.selectPlaceList("ggi");
		goodsMap.put("ggi", goodsList);//경기
		goodsDAO.selectPlaceList("gang");
		goodsMap.put("gang", goodsList);//강원
		goodsDAO.selectPlaceList("chung");
		goodsMap.put("chung", goodsList);//충청
		goodsDAO.selectPlaceList("jeolla");
		goodsMap.put("jeolla", goodsList);//전라
		goodsDAO.selectPlaceList("sang");
		goodsMap.put("sang", goodsList);//경상
		goodsDAO.selectPlaceList("jeju");
		goodsMap.put("jeju", goodsList);//제주
		return goodsMap;
	
	}
	
// Status 베스트셀러,..  
	
	public Map<String,List<GoodsVO>> StatusList() throws Exception {
		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList=goodsDAO.selectStatusList("bestseller");
		goodsMap.put("bestseller",goodsList);
		return goodsMap;
	}
	//상세페이지
	public Map goodsDetail(String _goods_id) throws Exception {
		Map goodsMap=new HashMap();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList);
		return goodsMap;
	}
	//제목으로 검색
	public List<GoodsVO> searchGoods(String searchWord) throws Exception{
		List goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		return list;
	}
	

	
}
