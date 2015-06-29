Pod::Spec.new do |s|

  s.name         = "Swifternalization"
  s.version      = "1.0.2"
  s.summary      = "Library that helps in localizing apps. It is written in Swift."

  s.homepage     = "https://github.com/tomkowz/Swifternalization"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "Tomasz Szulc" => "szulctomasz@me.com" }
  s.social_media_url = "http://twitter.com/tomkowz"

  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/tomkowz/Swifternalization.git", :tag => "v1.0.2" }

  s.source_files  = 'Classes', 'Swifternalization/**/*.{swift,h}'
  s.requires_arc = true

end