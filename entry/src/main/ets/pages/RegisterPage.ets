import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { Constants } from 'ets/common/Constants'
import { StyleConstants } from 'ets/common/StyleConstants'
import HeaderNavigation from 'ets/common/HeaderNavigation'
import {nonNullValidation} from 'ets/common/utils'



@Entry
@Component
struct Register {

  // 用户账号
  @State username: string = ''

  // 用户密码
  @State password: string = ''

  // 用户邮箱
  @State email:string = ''

  // 验证码
  @State code:string = ''

  // 获取验证码
  @State  getCode:Resource | null = $r('app.string.get_v_code')

  // 验证码状态
  @State codeStata:boolean = false

  // 隐私协议
  @State agreement: boolean = false

  // 是否显示LoadingProgress
  @State isShowLoadingProgress:boolean = false

  // 验证码过期时间
  @State reckonTimer:number = 0

  // 定时器
  @State timer:number = 0


  // 注册
  handleRegister():void{
    if (!nonNullValidation([this.password,this.username,this.email,this.code])) {
      promptAction.showToast({
        message: $r('app.string.empty_tips'),
        duration: 2000,
      });
    } else {
      if (!this.agreement) {
        promptAction.showToast({
          message: $r('app.string.agreement'),
          duration: 2000,
        });
        return
      }
      this.isShowLoadingProgress = true;
      setTimeout(() => {
        this.isShowLoadingProgress = false;
        router.replaceUrl({ url: 'pages/FirstPage' });
      }, Constants.DELAY_TIME_5s);
    }

  }

  // 获取验证码
  getVerificationCode():void{
    // 重新给倒计时赋值
    this.reckonTimer = 60
    this.getCode = $r('app.string.send_code');
    this.code = '123456'
    this.codeStata = true
    // 验证码过期
    this.timer = setInterval(()=>{
      this.reckonTimer--
      if (this.reckonTimer <= 0) {
        this.codeStata = false
        this.getCode = $r('app.string.refresh_code');
        clearInterval(this.timer)
      }
    },1000)

  }

  build() {
    Column() {
      HeaderNavigation({
        leftIconGroup: {
          icon: Constants.BACk,
          event: () => {
            router.replaceUrl({ url: 'pages/FirstPage' })
          }
        },
        middle: {
          title:$r('app.string.register')
        }
      })

      Column() {

        // 标题
        Column() {
          Text($r('app.string.register_title'))
            .TextStyle()
            .fontSize($r('app.float.font_size_30fp'))
          Text($r('app.string.register_title_info'))
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

        // 隐私协议
        this.Agreement()

      }
      .alignItems(HorizontalAlign.Start)
      .width('80%')
      .height('80%')

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    // .backgroundImage(PageConstants.LOGIN_BG, ImageRepeat.NoRepeat)
    // .backgroundImageSize(ImageSize.Cover)
  }


  /**
   * 注册表单
   */
  @Builder
  Form() {

    TextInput({ placeholder: $r('app.string.user') })
      .inputStyle()
      .onChange((value: string) => {
        this.username = value;
      })

    TextInput({ placeholder: $r('app.string.password')})
      .type(InputType.Password)
      .inputStyle()
      .onChange((value: string) => {
        this.password = value;
      })

    TextInput({ placeholder: $r('app.string.email')})
      .type(InputType.Email)
      .inputStyle()
      .onChange((value: string) => {
        this.email = value;
      })

    TextInput({ placeholder: $r('app.string.v_code')})
      .inputStyle()
      .onChange((value: string) => {
        this.code = value;
      })


    Flex({alignItems:ItemAlign.Center,justifyContent:FlexAlign.Center}){
      Button({ type: ButtonType.Capsule, stateEffect: true }) {
        Row() {
          if (this.codeStata){
            LoadingProgress()
              .width($r('app.float.size_30vp'))
              .height($r('app.float.size_30vp'))
              .color($r('app.color.baseGreen'))
          }
          Text(this.getCode)
            .fontColor(StyleConstants.BASE_STYLE.fontColor)
            .fontWeight(FontWeight.Bold)
            .fontSize($r('app.float.font_size_14fp'))

          if (this.codeStata){
            Text(`(${this.reckonTimer})`)
              .fontColor(Color.Blue)
              .fontWeight(FontWeight.Bold)
              .fontSize($r('app.float.font_size_12fp'))
          }
        }
        .alignItems(VerticalAlign.Center)

      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Transparent)
      .onClick(()=> {
        if (!this.codeStata) {
          this.getVerificationCode();
        }
      })
    }
    .margin({top:StyleConstants.SPACING })
    .height($r('app.float.size_40vp'))



  }

  /**
   * 注册按钮
   */
  @Builder
  RegisterButton(){
    Button( { type: ButtonType.Capsule }){
      Row() {
        if (!this.isShowLoadingProgress){
          Text($r('app.string.register'))
            .fontSize('16fp')
            .fontColor(StyleConstants.BASE_GREY)
        }else{
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
    .onClick(()=>this.handleRegister())
  }

  /**
   * 隐私协议
   */
  @Builder
  Agreement() {
    Row() {
      Toggle({ type: ToggleType.Checkbox, isOn: this.agreement })
        .size({ width: 20, height: 20 })
        .selectedColor(StyleConstants.BASE_STYLE.fontColor)
        .onChange((isOn: boolean) => {
          this.agreement = isOn
        })
      Text('已阅读并同意')
        .fontSize($r('app.float.font_size_14fp'))
      Text('《服务条款》')
        .fontSize($r('app.float.font_size_14fp'))
        .fontColor(StyleConstants.BASE_STYLE.fontColor)
      Text('与')
        .fontSize($r('app.float.font_size_14fp'))
      Text('《隐私权政策》')
        .fontSize($r('app.float.font_size_14fp'))
        .fontColor(StyleConstants.BASE_STYLE.fontColor)
    }
    .margin({ top: StyleConstants.SPACING })

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
  .margin({ top:StyleConstants.SPACING})
}

// 文本样式
@Extend(Text) function TextStyle() {
  .fontColor(StyleConstants.BASE_STYLE.fontColor)
  .fontWeight(FontWeight.Bold)
  .margin({ top: StyleConstants.SPACING})
}