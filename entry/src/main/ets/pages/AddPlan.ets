import { addPlan } from '../http/Api'
import DateUtil from '../utils/DateUtil'
import header from '../view/Header'
import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { PlanItem } from '../model/PlanItem'
@Entry
@Component
struct AddPlan {
    @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
    @StorageProp('token') token: string = ''
    @State planName: string = ''
    @State planCost: number = 0
    @StorageLink('refresh') refresh: boolean = false
    build() {
        Column({space: 8}) {
            header('添加计划')
            Image($r('app.media.ic_back'))
                .height(25)
                .width(25)
                .alignSelf(ItemAlign.Start)
                .onClick(() => {
                    //todo:返回上⼀⻚⾯
                    router.back()
                })

            Text('计划名称')
            TextInput({text: this.planName})
                .onChange((value) => {
                    this.planName = value
                })
            Text('预计时长')
            TextInput()
                .onChange((value) => {
                    this.planCost = parseInt(value, 10)
                })

            Button('添加')
                .onClick(async () => {
                    let response = await addPlan(this.token, this.selectedDate, this.planName, this.planCost)
                    promptAction.showToast({ message: response.data.message })
                    this.refresh = !this.refresh
                    router.back()
                })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F6F7FB')
    }
}