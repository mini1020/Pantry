module AjaxHelper
  def ajax_reload
    { js: "location.reload();" }
  end
end