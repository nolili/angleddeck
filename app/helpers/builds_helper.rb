module BuildsHelper
  def install_plist_url(build)
    params = {
      action: "download-manifest",
      url: project_topic_build_plist_url(build.topic.project.guid, build.topic.id, build.id)
    }
    "itms-services://?#{params.to_query}"
  end
end
