#JPush 官方iOS版本SDK

提供JPush SDK的镜像，由于官方没有提供相应的服务，因此做个镜像方便使用JPush服务的项目提供cocoapods服务，已提交到[官方`spec`](https://github.com/CocoaPods/Specs/tree/master/Specs/JPush)

##使用说明
- cocoapods导入
```pod 'JPush'```

##关于更新
如果您感觉更新不及时，愿意贡献更及时的更新
- 联系我（liubiqu@qq.com)
- 把注册好的邮箱发给：把`pod trunk me`里 显示的邮箱发给我
- 1个工作日内回复

##当前版本1.8.5
- 最近更新说明官方连接：http://docs.jpush.io/updates/

##JPush iOS SDK v1.8.5
- 更新时间 2015-07-30

- Change Log
修复Bug：解决与第三方库冲突引起的编译出错.
- 升级提示
建议升级！
- 升级指南
替换 lib 文件夹里的文件 .a 文件为新版本；
替换 lib 文件夹里的文件 .h 文件为新版本；
工程添加libz.dylib、Security.framework两个库；
新版本不再需要 libPushSDK-Simulator.a 。如果你的老版本 SDK 包含此文件，请删除。

##JPush iOS SDK v1.8.2 版本Change Log
优化改进：修复一些可能引起崩溃问题  
优化改进：修复部分情况下获取不到 RegistrationID 的问题

##JPush iOS SDK v1.8.1 版本Change Log  
优化改进：修改与部分第三方 SDK 变量冲突问题  
优化改进：修复 iOS5 版本 Demo 按钮异常  


##JPush iOS SDK v1.8.0 版本Change Log  
新增功能：增加 iOS8 支持  
新增功能：增加本地推送 API  
新增功能：增加地理位置信息上报  
新增功能：增加崩溃日志上报  
新增功能：增加日志等级修改  
优化改进：修改上报重试机制  
优化改进：修复 setTagAlias 时回调类被释放时崩溃bug  
优化改进：全新的参考 Demo  


##JPush iOS SDK v1.7.4 版本 Change Log  
新增功能：增加设置 badge 值更新到 JPush 服务器功能。  
此 SDK 版本配合服务器端推送通知 badge +1 功能使用，实现群推 iOS 通知时 badge 值各用户不同的值。  


##JPush iOS SDK v1.7.3 版本发布  

Change Log  
优化改进：配合 API V3，更好的支持自定义消息的解析。  
升级提示  
建议升级。

##JPush iOS SDK v1.7.0 update 2014-05-04) 
新增功能：支持 RegistrationID 推送；
新增功能：增加页面统计上报；
修复BUG：修复上个版本在特定情况下崩溃的BUG。

##目录说明
- 根目录下为当前最新的版本
- 历史版本的文件分别存放于对应版本的目录

##技术支持
- 请查看官网最新的技术支持文档：[http://docs.jpush.io/](http://docs.jpush.io/)

- 若需要手动下载请到[官网下载最新的版本](http://docs.jpush.io/resources/)

##其他说明
- 建议每次发布都更新一下最新版本
- 历史版本实际上没有什么实用价值，只是可以用来重现一些QA的Bug
- 所有内容均来自`JPush.cn`官方网站
