Pod::Spec.new do |s|
  s.name         = "Panels"
  s.version      = "0.1"
  s.summary      = "Esasy and simple panel creation"
  s.description  = <<-DESC
    Your description here.
  DESC
  s.homepage     = "https://github.com/antoniocasero/Panels"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Antonio Casero Palmero" => "anto.casero@gmail.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "11.0"
  s.source       = { :git => "https://github.com/antoniocasero/Panels.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
