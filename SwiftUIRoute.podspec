Pod::Spec.new do |s|
  s.name             = "SwiftUIRoute"
  s.version          = '0.0.2'
  s.summary          = "SwiftUIRoute is a easy way to manage your routers"
  s.swift_version    = '5.0'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/dushengaojin/SwiftUI-Route'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daolang Huang' => 'h_daodao@163.com' }
  s.source           = { :git => 'https://github.com/dushengaojin/SwiftUI-Route.git', :tag => "SwiftUIRoute-" + s.version.to_s }
  s.ios.deployment_target = '14.0'
  s.cocoapods_version = '>= 1.10.0'
  s.static_framework = false
  s.prefix_header_file = false
  s.source_files = 'Source/**/*.swift'
end
