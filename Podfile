platform :ios, '10.0'

# ignore all warnings from all pods
inhibit_all_warnings!

# use frameworks for Swift
use_frameworks!

project 'SnapScrollView'

target 'SnapScrollView' do
  # Autolayout
  pod 'SnapKit'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end