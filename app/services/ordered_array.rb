# This class order an array with parents -> childs and adds family depth with order method
class OrderedArray  
    
  def initialize(one_list)
    @the_list ||= []      
    one_list.each {|x| @the_list << x }
   @the_list.sort_by! {|x| x[:parent_id]}
    @other_list ||= []
    @final_list ||= []
  end
  
  def order
     print_and_check(@the_list)
     set_family_depth @final_list 
     @final_list
  end
  
  private
  
  def print_and_check(list)
     list.each do |element|     
     @final_list << element
      if check_sons(@the_list,element.id)
        sublist = @the_list.select{|x| x[:parent_id ]== element.id}
        print_and_check(sublist)
        @the_list.reject! {|x| x[:parent_id]==element.id}         
      end
    end
  end

  def check_sons(list,id)
    list.select {|x| x[:parent_id]==id}.length >0
  end
  
  def set_family_depth(list)
    depth = 0
    previous = list.first
    parent_array = [0]
    list.each do |term|      
      parent_array << term.parent_id if previous.id == term.parent_id
      if  term.parent_id !=  previous.id && previous.parent_id != term.parent_id && term.parent_id == 0
        index_of = parent_array.index term.parent_id
        parent_array = parent_array[0..index_of]
      end

      term.depth = parent_array.index term.parent_id
      previous = term
    end   
  end

end