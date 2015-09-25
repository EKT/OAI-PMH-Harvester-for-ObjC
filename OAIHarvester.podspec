#
#  Be sure to run `pod spec lint OAIHarvester.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "OAIHarvester"
  s.version      = "0.0.1"
  s.summary      = "AI-PMH Objective-C harvester is an Objective C library/wrapper over the OAI-PMH protocol."

  s.description  = <<-DESC
                   OAI-PMH Objective-C harvester is an Objective C library/wrapper over the OAI-PMH protocol. The Open Archives Initiative Protocol for Metadata Harvesting (OAI-PMH) is a low-barrier mechanism for repository interoperability. Data Providers are repositories that expose structured metadata via OAI-PMH. Service Providers or metadata harvesters (like this one) then make OAI-PMH service requests to harvest that metadata. OAI-PMH is a set of six verbs or services that are invoked within HTTP.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/EKT/OAI-PMH-Harvester-for-ObjC"

  s.license      = "Creative Commons Attribution-ShareAlike 3.0 Unported License"

  s.author             = { "Kostas Stamatis" => "kstamatis@ekt.gr" }

  s.source       = { :git => "https://github.com/EKT/OAI-PMH-Harvester-for-ObjC.git", :tag => "0.0.1" }

  s.source_files  = "OAIHarvester", "OAIHarvester/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.library = 'xml2'
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "TouchXML"

  s.platform     = :ios, '7.0'

end
