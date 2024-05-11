import router from '@ohos.router';
import { StyleConstants } from 'ets/common/StyleConstants';

@Entry
@Component
struct FirstPage {
  build() {
    Column() {
      Text($r('app.string.welcome'))
        .margin({ bottom: 20 })
        .fontColor(StyleConstants.BASE_STYLE.fontColor)
        .fontSize(50)
        .margin({
          top: 60,
          bottom: 20
        })
        .textAlign(TextAlign.Center)

      Image($r('app.media.app_logo'))
        .width(300)
        .height(300)
        .interpolation(ImageInterpolation.High)
        .margin({
          bottom: 60
        })
        .borderRadius(50)

      Column() {
        Button({ type: ButtonType.Capsule }) {
          Text($r('app.string.login'))
            .fontSize('16fp')
            .fontColor(StyleConstants.BASE_WHITE)
        }
        .width(StyleConstants.FULL_BUTTON)
        .backgroundColor(StyleConstants.BASE_STYLE.fontColor)
        .height(StyleConstants.INPUT_HEIGHT)
        .margin({ bottom:5})
        .onClick(() => router.replaceUrl({ url: 'pages/LoginPage' })) // Navigate to Login Page

        Text($r('app.string.have_an_account'))
          .margin({ bottom: 20 })
          .onClick(() => router.replaceUrl({ url: 'pages/LoginPage' }))
          .fontColor(StyleConstants.BASE_STYLE.fontColor)

        Button({ type: ButtonType.Capsule }) {
          Text($r('app.string.register'))
            .fontSize('16fp')
            .fontColor(StyleConstants.BASE_WHITE)
        }
        .width(StyleConstants.FULL_BUTTON)
        .margin({ bottom:5})
        .backgroundColor(StyleConstants.BASE_STYLE.fontColor)
        .height(StyleConstants.INPUT_HEIGHT)
        .onClick(() => router.replaceUrl({ url: 'pages/RegisterPage' }))

        Text($r('app.string.no_account'))
          .onClick(() => router.replaceUrl({ url: 'pages/RegisterPage' }))
          .fontColor(StyleConstants.BASE_STYLE.fontColor)
      }
      .alignItems(HorizontalAlign.Center)
      .height('60%')

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(HorizontalAlign.Center)
  }
}
