#
# `pod cache clean --all`
# `pod lib lint appfigurateflutter.podspec`
#

Pod::Spec.new do |s|
  s.name                = 'appfigurateflutter'
  s.version             = '4.0.2'
  s.module_name         = 'AppfigurateFlutter'
  s.summary             = 'Appfigurate SDK Flutter Plugin'

  s.description         = <<-DESC
# Appfigurate™ Flutter Example
Demonstrates how to integrate Appfigurate SDK into a Flutter iOS and Android app.
Documentation for Appfigurate is available at https://docs.electricbolt.co.nz
Appfigurate is a trademark of Electric Bolt, registered in New Zealand.
DESC

  s.homepage            = 'https://github.com/electricbolt/appfiguratesdk'
  s.license             = { :type => 'Proprietary', :file => '../LICENSE' }
  s.author              = { 'Electric Bolt Limited' => 'support@electricbolt.co.nz' }
  s.source              = { :git => 'https://github.com/electricbolt/appfiguratesdk-flutter.git' }
  s.public_header_files = 'appfigurateflutter/Sources/appfigurateflutter/include/appfigurateflutter/AppfigurateFlutterPlugin.h'
  s.source_files        = 'appfigurateflutter/Sources/appfigurateflutter/**/*.{h,m}'
  s.vendored_frameworks = 'AppfigurateLibrary.xcframework'
  s.platform            = :ios, '15.0'
  s.dependency          'Flutter'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
