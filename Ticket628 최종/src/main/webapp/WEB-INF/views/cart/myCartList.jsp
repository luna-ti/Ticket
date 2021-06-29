<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />
<c:set var="totalGoodsNum" value="0" />  <!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 안쓸듯--> 
<c:set var="totalDiscountedPrice" value="0"/><!-- 총 할인후 금액 ㅌㅌㅌ-->
<c:set var="totalDiscountPrice" value="0" /> <!-- 총 할인금액 ㅌㅌㅌㅌ-->


<c:set var="totalGoodsPrice" value="0"/> <!-- 정가*수량 총 합 -->
<c:set var="totalSalesPrice" value="0"/> <!-- 할인가*수량 총합 -->
<c:set var="totalDiscount" value="0"/> <!-- 할인된 금액 총합  -->

<head>


<script type="text/javascript">

function calcGoodsPrice(bookPrice,obj){
	var totalPrice,final_total_price,totalNum;
	var goods_qty=document.getElementById("select_goods_qty");
	//alert("총 상품금액"+goods_qty.value);
	var p_totalNum=document.getElementById("p_totalNum");
	var p_totalPrice=document.getElementById("p_totalPrice");
	var p_final_totalPrice=document.getElementById("p_final_totalPrice");
	var h_totalNum=document.getElementById("h_totalNum");
	var h_totalPrice=document.getElementById("h_totalPrice");
	var h_totalDelivery=document.getElementById("h_totalDelivery");
	var h_final_total_price=document.getElementById("h_final_totalPrice");
	if(obj.checked==true){
	//	alert("체크 했음")
		
		totalNum=Number(h_totalNum.value)+Number(goods_qty.value);
		//alert("totalNum:"+totalNum);
		totalPrice=Number(h_totalPrice.value)+Number(goods_qty.value*bookPrice);
		//alert("totalPrice:"+totalPrice);
		final_total_price=totalPrice+Number(h_totalDelivery.value);
		//alert("final_total_price:"+final_total_price);

	}else{
	//	alert("h_totalNum.value:"+h_totalNum.value);
		totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
	//	alert("totalNum:"+ totalNum);
		totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value)*bookPrice;
	//	alert("totalPrice="+totalPrice);
		final_total_price=totalPrice-Number(h_totalDelivery.value);
	//	alert("final_total_price:"+final_total_price);
	}
	
	h_totalNum.value=totalNum;
	
	h_totalPrice.value=totalPrice;
	h_final_total_price.value=final_total_price;
	
	p_totalNum.innerHTML=totalNum;
	p_totalPrice.innerHTML=totalPrice;
	p_final_totalPrice.innerHTML=final_total_price;
}

