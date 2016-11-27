$('document').ready(function(){
	$('#reg_button').on('click', function(event){
		$('#reg_button').addClass('hidden');
		$('.waiting').removeClass('hidden');
	})
})