Pod::Spec.new do |s|
  s.name = "BadgedBarButtonItem"
  s.version = "3.0.0"
  s.summary = "A UIBarButtonItem that can be badged!"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Eric Miller" => "eric@ericnmiller.com" }
  s.homepage = "https://github.com/enmiller/ENMBadgedBarButtonItem-Swift.git"

  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.source = { :git => "git@github.com:enmiller/ENMBadgedBarButtonItem-Swift.git", :tag => s.version.to_s }

  s.source_files = "SampleApp-Swift/BadgedBarButtonItem/*.swift"
end
