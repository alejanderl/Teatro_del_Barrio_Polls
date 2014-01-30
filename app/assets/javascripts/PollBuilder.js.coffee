


#setup the name space
window.TdB = window.TdBTdB || {}

class TdB.PollBuilder
   
    constructor:(init_form_values) ->
        @init_form_values = init_form_values
        @button_add = $("#add_question")
        @questions_field = $('#questions')
        @question_counter = 1
        _this = this
        this.set_bind =>

    set_bind:->
    	$("body").on "click", @button_add, =>
    		console.log _this.questions_field
    		attributes = {}
    		_this.questions_field.prepend Mustache.to_html($('#poll_question').html(), attributes)