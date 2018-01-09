<%@ page contentType="text/html; charset=utf-8" %>

	<div class="sidebar" >
		<table class="sidebar" align="center">
			<tr>
				<!--  -->
				<td>
					<a href="/semiP/search.action">
						<img src="/semiP/assets/images/icons/search.png" onmouseover="this.src='/semiP/assets/images/icons/search_on.png'" onmouseout="this.src='/semiP/assets/images/icons/search.png'"><br>
					</a>
					<font size="1">SEARCH</font>
				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<!-- 로그인 상태봐서  logout  아이콘으로 변경해줄 것 -->
				<td>
					<s:if test="session.session_member_id != null">	
						<a href="/semiP/logout.action">
							<img src="/semiP/assets/images/icons/logout.png" onmouseover="this.src='/semiP/assets/images/icons/logout_on.png'" onmouseout="this.src='/semiP/assets/images/icons/logout.png'"><br>
						</a>
						<font size="1">LOGOUT</font>
					</s:if>
					<s:else>
						<a href="/semiP/loginac.action">
							<img src="/semiP/assets/images/icons/login.png" onmouseover="this.src='/semiP/assets/images/icons/login_on.png'" onmouseout="this.src='/semiP/assets/images/icons/login.png'"><br>
						</a>
						<font size="1">LOGIN</font>
					</s:else>

				</td>
			</tr>
			<tr>
				<!--  -->
				<td>
					<a href="/semiP/myPage.action">
						<img src="/semiP/assets/images/icons/mypage.png" onmouseover="this.src='/semiP/assets/images/icons/mypage_on.png'" onmouseout="this.src='/semiP/assets/images/icons/mypage.png'"><br>
					</a>
					<font size="1">MY PAGE</font>
				</td>
			</tr>
			<tr>
				<!--  -->
				<td>
					<a href="/semiP/basket.action">
						<img src="/semiP/assets/images/icons/cart.png" onmouseover="this.src='/semiP/assets/images/icons/cart_on.png'" onmouseout="this.src='/semiP/assets/images/icons/cart.png'"><br>
					</a>
					<font size="1">CART</font>
				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<!--  -->
				<td>
					<a href="/semiP/support.action">
						<img src="/semiP/assets/images/icons/support.png" onmouseover="this.src='/semiP/assets/images/icons/support_on.png'" onmouseout="this.src='/semiP/assets/images/icons/support.png'"><br>
					</a>
					<font size="1">SUPPORT</font>
				</td>
			</tr>
		</table>
	</div>