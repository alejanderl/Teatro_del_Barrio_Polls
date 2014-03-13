# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
    #remove buttons. 
    $(".action-buttons").toggle()



class TdB.Taxonomies_Terms

    constructor: (@taxonomy) ->
        @main = "taxonomy-terms-" + @taxonomy
        @initialize_events ->       
        

    initialize_events: ->
        $("div.dialog" ).dialog
            autoOpen: false
            show: 
             effect: "fade"
             duration: 1000
        $(".deploy-button").hide()
        $("li.parent-0 ul").hide()
        $("li.parent-0 ul ul").show()
        $("li.parent-0 ul").prev().prev().show()
        $(".colorbox").colorbox
            height: "80%"
        $( ".open-dialog" ).click ->          
            term = $(this).attr("data-taxonomy")
            $("div.dialog" ).dialog("close")
            $("div.dialog-"+term ).dialog("open")
            if  !$(this).parent().next().hasClass("in")

                $(this).next().click() 
        all_dialogs = $(".dialog")
        for d, i in all_dialogs
            this.check_terms($(d).attr("data-taxonomy"))
        $(".deploy-button").bind 'click', ->               
            button = $(this)
            $(this).next().next().toggle "fast", ->
                if $(this).is(":hidden")
                    button.addClass("glyphicon-chevron-right")
                    button.removeClass("glyphicon-chevron-down")
                else
                    button.removeClass("glyphicon-chevron-right")
                    button.addClass("glyphicon-chevron-down")
        this.assign_events()
                    
    assign_events: ->
        $(".add-term").off ""
        $(".remove-term").off
        $(".remove-term").on "click", ->
            taxonomies.remove_term(this)
        $(".add-term").on "click", ->
            $(this).unbind
            taxonomies.add_term(this)            
        
        $("span[id^=term]").bind 'mouseover', ->
            if $(this).children(".actions-active").length == 0
                $(".actions-active").toggle();
                $(".actions-active").removeClass("actions-active")
                $(this).children("div.action-buttons").addClass "actions-active"
                $(this).children("div.action-buttons").toggle("fast")
                
        $(".add-term").bind "mouseover" ,->
            $(this).children().removeClass("hidden")
            $(this).parent().addClass("add-over")
    
         $(document).on "mouseout" , ".add-term",->
            $(this).children().addClass("hidden")
            $(this).parent().removeClass("add-over")
              
         $(".remove-term").bind "mouseover",->
            #$(this).children().removeClass("hidden")
            $(this).parent().addClass("delete-over")
              
         $(".remove-term").bind "mouseout",->

            $(this).children().addClass("hidden")
            $(this).parent().removeClass("delete-over")
    

                    


              
        
            
            
    remove_term:(_that) ->
        added_taxonomy_name = $(_that).parent().attr("data-name")
        remove_id = $(_that).parent().attr("data-id")
        
        value = $("#terms-id_"+added_taxonomy_name).val().split(",")
        value = value
        value[value.indexOf(remove_id) + ""] = ""
        $("#terms-id_"+added_taxonomy_name).val(value.toString())
        $(_that).parent().fadeOut 500, ->
            $(this).remove()
        this.check_terms added_taxonomy_name
            
            
    add_term:(_that) ->
            added = $(_that).parent()
            added_id = $(_that).parent().attr("data-id")

            added_taxonomy_name = $(_that).parent().attr("data-name")
           
            $(_that).children().addClass("hidden")
            $(_that).parent().removeClass("add-over")
            $(_that).removeClass("add-term")
            the_cloned = added.clone()                
            the_cloned.children(" a").addClass("remove-term")
            the_cloned.children("a").children("span").addClass(" glyphicon-minus-sign")
            the_cloned.children("a").children("span").removeClass(" glyphicon-plus-sign")
            $("#terms-names-"+added_taxonomy_name+" ul div.clearfix").prepend(the_cloned)
            $(_that).removeClass("add-term")
            value = $("#terms-id_"+added_taxonomy_name).val() + "," + added_id
            $("#terms-id_"+added_taxonomy_name).val(value)

            this.check_terms(added_taxonomy_name)

              
    check_terms: (family) -> 
        
        active_terms = $("#terms-id_" +  family).val().split(",")
        current_list = $(".dialog-" + family + " ul li")
        this.assign_events ->
        for d, i in current_list
            id = $(d).attr("data-id")#                
            if $.inArray(id , active_terms) > 0
                $(d).addClass("inactive")
            else
                $(d).removeClass("inactive")
                
                
                
                


 
      
        