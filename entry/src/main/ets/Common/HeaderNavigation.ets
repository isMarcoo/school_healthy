import { StyleConstants } from 'ets/common/StyleConstants';

type ILeftIconGroup = {
  icon: ResourceStr;
  title?: string;
  event: () => void
}

type IMiddle = {
  title: ResourceStr
}

type IRightIconGroup = {
  icon: ResourceStr;
  event: () => void
}

/**
 * 配置对象
 *
 * leftIconGroup -> 左边图标及事件
 *
 * middle -> 中间标题
 *
 * rightIconGroup -> 右边图标及标题 最多不能超过三个
 */
@Component
export default struct HeaderNavigation {
  private leftIconGroup: ILeftIconGroup = {
    icon: '',
    title: '',
    event: (): void => {
    }
  }
  private middle: IMiddle = {
    title: ''
  }
  private rightIconGroup: IRightIconGroup[] = [
    {
      icon: '',
      event: (): void => {
      }
    }
  ]

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {

      // left
      Flex({ alignItems: ItemAlign.Center }) {
        if (this.leftIconGroup.icon) {
          Image(this.leftIconGroup.icon)
            .width($r('app.float.size_30vp'))
            .height($r('app.float.size_30vp'))
            .margin({ right: $r('app.float.size_20vp'), left: $r('app.float.size_20vp') })
            .onClick(() => this.leftIconGroup.event())
        }
        if (this.leftIconGroup.title) {
          Text(this.leftIconGroup.title)
            .fontSize($r('app.float.font_size_18fp'))
            .fontWeight(FontWeight.Bold)
        }
      }
      .width('30%')
      .height('100%')

      // middle
      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        if (this.middle.title) {
          Text(this.middle.title)
            .fontColor(StyleConstants.BASE_STYLE.fontColor)
            .fontSize($r('app.float.font_size_20fp'))
            .fontWeight(FontWeight.Medium)
        }
      }
      .width('40%')
      .height('100%')

      // right
      Flex({ justifyContent: FlexAlign.End, alignItems: ItemAlign.Center }) {
        if (this.rightIconGroup.length !== 0) {
          ForEach(this.rightIconGroup, (item) => {
            Image(item.icon)
              .width($r('app.float.size_30vp'))
              .height($r('app.float.size_30vp'))
              .margin({ right: $r('app.float.size_10vp') })
              .onClick(() => item.event)
          }, (item, idx) => idx.toString())
        }
      }
      .width('30%')
      .height('100%')

    }
    .width('100%')
    .height($r('app.float.size_50vp'))
    .backgroundColor(StyleConstants.BASE_STYLE.backGroundColor)
  }
}