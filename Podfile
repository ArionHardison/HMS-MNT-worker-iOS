platform :ios, '12.0'

target 'DietManagerChef' do
  use_frameworks!

  # Updated dependencies with compatibility focus
  pod 'Charts', '~> 4.1'  # Charts library for revenue visualization
  pod 'Alamofire', '~> 4.9'
  # pod 'AlamofireObjectMapper', '~> 5.2'  # Removed due to Swift compatibility issues
  pod 'ObjectMapper', '~> 3.4'  # Still needed by app entities
  pod 'SwiftyJSON', '~> 4.3'
  pod 'SDWebImage', '~> 5.0'
  pod 'NVActivityIndicatorView', '~> 4.8'
  pod 'GooglePlaces', '6.2.1'
  pod 'GoogleMaps', '6.2.1'
  
  # Updated Firebase (updated to resolve OSAtomic issues)
  pod 'Firebase/Core', '~> 8.0'
  pod 'Firebase/Database', '~> 8.0'
  pod 'Firebase/Messaging', '~> 8.0'
  
  pod 'TextFieldEffects', '~> 1.6'
  pod 'UnsplashPhotoPicker', '~> 1.1'
  pod 'EasyTipView', '~> 2.0'
  pod 'KWDrawerController', '~> 4.2'
  pod 'IQKeyboardManagerSwift', '~> 6.5'


  target 'DietManagerChefTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DietManagerChefUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      config.build_settings['SWIFT_VERSION'] = '5.0'
      
      # Fix GoogleDataTransport strict prototypes issue
      if target.name == 'GoogleDataTransport'
        config.build_settings['WARNING_CFLAGS'] = '-Wno-strict-prototypes'
      end
      
      # Exclude GoogleMaps frameworks for simulator builds  
      if target.name.include?('GoogleMaps') || target.name.include?('GooglePlaces')
        config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64 x86_64 i386'
      end
      
    end
  end
end
