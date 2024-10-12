Pod::Spec.new do |s|
  s.name             = 'SelfieCaptureFramework'
  s.version          = '1.0.0'
  s.summary          = 'A framework for capturing selfies and integrating with camera functionalities.'
  s.homepage         = 'https://github.com/omaymaa/SelfieFramework.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Omayma Mansour' => 'omaymamansour26@gmail.com' }
  s.source           = { :git => 'https://github.com/omaymaa/SelfieFramework.git', :tag => '1.0.0' }
  s.source_files     = 'SelfieCaptureFramework/**/*.{h,m}'  # Ensure this path matches your files
  s.platform         = :ios, '12.0'  
end
