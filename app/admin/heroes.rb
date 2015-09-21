ActiveAdmin.register_page "Helden" do

  menu :priority => 1, :label => "Helden"

  content :title => Helden do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

  end # content
end
