module ApplicationHelper

  def get_avatar(avatar)
    if !avatar.nil?
      image_tag("images/avatars/#{avatar}")
    else
      image_tag("images/avatars/blank_avatar.png")
    end
  end

end
