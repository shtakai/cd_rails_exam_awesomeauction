Sidekiq.configure_server do |config|
  case Rails.env
    when 'production' then
      config.redis = { url: SIDEKIQ_URL, namespace: SIDEKIQ_NAMESPACE}
    when 'staging' then
      config.redis = { url: SIDEKIQ_URL, namespace: SIDEKIQ_NAMESPACE}
    else
      config.redis = { url: SIDEKIQ_URL, namespace: SIDEKIQ_NAMESPACE}
  end
end

Sidekiq.configure_client do |config|
  case Rails.env
    when 'production' then
      config.redis = { url: SIDEKIQ_URL, namespace: SIDEKIQ_NAMESPACE}
    when 'staging' then
      config.redis = { url: SIDEKIQ_URL, namespace: SIDEKIQ_NAMESPACE}
    else
      config.redis = { url: SIDEKIQ_URL, namespace: SIDEKIQ_NAMESPACE}
  end
end
