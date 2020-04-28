module IconsHelper
  def feather(icon, text = '', position = 'left')
    if position == 'left'
      "<i data-feather=#{icon}></i> <p class=icon-text>#{text}</p>".html_safe
    else
      "<p class=icon-text>#{text}</p> <i data-feather=#{icon}></i>".html_safe
    end
  end
end
