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
      form_tag("/heroes/add", :method => "post") do |f|
        text_field_tag :hero_name
        text_area_tag :post, :description
        submit_tag("Add Hero", :class => "btn")
      end
    end
    form do |f|
      inputs 'Held 1' do
        input :value, :input_html => { :value => params[:hero1].name }
      end
      inputs 'Held 2' do
        input :value, :input_html => { :value => params[:hero2].name }
      end
      inputs 'Held 3' do
        input :value, :input_html => { :value => params[:hero3].name }
      end
    end
  end # content
end
