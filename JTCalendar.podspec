Pod::Spec.new do |s|
  s.name         = "JTCalendar"
  s.version      = "2.1.7"
  s.summary      = "A customizable calendar view for iOS."
  s.homepage     = "https://github.com/jonathantribouharet/JTCalendar"
  s.license      = { :type => 'MIT' }
  s.author       = { "Jonathan Tribouharet" => "jonathan.tribouharet@gmail.com" }
  s.platform     = :ios, '7.0'
  #to access this fork directly
  #s.source       = { :git => "https://github.com/shabib87/JTCalendar.git"}
  s.source       = { :git => "https://github.com/jonathantribouharet/JTCalendar.git", :tag => s.version.to_s }
  s.source_files  = 'JTCalendar/**/*'
  s.requires_arc = true
  s.screenshots   = ["https://raw.githubusercontent.com/jonathantribouharet/JTCalendar/master/Screens/example.gif"]
end
