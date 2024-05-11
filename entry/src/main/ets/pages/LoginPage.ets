import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { Constants } from 'ets/common/Constants'
import { StyleConstants } from 'ets/common/StyleConstants'
import HeaderNavigation from 'ets/common/HeaderNavigation'
import { nonNullValidation } from 'ets/common/utils'


@Entry
@Component
struct LoginPage {

  // 用户账号
  @State username: string = ''

  // 用户密码
  @State password: string = ''


  // 是否显示LoadingProgress
  @State isShowLoadingProgress: boolean = false

  // 验证码过期时间
  @State reckonTimer: number = 0

  // 定时器
  @State timer: number = 0


  // 注册
  handleRegister(): void {
    if (!nonNullValidation([this.username, this.password])) {
      promptAction.showToast({
        message: $r('app.string.input_empty_tips'),
        duration: 2000,
      });
    } else {

      this.isShowLoadingProgress = true;
      setTimeout(() => {
        this.isShowLoadingProgress = false;
        router.replaceUrl({ url: 'pages/FirstPage' });
      }, Constants.DELAY_TIME_5s);
    }

  }

  build() {
    Column() {
      HeaderNavigation({
        leftIconGroup: {
          icon: Constants.BACk,
          event: () => {
            router.replaceUrl({ url: 'pages/FirstPage' })
          }
        }
      ,
        middle: {
          title: $r('app.string.login')
        }
      })

      Column() {

        // 标题
        Column() {
          Text($r('app.string.login_title'))
            .TextStyle()
            .fontSize($r('app.float.font_size_30fp'))
          Text($r('app.string.login_title_info'))
            .fontSize($r('app.float.font_size_16fp'))
            .TextStyle()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .height('20%')

        // 表单
        Column() {
          this.Form()
        }
        .justifyContent(FlexAlign.Center)
        .height('60%')

        // 提交按钮
        Flex({ justifyContent: FlexAlign.Center }) {
          this.RegisterButton()
        }

      }
      .alignItems(HorizontalAlign.Start)
      .width('80%')
      .height('80%')

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 登录表单
   */
  @Builder
  Form() {

    TextInput({ placeholder: $r('app.string.user') })
      .inputStyle()
      .onChange((value: string) => {
        this.username = value;
      })

    TextInput({ placeholder: $r('app.string.password') })
      .type(InputType.Password)
      .inputStyle()
      .onChange((value: string) => {
        this.password = value;
      })
  }

  /**
   * 登录按钮
   */
  @Builder
  RegisterButton() {
    Button({ type: ButtonType.Capsule }) {
      Row() {
        if (!this.isShowLoadingProgress) {
          Text($r('app.string.login'))
            .fontSize('16fp')
            .fontColor(StyleConstants.BASE_GREY)
        } else {
          LoadingProgress()
            .width(30)
            .height(30)
            .margin({ left: 12 })
            .color(StyleConstants.BASE_GREY)
        }
      }
    }
    .width(StyleConstants.FULL_BUTTON)
    .backgroundColor(StyleConstants.BASE_STYLE.fontColor)
    .height(StyleConstants.INPUT_HEIGHT)
    .onClick(() => this.handleRegister())
  }
}


// 输入框样式
@Extend(TextInput) function inputStyle() {
  .fontColor(StyleConstants.BASE_STYLE.fontColor)
  .caretColor(StyleConstants.BASE_STYLE.fontColor)
  .placeholderColor(StyleConstants.BASE_STYLE.fontColor)
  .width(StyleConstants.FULL_WIDTH)
  .height(StyleConstants.INPUT_HEIGHT)
  .fontSize($r('app.float.font_size_18fp'))
  .backgroundColor(StyleConstants.BASE_STYLE.inputBackGroundColor)
  .margin({ top: StyleConstants.SPACING })
}

// 文本样式
@Extend(Text) function TextStyle() {
  .fontColor(StyleConstants.BASE_STYLE.fontColor)
  .fontWeight(FontWeight.Bold)
  .margin({ top: StyleConstants.SPACING })
}