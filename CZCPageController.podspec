Pod::Spec.new do |s|
s.name             = 'CZCPageController'
s.version          = '1.0.2'
s.summary          = '多页面切换工具'
s.homepage         = 'https://github.com/2360219637/CZCPageController'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { '2360219637@qq.com' => 'chenzhichao' }
s.source           = { :git => 'https://github.com/2360219637/CZCPageController.git', :tag => s.version.to_s }
s.ios.deployment_target = '8.0'

s.subspec 'CZCPageController' do |ss|
    ss.source_files = 'CZCPageController/CZCPageController/*.{h,m}'
    ss.dependency 'CZCPageController/Views'
    ss.dependency 'CZCPageController/CZCProtocols'
    ss.dependency 'CZCPageController/CZCSegBar'
end
s.subspec 'CZCProtocols' do |ss|
    ss.source_files = 'CZCPageController/CZCProtocols/*.h'
end
s.subspec 'CZCSegBar' do |ss|
    ss.source_files = 'CZCPageController/CZCSegBar/*.{h,m}'
    ss.dependency 'CZCPageController/Views'
end
s.subspec 'Views' do |ss|
    ss.source_files = 'CZCPageController/Views/*.{h,m}'
    ss.dependency 'CZCPageController/CZCProtocols'
end

end
