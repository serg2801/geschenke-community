ActiveAdmin.register_page "Helden" do

  controller do
    def index
      params[:hero1] = Herodata.where(name: 'img1').first
      if params[:hero2].present?
        params[:hero2].value = params[:hero2]
      else
        params[:hero2] = Herodata.where(name: 'img2').first.value
      end
      params[:hero3] = Herodata.where(name: 'img3').first
      params[:herotext1] = Herodata.where(name: 'text1').first
      params[:herotext2] = Herodata.where(name: 'text2').first
    end

    def post
      hero1 = Herodata.where(name: 'img1').first
      hero1.value = params[:hero1]
      hero1.save
    end
  end

  menu :label => "Helden"

  content :title => "Helden" do
    div do
      render :partial => 'form'
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
