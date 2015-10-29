Pod::Spec.new do |s|
  s.name         =  'JASidePanels'
  s.version      =  '0.0.1'
  s.license      =  'MIT'
  s.summary      =  'UIViewController container designed for presenting a center panel with revealable side panels - one to the left and one to the right.'
  s.homepage     =  'https://github.com/gotosleep/JASidePanels'
  s.author       =  { 'Jesse Andersen' => 'gotosleep@gmail.com' }
  s.source       =  { :git => 'https://github.com/db42/JASidePanels.git', :commit => 'd5eb929ee54708c03c84083831de9619c0557b75' }
  s.platform     =  :ios
  s.source_files =  'JASidePanels/Source/*'
  s.framework    =  'QuartzCore'
  s.requires_arc =  true
end
