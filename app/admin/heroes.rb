ActiveAdmin.register_page "Helden" do

  menu :label => "Helden"

  content :title => "Helden" do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      form_tag("/heroes/add", :method => "post") do
        text_field_tag(:heroe_name)
        submit_tag("Add Heroe", :class => "btn ")
      end
    end

    div do
       ActiveRecord::Base.connection.tables.each do |table|
          next if table.match(/\Aschema_migrations\Z/)
          klass = table.singularize.camelize.constantize      
          puts "#{klass.name} has #{klass.count} records"
       end
    end

  end # content
end
