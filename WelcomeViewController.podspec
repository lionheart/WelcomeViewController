# vim: ft=ruby

Pod::Spec.new do |s|
  s.name             = 'WelcomeViewController'
  s.version          =  "0.1.0"
  s.summary          = "A welcome view in the style of Apple's built-in apps."

  s.description      = <<-DESC
  A view controller that lets you quickly and easily summarize your app's functionality.
                       DESC

  s.homepage         = 'https://github.com/lionheart/WelcomeViewController'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { "Dan Loewenherz" => 'dan@lionheartsw.com' }
  s.source           = { :git => 'https://github.com/lionheart/WelcomeViewController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lionheartsw'

  s.ios.deployment_target = '11.0'

  s.source_files = 'WelcomeViewController/Classes/**/*', 'WelcomeViewController/Protocols/**/*'

  s.frameworks = 'UIKit'
  s.dependency 'SuperLayout', '~> 1.0'
  s.dependency 'LionheartExtensions', '~> 3.0'
  s.swift_version = '4.0'
end
