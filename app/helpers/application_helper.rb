module ApplicationHelper

  # ページごとにタイトルを返す
   def full_title(page_name = "")
    base_title = "Panty"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end

  def bootstrap_alert(key)
    case key
    when "alert"
      "danger"
    when "notice"
      "success"
    when "error"
      "danger"
    when "success"
      "success"
    when "danger"
      "danger"
    end
  end
end
