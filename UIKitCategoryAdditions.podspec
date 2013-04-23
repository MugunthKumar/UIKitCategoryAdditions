Pod::Spec.new do |s|
  s.name     = 'UIKitCategoryAdditions'
  s.version  = '1.0.0'
  s.summary  = 'Block based Category additions for AlertView and ActionSheets.'
  s.homepage = 'https://github.com/MugunthKumar/UIKitCategoryAdditions'
  s.license  = { :type => 'Custom', :file => 'README.mdown' }
  s.author   = { 'MugunthKumar' =>  'contact@mk.sg' }
  s.source   = { :git => 'https://github.com/jamone13/UIKitCategoryAdditions.git', :tag => s.version.to_s }
  s.platform = :ios
  s.source_files = 'MKAdditions/*.{h,m}'
  s.requires_arc = false
end