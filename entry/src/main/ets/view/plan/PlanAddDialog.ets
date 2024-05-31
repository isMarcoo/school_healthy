import promptAction from '@ohos.promptAction'
import { addPlan } from '../../http/Api'
import DateUtil from '../../utils/DateUtil'
import header from '../Header'
import emitter from '@ohos.events.emitter'
@Preview
@CustomDialog
export default  struct PlanAddDialog {
    controller: CustomDialogController
    @State planName: string = ''
    @State planCost: number = 0
    @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
    @StorageProp('token') token: string = ''

    build() {
        Column({space: 12}) {
            Image($r('app.media.ic_close'))
                .width(25)
                .height(25)
                .alignSelf(ItemAlign.End)
                .onClick(() => {
                    this.controller.close()
                })
            Column({space: 12}) {
                Text('添加计划')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                    .textAlign(TextAlign.Center)
                Row({space: 10}) {
                    Text('计划名称')
                        .fontSize(16)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(Color.Black)
                    TextInput({placeholder: "请输入计划名称"})
                        .onChange((value) => {
                            this.planName = value
                        })
                        .inputStyle()
                }
                .padding(20)

                Row({space: 10}) {
                    Text('预计时长')
                        .fontSize(16)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(Color.Black)
                    TextInput({placeholder: "请输入预计时长"})
                        .onChange((value) => {
                            this.planCost = parseInt(value, 10)
                        })
                        .inputStyle()
                }
                .padding({
                    top: 10,
                    left: 20,
                    bottom: 20,
                    right: 20

                })

                Button('添加')
                    .buttonStyle('#43C6A0', Color.White)
                    .onClick(async () => {
                        let response = await addPlan(this.token, this.selectedDate, this.planName, this.planCost)
                        promptAction.showToast({ message: response.data.message })
                        emitter.emit({eventId: 2})
                        this.controller.close()
                    })
                    .margin({bottom: 20})
            }
            .padding({top: 50})
            .backgroundColor(Color.White)
            .borderRadius(20)


        }
        .padding(20)
        .borderRadius(10)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(Color.Transparent)
    }

}

@Extend(TextInput) function inputStyle() {
    .height(40)
    .layoutWeight(1)
    .fontSize(14)
    .backgroundColor(Color.Transparent)
    .borderColor('#43C6A0')
    .borderWidth(1)
}

@Extend(Button) function buttonStyle(bgColor: ResourceColor, fontColor: ResourceColor) {
    .type(ButtonType.Normal)
    .fontSize(14)
    .fontWeight(FontWeight.Medium)
    .borderWidth(0)
    .borderRadius(5)
    .backgroundColor(bgColor)
    .fontColor(fontColor)
    .padding({
        top: 10,
        bottom: 10,
        left: 20,
        right: 20
    })
}

@Styles function formBgStyle() {
    .backgroundColor(Color.White)
    .padding(30)
    .borderRadius(20)
    .shadow({
        radius: 15,
        color: '#999999',
        offsetX: 5,
        offsetY: 5
    })
}