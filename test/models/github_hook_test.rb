require "test_helper"

class GithubHookTest < ActiveSupport::TestCase
  setup do
    @project = Project.create!(name: "Test Project", gh_access_token: "test-token")
  end

  test "new pull request hook creates new topic" do
    request = pullrequest_hook_request(url: "https://github.com/soutaro/test-project/pull/123", title: "Add super feature")

    hook = GithubHook.new(project: @project, request: request)
    mock(hook.client).add_comment("soutaro/test-project", 123, /https:\/\/test.host:3001\/projects\/#{@project.guid}\/topics/) # post comment to the PR
    hook.run!

    topic = @project.topics.where(url: "https://github.com/soutaro/test-project/pull/123").first

    assert_not_nil topic, "It creates new topic"
    assert_equal "Add super feature", topic.name, "it saves name of pull request"
  end

  test "pull request update hook updates topic name" do
    @project.topics.create!(url: "https://github.com/soutaro/test-project/pull/123", name: "Old title")

    request = pullrequest_hook_request(url: "https://github.com/soutaro/test-project/pull/123", title: "New title")

    hook = GithubHook.new(project: @project, request: request)
    dont_allow(hook.client).add_comment # Updating topic should not comment the PR
    hook.run!

    topic = @project.topics.where(url: "https://github.com/soutaro/test-project/pull/123").first
    assert_equal "New title", topic.name, "it updates name of pull request"
  end

  test "other hooks are ignored" do
    request = github_hook_request(type: "commit_comment", body: {})

    hook = GithubHook.new(project: @project, request: request)
    hook.run!

    assert_empty @project.topics.where(url: "https://github.com/soutaro/test-project/pull/123")
  end

  private

  def github_hook_request(type:, body:)
    Object.new.tap do |request|
      request.define_singleton_method :env do
        {
          "HTTP_X_GITHUB_EVENT" => type,
        }
      end

      request.define_singleton_method :raw_post do
        body.to_json
      end

      project = @project
      request.define_singleton_method :url do
        "https://test.host:3001/projects/#{project.guid}/hooks/github"
      end
    end
  end

  def pullrequest_hook_request(url:, title:)
    github_hook_request(type: "pull_request",
                        body: {
                          action: "opened",
                          number: 123,
                          pull_request: {
                            html_url: url,
                            title: title,
                            repository: {
                              full_name: "soutaro/test-project"
                            }
                          }
                        })
  end
end
