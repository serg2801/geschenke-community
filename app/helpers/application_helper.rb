# encoding: utf-8

module ApplicationHelper

  def price(p)
    return number_to_currency(p, :unit => "€", :separator => ",", :delimiter => ".", :format => "%n%u")
  end

  def criteria_checkbox(model, name, object, label=nil)
    checkbox = check_box_tag "#{model}[criteria][#{name}]", "1", instance_variable_set("@#{model}", object).criteria["#{name}".to_sym] == "1" ? true : false
    label = label_tag "#{model}[criteria][#{name}]", "#{label || name.capitalize}"
    return checkbox + "\n" + label
  end

  def option_helper(field, label, value, selected=false)
    return "<option value='#{value}' #{'selected' if params[:"#{field}"] == value || selected}>#{label}</option>".html_safe
  end
  
end
