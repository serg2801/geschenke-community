ActiveAdmin.register Product do
  config.batch_actions = true

  # batch_action :delete do |selection|
  #   Category.find(selection).each do |category|
  #     category.destroy
  #   end
  # end
  
  index do
    selectable_column
    column :name
    column :slug
    default_actions
  end

end
