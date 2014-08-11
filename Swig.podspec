#
# Be sure to run `pod lib lint Swig.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "Swig"
    s.version          = "0.1.0"
    s.summary          = "SIP library for Objective-C"
    s.description      = <<-DESC
                            Swig makes it easy to make and recieve calls though SIP.
                            DESC
    s.homepage         = "https://github.com/petester42/Swig"
    # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
    s.license          = 'GPLv2'
    s.author           = { "Pierre-Marc Airoldi" => "pierremarcairoldi@gmail.com" }
    s.source           = { :git => "https://github.com/petester42/Swig.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/petester42'

    s.platform     = :ios, '7.0'
    s.requires_arc = true

    s.source_files = 'Pod/Classes'
    # s.resources = 'Pod/Assets/*.png'
    s.dependency 'pjsip', '~> 2.2'
end
