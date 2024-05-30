import { check } from '../../http/Api';
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import emitter from '@ohos.events.emitter';
@Component
struct StatItem {
    icon: Resource;
    name: string;
    @BuilderParam statComp: () => void
    fontColor: Color

    build() {
        Row({ space: 10 }) {
            Image(this.icon)
                .height(14)
                .width(14)
            Text(this.name)
                .fontWeight(FontWeight.Medium)
                .fontSize(14)
                .fontColor(this.fontColor)
            Blank()
            this.statComp()
        }
        .width('100%')
        .height(30)
    }
}

@CustomDialog
export struct CheckDialog {
    @Prop todayTask: number
    @Prop completedTask: number
    @Prop completedTime: number
    @StorageProp('token') token: string = ''
    @StorageLink('checked') checked: boolean = false
    @StorageProp('selectedDate') selectedDate: number = 0

    controller: CustomDialogController
    build() {
        Column({space: 10}) {
            Image($r('app.media.ic_close'))
                .width(25)
                .height(25)
                .alignSelf(ItemAlign.End)
                .onClick(() => {
                    this.controller.close()
                })
            Column({space: 10}) {
                Image($r('app.media.img_check_bg'))
                    .width('100%')
                    .borderRadius(10)
                StatItem({
                    icon: $r('app.media.ic_timer'),
                    name: '锻炼时长',
                    fontColor: Color.Black
                }) {
                    Text(this.completedTime.toString())
                }
                StatItem({
                    icon: $r('app.media.ic_timer'),
                    name: '完成率',
                    fontColor: Color.Black
                }) {
                    Text((this.completedTask === 0 ? 0 : this.completedTask/this.todayTask*100).toFixed() + '%')
                }
                StatItem({
                    icon: $r('app.media.ic_timer'),
                    name: '任务',
                    fontColor: Color.Black
                }) {
                    Text(this.completedTask + '/' + this.todayTask)
                }
                Divider()
                Button('立即打卡')
                    .backgroundColor(Color.Black)
                    .fontColor(Color.White)
                    .borderColor(Color.Black)
                    .margin({top: 20})
                    .onClick(async () => {
                        if (this.completedTask == 0){
                            promptAction.showToast({ message: "请完成任务再打卡" })
                            this.controller.close()
                        } else {
                            let response = await check(this.token, this.selectedDate, this.completedTime, this.todayTask, this.completedTask)
                            let message = response.data.message
                            promptAction.showToast({ message: message })
                            this.checked = true
                            emitter.emit({eventId: 1})
                            this.controller.close()
                        }
                    })
            }
            .backgroundColor(Color.White)
            .width('100%')
            .padding(20)
            .borderRadius(10)
        }
        .backgroundColor(Color.Transparent)
        .width('80%')
    }
}