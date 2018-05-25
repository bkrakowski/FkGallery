platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def sharedPods
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'AlamofireImage'
    pod 'SVProgressHUD'
    pod 'OHHTTPStubs/Swift'
    pod 'OHHTTPStubs'
end

target 'FkGallery' do
    inherit! :search_paths
    sharedPods
end

target 'FkGalleryTests' do
    inherit! :search_paths
    sharedPods
end

target 'FkGalleryUITests' do
    inherit! :search_paths
    sharedPods
end

