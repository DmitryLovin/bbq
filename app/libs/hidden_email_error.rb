class HiddenEmailError < StandardError
  def initialize(provider)
    @provider = provider
  end

  def message
    I18n.t("oauth.hidden_email", provider: @provider)
  end
end
