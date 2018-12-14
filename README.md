# QuickNote - [_中文_](!/README_zh.md)
A Flutter TODOLIST app demo. Made by [wander](!https://github.com/WanderHuang).

## Flutter Development Environment
- Environment
  - use [Official](!https://flutter.io/) and you can set your environment step by step.
  - `Android Studio` is good enough for get an Android SDK, but I perfer `Visual Studio Code` :joy:
  - I use my `HUAWEI MATE 9` to debug
- Suggest
  - read some articles about BLoC(Business Logic Component).
  - read about reactive programming articles.
  - learn some dart grammar
- Problem
  - use a `Proxy` before execute `flutter packages run` in China
  - search your problem accurred when you debug on `flutter/issue`(issue of flutter on github) or stackoverflow.


## project introduction
- catalog
  - `lib/` source code
  - `lib/api` top api of your project
  - `lib/components` like a vue components that serve some UI widget
  - `lib/constants` constants of this project
  - `lib/database` operations on database
  - `lib/models` like a java bean directory
  - `lib/pages` pages that you can use `Navigator` to route to
- component: in some words, component is a widget that serve some UI and its logics.
  - `a_component/bloc` like a java service or a vue instance that serve your component's ui. More details [here](!https://medium.com/flutter-community/reactive-programming-streams-bloc-6f0d2bd2d248)
  - `a_component/db` like a java DAO or a vue http service that provides data persistence services
  - `a_component/event` it's just some events that can notify your service what to do adn how to work.
  - `a_component/index` expose this component to others
  - `a_component/page` your ui. like a jsx element or a vue template. built by flutter widgets or you custom widgets. 
  - `a_component/state` state management. Change state will trigger a rebuild of your component.
  

## Techniques(Need to know)
- dart
- flutter
- bloc pattern
- material design
- sqlite

## Run
- `flutter packages get`
- `flutter run`

## TODO
- maybe support a `firebase` service.
- to build it beautiful :worried:
- add `Profile` feature
- add `Date` feature
- more features...:joy:
