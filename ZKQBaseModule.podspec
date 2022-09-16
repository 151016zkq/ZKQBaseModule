#
# Be sure to run `pod lib lint ZKQBaseModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZKQBaseModule'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZKQBaseModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/151016zkq/ZKQBaseModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '151016zkq' => '1510166838@qq.com' }
  s.source           = { :git => 'https://github.com/151016zkq/ZKQBaseModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'


  s.ios.deployment_target = '9.0'
  s.requires_arc         = true
  s.static_framework     = true
  s.swift_version = '5.0'
  s.xcconfig = {
    'USER_HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/Headers/Public"/**'
  }
  s.default_subspec = 'core'
  s.subspec 'core' do |c|
    c.source_files = 'ZKQBaseModule/Classes/**/*'
    
#    c.resource =  ['ZKQBaseModule/Resources/*.*']
#    c.vendored_frameworks = 'ZKQBaseModule/Lib/*.framework'
#    c.vendored_libraries = 'ZKQBaseModule/Lib/*.*'
    c.pod_target_xcconfig  = {
      'ENABLE_BITCODE' => 'NO',
      'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
      'GCC_PREPROCESSOR_DEFINITIONS' => 'SD_WEBP=1 MAS_SHORTHAND=1 MAS_SHORTHAND_GLOBALS=1',
      'OTHER_SWIFT_FLAGS' => '$(inherited) -D COCOAPODS -enable-bridging-pch'
    }
    c.public_header_files = 'Pod/Classes/**/*.h'
    #  base模块pch文件
    c.prefix_header_contents = '#import "Defines.h"',
    '#import "ColorMacros.h"'
    
    
    c.dependency 'KakaJSON', '~> 1.1.2'
    c.dependency 'Alamofire','~> 4.9.1'
    c.dependency 'IQKeyboardManager'
    c.dependency 'MJRefresh', '~> 3.7.5'
    c.dependency 'CTMediator'
    c.dependency 'MJExtension', '3.0.13'


  end
  

  # s.resource_bundles = {
  #   'ZKQBaseModule' => ['ZKQBaseModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
