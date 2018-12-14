# QuickNote - [_Toggle to English_](!https://github.com/WanderHuang/QuickNote/blob/master/README.md)
用Flutter构建的TODOLIST应用. Made by [wander](!https://github.com/WanderHuang)。你可以把这个项目当做一个上手Flutter的初始化项目，我给您规划好了目录结构，开发起来应该是比较流畅的。  
就我个人来讲，服务层开发像是java，界面层开发像是vue或者react，这就够了。了解了前面这些，入门Flutter应该是很快的，但是一个新模式，最重要的还是经验，写的多，踩坑多，思考多，那做起来会很舒服的。

## Flutter开发环境
- 环境搭建
  - 根据[官方文档](!https://flutter.io/)一步步设置开发的初步环境，至少需要一个SDK吧.
  - `Android Studio` 可以用来下载安卓相关的SDK， 但是开发更喜欢`Visual Studio Code` :joy:(开发体验好)
  - 我用`HUAWEI MATE 9`做的开发测试
- 开发建议
  - 看一些介绍BLoC(Business Logic Component)的文章，感觉和mvc类似，目的就是为了分层，各个部分干各自的事，用`流`(响应式编程)串联.
  - 看一些响应式编程相关的，目前笔者也在看.
  - 了解一些Dart语言的语法规则，毕竟是Flutter开发的基础。个人感觉是java和es6的结合，加了一些自己的语言规则。
- 发现问题
  - 国内要下包的时候就蛋疼了，有时候是pub服务器没响应，有时需要设置代理，或者用国内的镜像。总之`flutter packages run`经常会慢出翔
  - 开发过程中报出来的错误，去Flutter的github上搜issue就行了。实在找不到就stackoverflow。


## 项目介绍
- 目录
  - `lib/` 源码目录
  - `lib/api` 项目层级的api(开发java时的习惯，手动狗头)
  - `lib/components` 组件式开发(开发vue时的习惯，手动狗头)
  - `lib/constants` 全局常量，项目稳定后可以做成配置文件
  - `lib/database` 数据库操作DAO
  - `lib/models` 模型，也就是java bean
  - `lib/pages` 开发vue的习惯，用路由定向的多个页面`Navigator`
- 组件: 组件实际上就是你的页面和控制逻辑的集合，当然部分组件还可以包含业务逻辑。
  - `a_component/bloc` BLoC相当于java里面的服务层，相当于vue的一个实例，你在这里处理UI逻辑、UI和DB的交互等等。 [详情收看](!https://medium.com/flutter-community/reactive-programming-streams-bloc-6f0d2bd2d248)
  - `a_component/db` DAO层，调用这一层可以操作组件对应的数据库表
  - `a_component/event` 相当于vue里面的commit事件，注册了事件后，在组件里面就可以自由飞翔了，分发你的数据，控制你的业务逻辑，都有用。
  - `a_component/index` 暴露组件给外部，通常只暴露一个页面就行了。如果业务逻辑也会被用到，那可以选择性暴露bloc或者db
  - `a_component/page` 这里存放着你的静态页面，只需要在这里设计好页面长什么样子就行了，类似于react里面返回的jsx element， vue里面的html模板。当然如果涉及到逻辑的，要在这里处理。基本上交给bloc就行了。
  - `a_component/state` 状态管理。你的组件状态存在这里，更新状态的时候，会触发UI重新渲染(widget会拿到新的state去做渲染)
  

## 需要了解的技术点
- dart
- flutter
- bloc pattern
- material design
- sqlite

## Run
- `flutter packages get`
- `flutter run`

## TODO
- 功能躲起来之后就可以考虑接入`firebase`，爽一把。
- 界面设计更漂亮一点 :worried:
- 增加`设置`
- 增加`日历`
- 增加更多...:joy:
