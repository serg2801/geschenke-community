ActiveAdmin.register_page "Helden" do

  controller do
    def index
      params[:hero1] = Herodata.where(name: 'img1').first
      params[:hero2] = Herodata.where(name: 'img2').first
      params[:hero3] = Herodata.where(name: 'img3').first
      params[:herotext1] = Herodata.where(name: 'text1').first
      params[:herotext2] = Herodata.where(name: 'text2').first
    end
  end

  menu :label => "Helden"

  content :title => "Helden" do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      form_tag("/heroes", :method => "post") do |f|
        f.input :name => 'hero1_name', :type => 'text', :value => params[:hero1].name
        f.input :name => 'hero2_name', :type => 'text', :value => params[:hero2].name
        f.input :name => 'hero3_name', :type => 'text', :value => params[:hero3].name
        text_area_tag :herotext1, params[:herotext1].value
        text_area_tag :herotext2, params[:herotext2].value
        submit_tag("Add Hero", :class => "btn")
      end
    end
  end # content
end
