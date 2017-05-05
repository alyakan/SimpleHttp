Pod::Spec.new do |s|
 s.name = 'SimpleHTTP'
 s.version = '0.0.1'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'cookiecutter bootstrap template for swift framework'
 s.homepage = 'http://rahulkatariya.me'
 s.social_media_url = 'https://twitter.com/rahulkatariya91'
 s.authors = { "Aly Yakan" => "aly.yakan@gmail.com" }
 s.source = { :git => "https://github.com/cookiecutter-swift/SimpleHTTP.git", :tag => "v"+s.version.to_s }
 s.platforms     = { :ios => "8.0", :osx => "10.10", :tvos => "9.0", :watchos => "2.0" }
 s.requires_arc = true

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.source_files  = "Sources/*.swift"
     ss.framework  = "Foundation"
 end

end
