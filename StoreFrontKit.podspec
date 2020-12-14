Pod::Spec.new do |s|
  s.name             = 'StoreFrontKit'
  s.version          = '1.0.0'
  s.summary          = 'Lightweight and flexible presentation kit for in app purchases.'
  s.description      = 'Lightweight and customizable in app purchase presentation framework.'
  s.homepage         = 'https://github.com/AfrazCodes/StoreFrontKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AfrazCodes' => 'afraz9@gmail.com' }
  s.source           = { :git => 'https://github.com/AfrazCodes/StoreFrontKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.source_files = 'StoreFrontKit/**/*.{swift}'
  s.swift_versions = '5.0'
end
