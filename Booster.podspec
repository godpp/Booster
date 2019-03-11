#
#  Be sure to run `pod spec lint Booster.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "Booster"
  s.version      = "0.1.0"
  s.summary      = "Booster is an REST API Networking Library written in Swift."

  s.description  = <<-DESC
     "Booster was developed during NAVER CONNECT Foundation's the BoostCamp 3rd iOS process."
     "Booster is an Simple REST API Networking Library written in Swift."
     "Booster was created using only the Apple frameworks."
                   DESC

  s.homepage     = "https://github.com/godpp/Booster"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "godpp" => "taylored@naver.com" }

  s.platform     = :ios, "10.0"
  s.ios.deployment_target = "12.0"
  s.swift_version = "4.2"

  s.source       = { :git => "https://github.com/godpp/Booster.git", :tag => "#{s.version}" }

  s.source_files  = "Sources/**/*.{h,m,swift}"

end
