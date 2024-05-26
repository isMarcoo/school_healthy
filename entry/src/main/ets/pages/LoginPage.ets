import router from '@ohos.router'
import { login } from '../http/Api'
@Entry
@Component
struct LoginPage {
  @State username:string=''
  @State password:string=''
  @StorageLink('token') token:string = ''

  build() {
    Column() {
      Image($r('app.media.ic_back'))
        .backStyle()
        .alignSelf(ItemAlign.Start)
        .onClick(() => {
          //todo:返回上⼀⻚⾯
          router.back()
        })
      Blank()
      Column() {
        Text('欢迎登录')
          .titleStyle()
        Row() {
          Image($r("app.media.ic_phone"))
            .iconStyle()
          TextInput({ placeholder: '请输⼊账号',text:this.username })
            .inputStyle()
            .onChange((value)=>{
              this.username=value;
            })
        }.margin({ top: 30 })
        Divider()
          .color(Color.Black)
        Row() {
          Image($r("app.media.ic_code"))
            .iconStyle()
          TextInput({ placeholder: '请输⼊密码',text:this.password })
            .inputStyle()
            .onChange((value)=>{
              this.password=value;
            })
        }.margin({ top: 20 })
        Divider()
          .color(Color.Black)
        Button('⽴即登录')
          .buttonStyle(Color.Black, Color.White)
          .width('100%')
          .margin({ top: 50 })
          .onClick(async () => {
            //登录
            let response = await login(this.username, this.password)
            this.token = response.data.token

          })
        Row() {
          Text('登录即表示已同意')
            .fontSize(10)
            .fontColor('#546B9D')
          Text('《⽤户使⽤协议》')
            .fontSize(10)
            .fontColor('#00B3FF')
        }.margin({ top: 20 })
      }.formBgStyle()
      Row({ space: 10 }) {
        Image($r('app.media.ic_logo'))
          .width(36)
          .height(36)
        Text('健康运动')
          .fontColor('#546B9D')
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
      }.margin({ top: 70 })
      Text('Developed By BJTUSSE')
        .fontSize(12)
        .fontColor('#546B9D')
        .margin(10)
    }
    .loginBgStyle()
  }
}

@Styles function loginBgStyle() {
  .width('100%')
  .height('100%')
  .backgroundImage($r("app.media.img_login_bg"))
  .backgroundImageSize({ width: '100%', height: '100%' })
  .padding({
    top: 30, bottom: 30, left: 20, right: 20
  })
}
@Styles function backStyle() {
  .width(25)
  .height(25)
}
@Styles function formBgStyle() {
  .backgroundColor(Color.White)
  .padding(30)
  .borderRadius(20)
}
@Extend(Text) function titleStyle() {
  .fontWeight(FontWeight.Bold)
  .fontSize(22)
}
@Styles function iconStyle() {
  .width(24)
  .height(24)
}
@Extend(TextInput) function inputStyle() {
  .height(40)
  .layoutWeight(1)
  .fontSize(14)
  .backgroundColor(Color.Transparent)
}
@Extend(Button) function buttonStyle(bgColor: ResourceColor, fontColor: ResourceColor) {
  .type(ButtonType.Normal)
  .fontSize(14)
  .fontWeight(FontWeight.Medium)
  .borderWidth(1)
  .borderRadius(5)
  .backgroundColor(bgColor)
  .fontColor(fontColor)
}

// import router from '@ohos.router';
// import { StyleConstants } from 'ets/common/StyleConstants';

// @Entry
// @Component
// struct FirstPage {
//   build() {
    // Column() {
    //   Text('健康运动')
    //     .margin({ bottom: 20 })
    //     .fontColor(StyleConstants.BASE_STYLE.fontColor)
    //     .fontSize(40)
    //     .margin({
    //       top: 60,
    //       bottom: 20
    //     })
    //     .textAlign(TextAlign.Center)
    //
    //   Image($r('app.media.app_logo'))
    //     .width(300)
    //     .height(300)
    //     .interpolation(ImageInterpolation.High)
    //     .margin({
    //       bottom: 60
    //     })
    //     .borderRadius(50)
    //
    //   Column() {
    //     Button({ type: ButtonType.Capsule }) {
    //       Text($r('app.string.login'))
    //         .fontSize('16fp')
    //         .fontColor(StyleConstants.BASE_WHITE)
    //     }
    //     .width(StyleConstants.FULL_BUTTON)
    //     .backgroundColor(StyleConstants.BASE_STYLE.fontColor)
    //     .height(StyleConstants.INPUT_HEIGHT)
    //     .margin({ bottom:5})
    //     .onClick(() => router.replaceUrl({ url: 'pages/LoginPage' })) // Navigate to Login Page
    //
    //     Text($r('app.string.have_an_account'))
    //       .margin({ bottom: 20 })
    //       .onClick(() => router.replaceUrl({ url: 'pages/LoginPage' }))
    //       .fontColor(StyleConstants.BASE_STYLE.fontColor)
    //       .fontSize(14)
    //
    //     Button({ type: ButtonType.Capsule }) {
    //       Text($r('app.string.register'))
    //         .fontSize('16fp')
    //         .fontColor(StyleConstants.BASE_WHITE)
    //     }
    //     .width(StyleConstants.FULL_BUTTON)
    //     .margin({ bottom:5})
    //     .backgroundColor(StyleConstants.BASE_STYLE.fontColor)
    //     .height(StyleConstants.INPUT_HEIGHT)
    //     .onClick(() => router.replaceUrl({ url: 'pages/RegisterPage' }))
    //
    //     Text($r('app.string.no_account'))
    //       .onClick(() => router.replaceUrl({ url: 'pages/RegisterPage' }))
    //       .fontColor(StyleConstants.BASE_STYLE.fontColor)
    //       .fontSize(14)
    //   }
    //   .alignItems(HorizontalAlign.Center)
    //   .height('60%')
    //
    //
    // }
    // .width('100%')
    // .height('100%')
    // .justifyContent(FlexAlign.SpaceAround)
    // .alignItems(HorizontalAlign.Center)
//   }
// }