function modify_cart_qty(goods_id,bookPrice,index){
	//alert(index);  //bookprice가 아니라 salesprice
   var length=document.frm_order_all_cart.cart_goods_qty.length;
   var _cart_goods_qty=0;
	if(length>1){ //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index].value;		
	}else{
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty.value;
	}
		
	var cart_goods_qty=Number(_cart_goods_qty);
	//alert("cart_goods_qty:"+cart_goods_qty);
	//console.log(cart_goods_qty);
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/cart/modifyCartQty.do",
		data : {
			goods_id:goods_id,
			cart_goods_qty:cart_goods_qty
		},
		
		success : function(data, textStatus) {
			//alert(data);
			if(data.trim()=='modify_success'){
				alert("수량을 변경했습니다!!");	
			}else{
				alert("다시 시도해 주세요!!");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax	
}

function delete_cart_goods(cart_id){
	var cart_id=Number(cart_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_id";
	i_cart.value=cart_id;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
    formObj.submit();
}
/*
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	//goodsDetail 에서 따온거 일단 다른거 하나 여기 다시 하자 
	
	//var total_price,final_total_price; //없어도 실행되얗dsadsadsadsads
	var order_goods_qty=document.getElementById("order_goods_qty");
	
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=Number(order_goods_qty);
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
	}	
	*/

//'${item.goods_id }','${item.goods_title }','${discounted_price}','${item.goods_fileName}');">

function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	
	
	//var total_price,final_total_price,_goods_qty;
	var order_goods_qty=document.getElementById("cart_goods_qty");
	
	_order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    .
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=order_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
    
} 

function fn_order_all_cart_goods(){
//	alert("모두 주문하기");
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty;
	var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
	var checked_goods=objForm.checked_goods;
	var length=checked_goods.length;
	
	
	//alert(length);
	if(length>1){
		for(var i=0; i<length;i++){
			if(checked_goods[i].checked==true){
				order_goods_id=checked_goods[i].value;
				order_goods_qty=cart_goods_qty[i].value;
				cart_goods_qty[i].value="";
				cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
				//alert(select_goods_qty[i].value);
				console.log(cart_goods_qty[i].value);
			}
		}	
	}else{
		order_goods_id=checked_goods.value;
		order_goods_qty=cart_goods_qty.value;
		cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
		//alert(select_goods_qty.value);
	}
		
 	objForm.method="post";
 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
	objForm.submit();
}


</script>
</head>
<body>
<form name="frm_order_all_cart">
<table class="list_view">
<tbody align="center">
	<tr style="background:#86A5FF">
		<td class="fixed" >구분</td>
		<td colspan=2 class="fixed">상품명</td>
		<td>정가</td>
		<td>판매가</td>
		<td>수량</td>
		<td>합계</td>
		<td>주문</td>
	</tr>
		<c:choose>
			<c:when test="${empty myCartList }">
	<tr>
		<td colspan="8" class="fixed">
			<strong>장바구니에 상품이 없습니다.</strong>
		</td>
	</tr>
			</c:when>
		<c:otherwise>
			<c:forEach var="item" items="${myGoodsList}" varStatus="idx">
	<tr>
	<c:set var="cart_goods_qty" value="${myCartList[idx.index].cart_goods_qty}"/>	
	<c:set var="cart_id" value="${myCartList[idx.index].cart_id}" />
		
	
	 
	<c:set var="goods_price" value="${item.goods_price }"/> 
	<c:set var="goods_sales_price" value="${item.goods_sales_price }"/>
	<c:set var="goods_discount" value="${item.goods_discount }"/>
	
	<c:set var="priceXqty" value="${goods_price*cart_goods_qty }"/>
	<c:set var="salespriceXqty" value="${goods_sales_price*cart_goods_qty }"/>
		<td>
			<input type="checkbox" name="checked_goods"  checked  value="${item.goods_id}"  onClick="calcGoodsPrice(${salespriceXqty},this)">
		</td>
		<td class="goods_image">
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
			<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}" />		</a>
		</td>
		<td>
			<h2>
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title}</a>
			</h2>
					${item.goods_id }
		</td>
		<td class="price">
			<fmt:formatNumber value="${goods_price }" var="fmtgoods_price" type="number" pattern="#,###"/>
			<span>${fmtgoods_price }원</span>
		</td>
		<td class="price">
			<fmt:formatNumber value="${goods_sales_price }" var="fmtgoods_sales_price" type="number" pattern="#,###"/>
			<span>${fmtgoods_sales_price }원<br>(${item.goods_discount}% 할인)</span>
		</td>
		<td> <!-- 수량 -->
			<input type="text" id="cart_goods_qty" name="cart_goods_qty" size="3" value="${cart_goods_qty}"><br>
			<a href="javascript:modify_cart_qty(${item.goods_id},${goods_sales_price},${idx.index });" >
			<img width=25 alt=""  src="${contextPath}/resources/image/btn_modify_qty.jpg">
			</a>
		</td>
		<td>		<!-- 합계 -->
		 	<fmt:formatNumber value="${goods_sales_price*cart_goods_qty}" type="number" var="fmtsalespriceXqty" pattern="#,###"/>
			<strong>      ${fmtsalespriceXqty}원	</strong> 
		</td>
		<td><!-- 각각구매 -->
			<a href="javascript:fn_order_each_goods('${item.goods_id }','${item.goods_title }','${goods_sales_price}','${item.goods_fileName}');">
		   	<img width="75" alt=""  src="${contextPath}/resources/image/btn_order.jpg">
			</a><br>
			<a href="#"> 
			<img width="75" alt=""
				src="${contextPath}/resources/image/btn_order_later.jpg">
			</a><br> 
						<a href="#"> 
						   <img width="75" alt=""
							src="${contextPath}/resources/image/btn_add_list.jpg">
						</A><br> 
						<a href="javascript:delete_cart_goods('${cart_id}');"> 
						   <img width="75" alt=""
							   src="${contextPath}/resources/image/btn_delete.jpg">
			   </a>
		</td>
	</tr>
			<!--<c:if test="${item.goods_delivery_price>0}">
				<c:set var="totalDeliveryPrice" value="2500"/>
			</c:if>-->
			
			<!-- 나온 가격 다 합쳐서 계산하는 부분 -->
			
			
			<c:set var="totalGoodsPrice" value="${totalGoodsPrice+goods_price*cart_goods_qty }" />
			<c:set var="totalGoodsNum" value="${totalGoodsNum+1}" />
			<c:set var="totalSalesPrice" value="${totalSalesPrice+goods_sales_price*cart_goods_qty }"/> <!-- 할인가*수량 총합 -->
			<c:set var="totalDiscount" value="${totalDiscount+goods_price*(goods_discount/100) }"/> <!-- 할인된 금액 총합  -->
						
			<!-- 
			<c:set var="totalDiscountedPrice" value="${totalDiscountedPrice+discounted_price*cart_goods_qty}" />
			<c:set var="totalDiscountPrice" value="${totalDiscountPrice+discount_price*cart_goods_qty}" />
		 -->
			</c:forEach>
	</c:otherwise>
	</c:choose>
