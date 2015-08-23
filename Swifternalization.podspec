Pod::Spec.new do |s|
  s.name = "Swifternalization"
  s.version = "1.2.1"
  s.summary = "Swift Framework which helps in localizing apps."
  s.homepage = "https://github.com/tomkowz/Swifternalization"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { "Tomasz Szulc" => "mail@szulctomasz.com" }
  s.social_media_url = "http://twitter.com/tomkowz"

  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'

  s.source = { :git => "https://github.com/tomkowz/Swifternalization.git", :tag => "v1.2.1" }
  s.source_files = 'Classes', 'Swifternalization/**/*.{swift,h}'
  s.watchos.source_files = 'Classes', 'Swifternalization/**/*.{swift,h}'

  s.documentation_url = 'http://szulctomasz.com/docs/swifternalization/public/'
end