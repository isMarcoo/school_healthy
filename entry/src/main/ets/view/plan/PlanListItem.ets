import { deletePlan, uploadPlan } from '../../http/Api';
import { PlanItem } from '../../model/PlanItem';
import emitter from '@ohos.events.emitter';
@Component
export struct PlanListItem {
    @ObjectLink planItem: PlanItem
    @State delete: boolean = false
    @StorageProp('token') token: string = ''
    @StorageProp('selectedDate') selectedDate: number = 0
    @StorageLink('refresh') refresh: boolean = false

    build() {
        Row() {
            if (this.delete){
                Button({ type: ButtonType.Normal }){
                    Text('删除')
                        .fontColor(Color.White)
                }
                .height(40)
                .width(50)
                .margin({left: 10})
                .borderRadius(12)
                .backgroundColor(Color.Red)
                .onClick(() => {
                    this.delete = false
                    deletePlan(this.token, this.selectedDate, this.planItem.planName)
                    emitter.emit({eventId: 2})
                })
            }
            if (this.planItem.isComplete) {
                this.CreateIcon($r('app.media.ic_accuracy'))
            }else {
                this.CreateIcon($r('app.media.ic_accuracy_white'))
            }
            Text(this.planItem.planName)
                .fontSize(20)
                .fontWeight(500)
                .decoration({type: this.planItem.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None})
                .opacity(this.planItem.isComplete ? 0.5 : 1)
        }
        .borderRadius(24)
        .backgroundColor(Color.White)
        .width('94%')
        .height(50)
        .gesture(
            LongPressGesture({repeat: false})
                .onAction(() => {
                    if (this.delete)
                        this.delete = false
                    else
                        this.delete = true
                })
        )
        .onClick(() => {
            this.planItem.isComplete =  !this.planItem.isComplete
            uploadPlan(this.token, this.planItem.planName, this.planItem.isComplete, this.selectedDate)
            emitter.emit({eventId: 2})
        })
    }

    @Builder CreateIcon(icon: Resource) {
        Image(icon)
            .width(28)
            .height(28)
            .objectFit(ImageFit.Contain)
            .margin(20)
    }
}