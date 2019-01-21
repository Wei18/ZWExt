#
# Be sure to run `pod lib lint ZWExt.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZWExt'
  s.version          = '0.0.2'
  s.summary          = 'A short description of ZWExt.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wei18/ZWExt'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wei18' => '41205mw@gmail.com' }
  s.source           = { :git => 'https://github.com/wei18/ZWExt.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.source_files = 'ZWExt/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZWExt' => ['ZWExt/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit', 'CoreLocation'
  s.dependency 'RxSwift', '~> 4.2'
  s.dependency 'RxCocoa', '~> 4.0'
end
