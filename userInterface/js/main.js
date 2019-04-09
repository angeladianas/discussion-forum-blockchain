
$(document).ready(function(){
    $('.header').height($(window).height());
   })

$(".navbar a").click(function(){
$("body,html").animate({
    scrollTop:$("#" + $(this).data('value')).offset().top
},1000)
})

var web3js = new Web3(new Web3.providers.HttpProvider("https://rinkeby.infura.io/v3/287018d520ee42b8adfbb97ca4daa62b"));
web3js.eth.getTransaction("0xaf7bfec2f84b35a58e93ebdf688ba079721b2ac064d7adff520100352206472d", function(res){
    console.log(res)
})
