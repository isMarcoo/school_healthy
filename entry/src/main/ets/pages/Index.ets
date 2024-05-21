import { CirclePage } from './Circle';
import { PlanPage } from './Plan';
@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0;

  build() {
    Tabs(){
      TabContent() {
        PlanPage()
      }.tabBar('计划')

      TabContent() {
        CirclePage()
      }.tabBar(this.barBuilder(1, '圈子', $r('app.media.app_icon'), $r('app.media.app_icon')))

      TabContent() {
        Text('我的')
      }.tabBar('我的')
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