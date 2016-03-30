ActiveAdmin.register CoocieModule do
  config.batch_actions = true

  index do
    selectable_column
    column :body
    default_actions
  end

  form :partial => "form"

end
