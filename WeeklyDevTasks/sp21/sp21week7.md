## Spring21 Week 7 Development Tasks
---
#### Week 7 Goals:
- Populate DB with python generated fake data
- Integrate chat frontend and backend
- Add lock protection to chat db
- Add small features to Profile page
- Get staarted with Friends page UI 


#### Task Assignments and Specification
**Duolan**
- Integrate Chat frontend and backend
- Add lock protection to chat db

**Amy**
  - create fake data for course system
    - 根据上次设计的db scheme做一些data
    - 可以用Python Script完成
  - Implement course search functionality
    - 在已有的course search界面可以直接search db里的课程
    - 最好有实时变化的auto completion
    - （可以直接从db里把所有课程拉过来，然后本地做search）

**Noodles**
- Fix the TapBar issue
- Implement reaction page
  - 点击msg，会有一个pull up的小page，可以选择emoji的那个
  - 详细可见figma UI

**Peter**
- 完善profile page
   1. save confirmation：当用户点击Save的时候，跳出一个弹窗Save or Cancel
   2. 自动检测info page是否有change发生，如果没有change&用户点了x，就正常关闭；如果有change&用户点了x，就跳出一个弹窗说“是否要放弃改动”
   - Yes：正常退出
   - No：不退出

**Tony**
- Implement Friends UI page


#### Known Bugs (Need to fix later)
- All errors happend at SignUp are classified as "user email has registered". Have to add more specific error handlers later.


#### Notes
加油！
