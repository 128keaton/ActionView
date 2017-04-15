Pod::Spec.new do |s|
  s.name             = 'ActionView'
  s.version          = '0.1'
  s.summary          = 'A full screen tableview designed for selections.'

  s.description      = <<-DESC
A full screen selection view for iOS, over the current context
                       DESC

  s.homepage         = 'https://github.com/128keaton/ActionView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Keaton Burleson' => 'keaton.burleson@me.com' }
  s.source           = { :git => 'https://github.com/128keaton/ActionView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'ActionView/ActionView.swift'

end
