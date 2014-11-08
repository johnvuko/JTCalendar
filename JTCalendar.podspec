Pod::Spec.new do |s|
  s.name         = "JTCalendar"
  s.version      = "1.0.8"
  s.summary      = "A customizable calendar view for iOS."
  s.homepage     = "https://github.com/jonathantribouharet/JTCalendar"
  s.license      = { :type => 'MIT' }
  s.author       = { "Jonathan Tribouharet" => "jonathan.tribouharet@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/jonathantribouharet/JTCalendar.git", :tag => s.version.to_s }
  s.source_files  = 'JTCalendar/*'
  s.requires_arc = true
end
