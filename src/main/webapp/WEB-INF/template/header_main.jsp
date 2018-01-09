<%@ page contentType="text/html; charset=utf-8"%>


<script defer
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="/semiP/assets/js/menuscroll.js"></script>
<div id="blog-header-container">
		<article align="center" style="font-size:0.8em;">로그인 아이디: ${session.session_member_id }</article>
	<h1>MIGNON COPINE</h1><br>

</div>
<div id="menu-container">
	<div class="menu-icon" style="display: none;"><a href="main.action" style="color:#FFFFFF; text-decoration:none;">MC</a></div>
	<div class="menu-item">
		<a href="goodsListAction.action?category=1" style="color:#FFFFFF; text-decoration:none;">
		OUTER</a>
		&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="goodsListAction.action?category=2" style="color:#FFFFFF; text-decoration:none;">
		TOP</a>
		&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="goodsListAction.action?category=3" style="color:#FFFFFF; text-decoration:none;">
		PANTS</a>
		&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="goodsListAction.action?category=4" style="color:#FFFFFF; text-decoration:none;">
		SKIRT</a>
		&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="goodsListAction.action?category=5" style="color:#FFFFFF; text-decoration:none;">
		DRESS</a>
		&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="goodsListAction.action?category=6" style="color:#FFFFFF; text-decoration:none;">
		SHOES</a>
		&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="goodsListAction.action?category=7" style="color:#FFFFFF; text-decoration:none;">
		BAGS</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
</div>