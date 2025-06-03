#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
#
Pod::Spec.new do |s|
  s.name             = 'ffmpeg_kit_flutter_min'
  s.version          = '6.0.6'
  s.summary          = 'FFmpeg Kit for Flutter with minimal configuration (updated fork)'
  s.description      = <<-DESC
  A forked version of the FFmpeg Kit for Flutter (minimal configuration) updated for compatibility with newer Flutter versions.
                       DESC
  s.homepage         = 'https://github.com/arthenica/ffmpeg-kit'
  s.license          = { :type => 'LGPL-3.0', :file => '../LICENSE' }
  s.author           = { 'Taner Sener' => 'tanersener@gmail.com', 'Fork maintainer' => 'your.email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'ffmpeg-kit-ios-min', '6.0'
  s.platform = :ios, '12.1'
  s.ios.deployment_target = '12.1'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
