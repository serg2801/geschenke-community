ActiveAdmin.register_page "Helden" do

  controller do
    def index
      @hero1 = Herodata.where(name: 'img1').first
      @hero2 = Herodata.where(name: 'img2').first
      @hero3 = Herodata.where(name: 'img3').first
      @herotext1 = Herodata.where(name: 'text1').first
      @herotext2 = Herodata.where(name: 'text2').first
    end
  end

  menu :label => "Helden"

  content :title => "Helden" do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      form_tag("/heroes/add", :method => "post") do |f|
        text_field_tag :hero_name
        text_area_tag :post, :description
        submit_tag("Add Hero", :class => "btn")
      end
      span "This is some_var: #{@arbre_context.assigns[:hero1].name}"
    end

  end # content
end
