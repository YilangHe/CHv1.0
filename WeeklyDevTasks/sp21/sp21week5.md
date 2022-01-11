## Spring21 Week 5 Development Tasks
---
#### Week 5 Goals:
- integrate login system with current page
- implement backend for Settings page
- create fake data for course system
- polish profile tag view
- adjust Home view


#### Task Assignments and Specification
**Duolan**
- polish profile tag view
- implement backend for settings page (Optional)
- implement "Change Profile Picture" functionality (Optional)

**Amy**
  - integrate login system with current page **（High Priority）**
    - 一打开还是login page，登录成功后才会direct到Home View
    - 应该是一个quick fix
  - create fake data for course system
    - 根据home page上的信息create一些fake data，然后存储到firebase cloud database
    - create完fake data后先和我（欧阳）说一下，然后一起设计一下存储的structure
    - 可以用Python Script完成
  - Self-Study
    - Firebase

**Noodles**
- adjust Home view
  - 根据weekly meeting上PM&PD提供的建议更改Home View页面
  1. nav bar的item离upper bar太近了
  2. notification 里面的内容font太小了
  3. hard code 一个notification time在后面

- Self-Study
  - SwiftUI GeometryReader
  - Firebase + SwiftUI


**Tony & Peter**
- Self-Study
  - SwiftUI
  - Firebase (Optional)


#### Notes
1. 从这周开始，我们需要遵守一定的GitHub使用规范了。先在一个单独的branch进行改动，改动完成后，提交一个merge request，然后可以在群里tag我一下。可以参考下面这个post
https://akshayranganath.github.io/Git-Pull-Handling-Merge-Conflict/

2. Amy的第一个Task最好可以早点完成，应该十分钟就能改好；改好了才能方便后面写后端
