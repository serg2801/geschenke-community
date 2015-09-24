ActiveAdmin.register_page "Helden" do

  controller do
    def index
      if params[:hero1].present?
         hero1 = Herodata.where(name: 'img1').first
         hero1.value = params[:hero1]
         hero1.save
      else
         params[:hero1] = Herodata.where(name: 'img1').first.value
      end
      if params[:hero2].present?
         hero2 = Herodata.where(name: 'img2').first
         hero2.value = params[:hero2]
         hero2.save
         params[:hero2] = params[:hero2]
      else
        params[:hero2] = Herodata.where(name: 'img2').first.value
      end
      if params[:hero3].present?
         hero3 = Herodata.where(name: 'img3').first
         hero3.value = params[:hero3]
         hero3.save
      else
         params[:hero3] = Herodata.where(name: 'img3').first.value
      end
      if params[:herotext1].present?
         hero1 = Herodata.where(name: 'text1').first
         hero1.value = params[:herotext1]
         hero1.save
      else
         params[:herotext1] = Herodata.where(name: 'text1').first.value
      end
      if params[:herotext2].present?
         herotext2 = Herodata.where(name: 'text2').first
         herotext2.value = params[:herotext2]
         herotext2.save
      else
         params[:herotext2] = Herodata.where(name: 'text2').first.value
      end
    end

  end

  menu :label => "Helden"

  content :title => "Helden" do
    div do
      render :partial => 'form'
    end
  end # content

end
