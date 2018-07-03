 platform :ios, '10.0'

target 'TestTask' do
    use_frameworks!
    inhibit_all_warnings!

  #Networking
  
  pod 'SwiftyJSON'
  pod 'Moya'
  pod 'Moya/RxSwift'
  
  pod 'AlisterSwift', :git => 'https://github.com/anodamobi/AlisterSwift.git', :branch => 'develop', :commit => 'ff395f6'

  pod 'SnapKit', :git => 'git@github.com:SnapKit/SnapKit.git', :branch => 'develop', :commit => '15beb52'
  pod 'Kingfisher', '~> 4.0'
  pod 'UIScrollView-InfiniteScroll'
  pod 'MBProgressHUD'
  
  target 'TestTaskTests' do
      inherit! :search_paths
      pod 'Quick', '~> 1.2.0'
      pod 'Nimble', '~> 7.1.2'
  end
  
end
