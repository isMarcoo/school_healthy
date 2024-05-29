import { deletePlan } from '../../http/Api';
import { PlanItem } from '../../model/PlanItem';
@Component
export struct PlanListItem {
    @ObjectLink planItem: PlanItem
    @StorageLink('upload') upload: boolean = false
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
                    deletePlan(this.token, this.selectedDate, this.planItem.getData().planName)
                    this.refresh = !this.refresh
                })
            }
            if (this.planItem.getData()['isComplete']) {
                this.CreateIcon($r('app.media.ic_accuracy'))
            }else {
                this.CreateIcon($r('app.media.ic_accuracy_white'))
            }
            Text(this.planItem.getData()['planName'])
                .fontSize(20)
                .fontWeight(500)
                .decoration({type: this.planItem.getData()['isComplete'] ? TextDecorationType.LineThrough : TextDecorationType.None})
                .opacity(this.planItem.getData()['isComplete'] ? 0.5 : 1)
        }
        .borderRadius(24)
        .backgroundColor(Color.White)
        .width('94%')
        .height(50)
        .gesture(
            LongPressGesture({repeat: false})
                .onAction(() => {
                    this.delete = true
                })
        )
        .onClick(() => {
            this.planItem.setIsComplete(!this.planItem.getData()['isComplete'])
            this.upload = true
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