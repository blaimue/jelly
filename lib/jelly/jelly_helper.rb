module JellyHelper

  def page_specific_javascript_files(jelly_files_path_from_javascripts = '', rails_root = RAILS_ROOT)
    Dir["#{rails_root}/public/javascripts/#{jelly_files_path_from_javascripts}/pages/**/*.js"].map do |path|
      path.gsub("#{rails_root}/public/javascripts/", "").gsub(/\.js$/, "")
    end
  end

  def init_specific_javascript
    javascript_tag <<-JS
      window._token = '#{form_authenticity_token}'
      Jelly.activatePage('#{controller.controller_path.camelcase}', '#{controller.action_name}');
      #{@content_for_javascript}
    JS
  end

  def attach_javascript_component(component_name, *args)
    content_for(:javascript, "page.attach(#{component_name}, #{args.to_json});")
  end

end