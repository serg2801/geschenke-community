ActiveAdmin.register_page "Helden" do

  menu :label => "Helden"

  content :title => "Helden" do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      form_tag("/heroes/add", :method => "post") do |f|
        text_field_tag :hero_name
        text_area_tag :post, :description
        submit_tag("Add Hero", :class => "btn")
      end
    end

  end # content
end
