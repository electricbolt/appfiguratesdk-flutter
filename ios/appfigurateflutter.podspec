#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint appfigurateflutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'appfigurateflutter'
  s.version          = '3.1.0'
  s.module_name      = 'AppfigurateFlutter'
  s.summary          = 'Appfigurate SDK flutter plugin'
  s.description      = <<-DESC
Appfigurate SDK flutter plugin
                       DESC
  s.homepage         = 'https://github.com/electricbolt/appfiguratesdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Electric Bolt Limited' => 'support@electricbolt.co.nz' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/AppfigurateFlutterPlugin.m'
  s.public_header_files = 'Classes/AppfigurateFlutterPlugin.h'
  s.dependency 'Flutter'
  s.vendored_frameworks = 'AppfigurateLibrary.xcframework'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
