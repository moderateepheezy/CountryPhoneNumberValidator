#
# Be sure to run `pod lib lint CountryPhoneNumberValidator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CountryPhoneNumberValidator'
  s.version          = '0.1.1'
  s.summary          = 'A phone number validator based on Country dial code'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  The library provides a view for inputing phone number with dial code, returns a country flag and
   validate if the dial code is valid for bthe phone number inputed 
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/moderateepheezy/CountryPhoneNumberValidator'
  s.screenshots     = 'https://user-images.githubusercontent.com/4386218/33623765-5e8e72d6-d9f2-11e7-851b-f0275fd1d4e1.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'moderateepheezy' => 'moderateepheezy@gmail.com' }
  s.source           = { :git => 'https://github.com/moderateepheezy/CountryPhoneNumberValidator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.1'

  s.source_files = 'CountryPhoneNumberValidator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CountryPhoneNumberValidator' => ['CountryPhoneNumberValidator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'PhoneNumberKit', '~> 2.0'
  s.dependency 'libPhoneNumber-iOS', '~> 0.8'

end
