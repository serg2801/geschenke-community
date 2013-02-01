ActiveAdmin.register LegacyLink do
  config.batch_actions = true

  index do
    selectable_column
    column :name
    column :slug
    column :new_url
    default_actions
  end

end
