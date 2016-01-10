xml.instruct!
xml.plist :version => "1.0" do
  xml.dict do
    xml.key "items"
    xml.array do
      xml.dict do
        xml.key "assets"
        xml.array do
          xml.dict do
            xml.key "kind"
            xml.string "software-package"
            xml.key "url"
            xml.string @build.url
          end
        end
        xml.key "metadata"
        xml.dict do
          xml.key "bundle-identifier"
          xml.string @build.bundle_identifier
          xml.key "bundle-version"
          xml.string @build.bundle_version
          xml.key "kind"
          xml.string "software"
          xml.key "title"
          xml.string @build.topic.project.name
        end
      end
    end
  end
end
