Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "TutorialToastView"
s.summary = "TutorialToastView is a flexible view that allows for tutorial toast view."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Benjamin Hendricks" => "hendricksbenjamin@gmail.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/coolbnjmn/TutorialToastView"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/coolbnjmn/TutorialToastView.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"

# 8
s.source_files = "TutorialToastView/**/*.{swift}"

# 9
s.resources = "TutorialToastView/**/*.{png,jpeg,jpg,storyboard,xib}"
end