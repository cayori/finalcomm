
var count = document.getElementById("count").value;

var m_btn = document.getElementById('m_btn');
m_btn.addEventListener('click', function(){
	if(count > 0) 	{count--;}
	else				{count=0;}
	document.getElementById("count").value = count;
	console.log(count);
})

var p_btn = document.getElementById('p_btn');
p_btn.addEventListener('click', function(){
	if(count < 100) 	{count++;}
	else				{count=0;}
	document.getElementById("count").value = count;
	console.log(count);
})