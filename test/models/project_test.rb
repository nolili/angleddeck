require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "project" do
    project = Project.new(name: "Super Project")

    project.save!

    refute_empty project.guid, "New project should have guid"
    refute project.topics.blank?, "New project should have at least one topic"
    refute_nil project.topics.master.present?, "The default topic should be named master"
  end
end
