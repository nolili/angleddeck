module TopicsHelper
  def topic_name(topic)
    topic.name || I18n.t('models.topic.default_name')
  end
end
