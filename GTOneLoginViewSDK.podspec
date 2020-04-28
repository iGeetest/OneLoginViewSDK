#
# Be sure to run `pod lib lint OneLoginSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = 'GTOneLoginViewSDK'
  s.version = '0.9.0' 
  s.summary = '极验一键登录SDK'
  s.homepage = 'https://www.geetest.com'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Geetest' => 'liulian@geetest.com' }
  s.source = { :git => 'https://github.com/iGeetest/OneLoginViewSDK.git', :tag => s.version.to_s } 
  s.ios.deployment_target = '8.0'

  s.vendored_frameworks = 'SDK/OneLoginViewSDK.framework'
  s.resources = 'SDK/OneLoginViewResource.bundle', 'README.md'

  s.dependency 'GTOneLoginSDK'

end
