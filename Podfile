def import_pods
  pod 'Swift3D'
end

target :Pods_OSX do
  platform :osx, '10.11'
  link_with 'Metal_3D_Engine_OSX'
  import_pods
end

target :Pods_iOS do
  platform :ios, '9.0'
  link_with 'Metal_3D_Engine_iOS'
  import_pods
end

target :Pods_tvOS do
  platform :tvos, '9.0'
  link_with 'Metal_3D_Engine_tvOS'
  import_pods
end

use_frameworks!