</tbody>

</table>
<div class="clear"></div>
<br>
<br>
  <table  width=80%   class="list_view" style="background:#cacaff">
   <tbody>
        <tr  align=center  class="fixed" >
          <td class="fixed">총 상품수 </td>
          <td>총 상품금액</td>
          <!--  <td>  </td>
          <td>총 배송비</td>-->
         <td>  </td>
           <td>총 할인 금액 </td>
          <td>  </td>
          <td>최종 결제금액</td>
        </tr>
      <tr cellpadding=40  align=center >
         <td id="">
           <p id="p_totalGoodsNum">${totalGoodsNum}개 </p>
           <input id="h_totalGoodsNum"type="hidden" value="${totalGoodsNum}"  />
         </td>
         
     <!--총상품금액 -->     
          <td>
             <p id="p_totalGoodsPrice">
             <fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="fmttotalGoodsPrice" />
                     ${fmttotalGoodsPrice}원
             </p>
             <input id="h_totalGoodsPrice"type="hidden" value="${totalGoodsPrice}" />
          </td>
         <!--총배송금액
          <td> 
             <img width="25" alt="" src="${contextPath}/resources/image/plus.jpg">  
          </td>
    
          <td>
            <p id="p_totalDeliveryPrice">
            <fmt:formatNumber  value="${totalDeliveryPrice}" var="tDeliveryPrice" pattern="#,###"/> 
            ${tDeliveryPrice}원  </p>
            <input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
          </td>
      --> 
          <td> 
            <img width="25" alt="" src="${contextPath}/resources/image/minus.jpg"> 
          </td>
<!--총 할인금액 -->  
          <td>  
            <p id="p_totalSalesPrice"> 
            <fmt:formatNumber value="${totalDiscount}" var="fmttotalDiscount" type="number" pattern="#,###"/>
                     ${fmttotalDiscount}원
            </p>
            <input id="h_totalSalesPrice"type="hidden" value="${totalDiscount}" />
          </td>
          <td>  
            <img width="25" alt="" src="${contextPath}/resources/image/equal.jpg">
          </td>
          <td>
<!-- 할인 후 최종금액-->
  		<!--총판매가 - 총할인금액 -->
             <p id="p_final_totalPrice">
             <fmt:formatNumber  value="${totalGoodsPrice-totalDiscount}" type="number" var="fmttotalSalesPrice" pattern="#,###"/>
               ${fmttotalSalesPrice}원
         <!--   할인 후 금액 
               <fmt:formatNumber  value="${totalDiscountedPrice+totalDeliveryPrice}" type="number" var="total_price2" />
               ${total_price2}원
           --> 
             </p>
             <input id="h_final_totalPrice" type="hidden" value="${totalGoodsPrice-totalDiscount}" />
        
       	</td>   
      </tr>
      </tbody>
   </table>
   <center>
    <br><br>   
       <a href="javascript:fn_order_all_cart_goods()">
          <img width="75" alt="" src="${contextPath}/resources/image/btn_order_final.jpg">
       </a>
       <a href="#">
          <img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
       </a>
   <center>

</form> <!-- 위치 다시 볼것 -->

 
