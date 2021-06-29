package com.bookshop01.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.bookshop01.goods.vo.GoodsVO;
import com.bookshop01.goods.vo.ImageFileVO;

public interface GoodsDAO {
	public List<GoodsVO> selectSortList(String goods_sort) throws DataAccessException;//변수명 goods_sort 라고 줘야 되나?
	public List<GoodsVO> selectStatusList(String goods_status) throws DataAccessException;
	public List<GoodsVO> selectPlaceList(String goods_place) throws DataAccessException;
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;
}
