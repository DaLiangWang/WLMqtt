
Pod::Spec.new do |s|
    s.name         = 'WLMqtt'
    s.version      = '0.0.5'
    s.summary      = 'An easy way to use mqtt'
    s.homepage     = 'https://github.com/DaLiangWang/WLMqtt'
    s.license      = 'MIT'
    s.authors      = {'wangliang' => 'wlhjx1993@gmail.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/DaLiangWang/WLMqtt.git', :tag => s.version}
    s.source_files = "WLMqtt/Class/*.{h,m}"
    # s.public_header_files = 'WLPageView/Class/Category/WL_Macros.h'
    s.requires_arc = true

    # s.dependency "Protobuf"
    s.dependency "CocoaLumberjack"
    s.dependency "MQTTClient"
    s.dependency "SocketRocket"

end