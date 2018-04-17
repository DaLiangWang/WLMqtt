
Pod::Spec.new do |s|
    s.name         = 'WLMqtt'
    s.version      = '0.0.1'
    s.summary      = 'An easy way to use mqtt'
    s.homepage     = 'https://github.com/DaLiangWang/WLMqtt'
    s.license      = 'MIT'
    s.authors      = {'wangliang' => 'wlhjx1993@gmail.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/DaLiangWang/WLMqtt.git', :tag => s.version}
    s.source_files = 'Class/*.{h,m}'
    # s.public_header_files = 'WLPageView/Class/Category/WL_Macros.h'
    s.requires_arc = true

    s.dependency "Protobuf", '~> 3.0.2'
    s.dependency "CocoaLumberjack", '~> 3.4.1'
    s.dependency "MQTTClient", '~> 0.13.1'
    s.dependency "SocketRocket", '~> 0.5.1'

end