import { AchievementPage } from '../view/achievement/AchievementPage';
import { CirclePage } from '../view/circle/Circle';
import { MinePage } from '../view/mine/MinePage';
import { PlanPage } from '../view/plan/PlanPage';
@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0;

  build() {
    Tabs(){
      TabContent() {
        PlanPage()
      }.tabBar(this.barBuilder(0, '主页', $r('app.media.ic_tabs_home_normal'), $r('app.media.ic_tabs_home_sel')))

      TabContent() {
      // 成就页面
        AchievementPage()
      }.tabBar(this.barBuilder(1, '成就', $r('app.media.ic_tabs_achievement_normal'), $r('app.media.ic_tabs_achievement_sel')))

      TabContent() {
        CirclePage()
      }.tabBar(this.barBuilder(2, '圈子', $r('app.media.ic_circle_normal'), $r('app.media.ic_circle_sel')))

      TabContent() {
        MinePage()
      }.tabBar(this.barBuilder(3, '我的', $r('app.media.ic_tabs_mine_normal'), $r('app.media.ic_tabs_mine_sel')))
    }
    .barPosition(BarPosition.End)
    .onChange((index) => {
      this.currentTabIndex = index
    })
  }

  @Builder barBuilder(index: number, title: string, icon: Resource, iconSelected: Resource) {
    Column() {
      Image(this.currentTabIndex === index ? iconSelected : icon)
        .width(25)
        .height(25)
      Text(title)
        .tabTitleStyle(this.currentTabIndex === index ? Color.Black : '#959595')
    }
  }
}

@Extend(Text) function tabTitleStyle(color: ResourceColor) {
  .fontSize(10)
  .fontWeight(FontWeight.Medium)
  .fontColor(color)
  .margin({ bottom: 2 })
}