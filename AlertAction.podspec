Pod::Spec.new do |s|
  s.name         = "AlertAction"
  s.version      = "1.0.7"
  s.summary      = "alert sheet "
  s.homepage     = "https://github.com/MxABC/LBXAlertAction"

  s.license      = "MIT"
  s.author       = { "lbxia" => "lbxia20091227@foxmail.com" }

  s.source       = { :git => "https://github.com/MxABC/LBXAlertAction.git",:tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'AlertAction/*.swift'

  s.requires_arc = true

end
