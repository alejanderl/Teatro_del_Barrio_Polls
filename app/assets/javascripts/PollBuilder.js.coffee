


#setup the name space
window.TdB = window.TdBTdB || {}

class TdB.PollBuilder
   
    constructor:(init_form_values) ->
        @init_form_values  = init_form_values
        @button_add        = $("#add_question")
        @questions_field   = $('#questions')
        @question_counter  = 1
        _this = this
        this.set_bind =>

    set_bind:=>

    	$( @button_add ).on "click", =>
    		
    		attributes = {}
    		attributes["random"] = Math.floor(Math.random()*12213413)
    		_this.questions_field.append Mustache.to_html($('#poll_question').html(), attributes)
    	$(".remove_old_question").on "click" , -> 	
    		$(".destroy",$(this).parents(".input-group")).val 1
    		$(this).parents("li.old_question").toggle "1000" , ->

    	$(document).on "click", ".remove_new_question" , ->
    		$(this).parents("li.new_question").toggle "1000" , ->
    			$(this).remove()

    		