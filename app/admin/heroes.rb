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
    div do
      render :partial => 'form'
      #para(params[:hero1].name)
      #form_tag("/admin/helden", :method => "post") do
      #  text_field_tag('hero1_name', params[:hero1].name)
      #  text_field_tag('hero2_name', params[:hero2].name)
      #  text_field_tag('hero3_name', params[:hero3].name)
      #  text_area_tag('herotext1', params[:herotext1].value)
      #  text_area_tag('herotext2', params[:herotext2].value)
      #  submit_tag("Speichern", :class => "btn")
      #end
    end
  end # content

  #page_action :update, method: :post do
  ## ...
  #  redirect_to 'admin/helden', notice: "Your event was added"
  #end

  #action_item :update do
  #  link_to "Update", admin_helden_update_path, method: :post
  #end

end
