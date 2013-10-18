module ApplicationHelper
  def nice_date(date)
      h date.strftime("%d/%m/%Y")
  end
  def male_or_female(gender)
      if gender == 0
          "Male"
      else
          "Female"
      end
  end    
  
  def country_selector(number)
    select("client", "country_id", 
    Country.all.collect {|c| [ c.printable_name, c.id ]}, 
    { :include_blank => false, :selected => number})
  end
  
  def category_selector(serviceid, servicename)
    select( "#{servicename}", :id, 
    Category.find(:all, :conditions => "service_id = #{serviceid}", :order => "name").collect {|c| [ c.name, c.id]}, 
    { :include_blank => false})
  end

  def category_selector2
"<select id='YPHS_id' name='YPHS[id]'>"
  for category in @categories
"<option value='#{category.id}'>#{category.name}</option>"
  end
"</select>"
  end
  
  def age_at(date, dob)
  date.year - dob.year - ( date.month-dob.month < 0 ? 1 : date.day-dob.day < 0 ? 1:0 )
  end

  def age(now, birthdate)
    had_birthday_passed_this_year = (now.month * 100 + now.day >= birthdate.month * 100 + birthdate.day)
     if had_birthday_passed_this_year
       now.year - birthdate.year
     else
       now.year - birthdate.year - 1
     end
  end
  
  def time_diff_in_minutes (time_then, time_now)
    diff_seconds = (time_now - time_then).round
    diff_minutes = diff_seconds / 60
    return diff_minutes
  end
  
  def in_service?(user_service_id_in_question)
    @_list ||= client.services.collect(&:id)
    # return true if @_list.include?("admin") #This is the culprit.
    (@_list.include?(user_service_id_in_question.to_s) )
  end
end
