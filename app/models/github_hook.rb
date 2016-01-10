class GithubHook
  attr_reader :project, :request

  def initialize(project:, request:)
    @project = project
    @request = request
  end

  def event_type
    request.env["HTTP_X_GITHUB_EVENT"].to_sym
  end

  def body
    @body ||= JSON.parse(request.raw_post, symbolize_names: true)
  end

  def repository_name
    body[:pull_request][:repository][:full_name]
  end

  def number
    body[:number]
  end

  def request_url
    @request_url ||= URI.parse(request.url)
  end

  def run!
    case event_type
    when :pull_request
      make_topic_from_request do |new_topic|
        notify_topic_created(new_topic) if project.has_github_access?
      end
    end
  end

  def make_topic_from_request
    url = body[:pull_request][:html_url]
    name = body[:pull_request][:title]

    topic = project.topics.find_or_initialize_by(url: url)
    topic.name = name

    topic_inserted = topic.new_record?

    topic.save!

    yield(topic) if topic_inserted && block_given?
  end

  def notify_topic_created(topic)
    topic_url = Rails.application.routes.url_helpers.project_topic_url(project.guid, topic.id, host: request_url.host, port: request_url.port, protocol: request_url.scheme)
    client.add_comment(repository_name, number, <<COMMENT)
Over-the-air installation will be available from #{topic_url}.
COMMENT
  end

  def client
    if project.has_github_access?
      @client ||= Octokit::Client.new(access_token: project.gh_access_token)
    end
  end
end
