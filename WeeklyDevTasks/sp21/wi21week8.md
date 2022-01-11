## Winter 21 Week 8 Development Tasks
---
#### Week 8 Goals:
- Complete SignUp and LogIn page
- Home page frontend UI
- Profile page frontend UI & some backend logic


#### Task Assignments and Specification
**Ang Li**
- Emails has already been registered
  - Alert the user if the email they used in signup has already been used, ask them do they want to resend verification email
    - The alert should have two buttons `no` and `resend`
    - Resend the verification email if they choose `resend`
    - Go back to sign up page if they choose `no`
  - 需要更改的文件: SignUpView.swift
  - Reviewer: Duolan
  

- Forget Password
  - Use Firebase forget password API to help user recover their password
  - 具体的页面可以按照你的预想implement
  - 需要更改的文件: LogInView.swift
  - Reviewer: Duolan


**Mei & Amy**
- Home page frontend UI
  - `Weekly Schedule`这个隐藏的menu可以先不做，因为PD暂时还没提供这个的设计图
  - `Past Course`这个隐藏的menu可以做，应该就和`Winter 2021`这一栏长的一样
  - 不要忘记把下面的那四个Bar也做了
  - 写在HomeView.swift这个文件就好，先不要更改ContentView.swift
  - No Pressue, 这周尽量做，因为我觉得看tutorial还不如直接上手做，所以就把这个当成一个tutorial exercise就好了，有什么关于页面的问题可以在大群里问PD/PM，有什么dev方面的问题可以在dev群问我或者Li Ang
  - 需要更改的文件: HomeView.swift
  - Reviewer: Duolan

**Duolan**
- Profile Page UI
- Settings sub page UI
- Save sub page UI
- Info sub page UI
- Add backend logic if have time
- Reviewer: Li Ang


#### Code Review
大家做完了自己的part后请联系我在task中分配的Reviewer，Reviewer可以和这个任务的Developer setup一个时间做online code review。第一次我会先做Reviewer，以后我们就轮流帮别的developer review。

做完code review后，先在群里说一下，如果没有什么会产生conflict的问题，再push。请在doc里注名author(s)和Reviewers(s)。

Review要涵盖的点：
1. 功能测试 （no obvious bug）
2. Coding Style （不求多优雅，但一定要readable）
3. Documentation (document each function, provide inline comments if neccessary）