platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def sharedPods
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'AlamofireImage'
end

target 'FkGallery' do
    inherit! :search_paths
    sharedPods

    pod 'SVProgressHUD'
end

target 'FkGalleryTests' do
    inherit! :search_paths
    sharedPods

    pod 'OHHTTPStubs/Swift'
    pod 'OHHTTPStubs'
end

target 'FkGalleryUITests' do
    inherit! :search_paths
    sharedPods

    pod 'SVProgressHUD'
end


