module ApplicationHelper
  def inclination(count, one, few, many)
    return many if (count % 100).between?(11, 14)

    case count % 10
    when 1 then one
    when 2..4 then few
    else many
    end
  end

  def env_upload_method
    if Rails.env.production?
      :put
    else
      :post
    end
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path("events.png")
    end
  end

  def event_photo_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path("events_thumb.png")
    end
  end

  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path("avatar-128.png")
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_path("avatar-128.png")
    end
  end
end
