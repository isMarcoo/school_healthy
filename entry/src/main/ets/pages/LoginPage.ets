import router from '@ohos.router'
import { login } from '../http/Api'

@Entry
@Component
struct LoginPage {
  @State username:string=''
  @State password:string=''
  @StorageLink('token') token:string = ''
  @StorageLink('refresh') refresh: boolean = false

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
            this.refresh = !this.refresh
            router.back()
          })
        Row() {
          Text('没有账号？')
            .fontSize(10)
            .fontColor('#546B9D')
          Text('点此注册')
            .fontSize(10)
            .fontColor('#00B3FF')
            .onClick(() => {
              router.pushUrl({url: 'pages/RegisterPage'})
            })
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