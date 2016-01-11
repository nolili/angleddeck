require 'test_helper'

class Api::BuildsTest < ActionDispatch::IntegrationTest
  include JSONTestHelper

  setup do
    @project = Project.create!(name: "Super Project")
  end

  attr_reader :project

  test "add new build and create topic" do
    json = {
      topic_url: "https://github.com/soutaro/test-project/pull/1",
      build: {
        url: "https://cdn.example.com/builds/build.ipa",
        name: "Sample Build",
        bundle_identifier: "com.soutaro.test-project",
        bundle_version: "1.0.0"
      }
    }

    post_json("/api/projects/#{project.guid}/builds", object: json)

    assert_response :ok

    topic = project.topics.where(url: "https://github.com/soutaro/test-project/pull/1").first
    assert_not_nil topic, "New topic is created"

    build = topic.builds.last
    assert_not_nil build, "build is added"
    assert_equal "https://cdn.example.com/builds/build.ipa", build.url
    assert_equal "Sample Build", build.name
    assert_equal "com.soutaro.test-project", build.bundle_identifier
    assert_equal "1.0.0", build.bundle_version
  end

  test "add new build to existing topic" do
    project.topics.create!(url: "https://github.com/soutaro/test-project/pull/1", name: "Test topic")

    json = {
      topic_url: "https://github.com/soutaro/test-project/pull/1",
      build: {
        url: "https://cdn.example.com/builds/build.ipa",
        name: "Sample Build",
        bundle_identifier: "com.soutaro.test-project",
        bundle_version: "1.0.0"
      }
    }

    post_json("/api/projects/#{project.guid}/builds", object: json)

    assert_response :ok

    topics = project.topics.where(url: "https://github.com/soutaro/test-project/pull/1")
    assert_equal 1, topics.count, "New topic should not be created"

    build = topics.first.builds.last
    assert_not_nil build, "build is added"
    assert_equal "https://cdn.example.com/builds/build.ipa", build.url
    assert_equal "Sample Build", build.name
    assert_equal "com.soutaro.test-project", build.bundle_identifier
    assert_equal "1.0.0", build.bundle_version
  end
end
