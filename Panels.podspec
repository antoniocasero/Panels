Pod::Spec.new do |s|
  s.name         = "Panels"
  s.version      = "2.1.0"
  s.summary      = "Simple sliding panels"
  s.description  = <<-DESC
    Add easly sliding panels to your app. Focus on the UI, let ´Panels´ do the rest.
  DESC
  s.homepage     = "https://github.com/antoniocasero/Panels"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Antonio Casero Palmero" => "anto.casero@gmail.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/antoniocasero/Panels.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "UIKit"
  s.swift_version = '5.0'
end
