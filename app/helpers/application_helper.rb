module ApplicationHelper
  def inclination(count, one, few, many)
    return many if (count % 100).between?(11, 14)

    case count % 10
    when 1 then one
    when 2..4 then few
    else many
    end
  end

  def user_avatar(user)
    asset_path("avatar-128.png")
  end
end
