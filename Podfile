platform :ios, '9.0'

target 'baseline' do
  use_frameworks!
  pod 'Alamofire'
  pod 'Firebase/Core'
  pod 'Crashlytics', '~> 3.9.3'
  pod 'SDWebImage'
  pod 'AlamofireObjectMapper'
  pod 'SocialMediaLogin', :path => '../SocialMediaLogin'
  
  target 'baselineTests' do
    inherit! :search_paths
  end

  target 'baselineUITests' do
    inherit! :search_paths
  end

end
