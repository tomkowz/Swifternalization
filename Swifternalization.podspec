Pod::Spec.new do |s|

  s.name         = "Swifternalization"
  s.version      = "2.0.0"
  s.summary      = "Swift Framework which helps in localizing apps using JSON files."

  s.homepage     = "https://github.com/hovhannest/Swifternalization"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "Tomasz Szulc" => "mail@szulctomasz.com" }
  s.social_media_url = "http://twitter.com/tomkowz"

  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/hovhannest/Swifternalization.git", :tag => "v2.0.0" }
  
  s.source_files  = 'Classes', 'Swifternalization/**/*.{swift,h}'
  s.requires_arc = true

end
