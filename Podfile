source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
        end
    end
end

target 'SwiftCollection' do
    # swift 版 AFNetworking
    pod 'Alamofire', '~> 4.0'
    
    # 简化 JSON 访问
    pod 'SwiftyJSON'
    
    # JSON 转 对象
    # pod 'ObjectMapper', '~> 1.3'
    
    # swift 版 Masonry
    # pod 'SnapKit', '~> 0.15.0'
    
    pod 'RxSwift',    '~> 3.0.0-beta.1'
    pod 'RxCocoa',    '~> 3.0.0-beta.1'
    pod 'Charts'
end

