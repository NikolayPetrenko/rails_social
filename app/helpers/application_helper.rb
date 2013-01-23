module ApplicationHelper

  def get_avatar(avatar)
    if !avatar.nil?
      image_tag("images/avatars/#{avatar}")
    else
      image_tag("images/avatars/blank_avatar.png")
    end
  end

  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
