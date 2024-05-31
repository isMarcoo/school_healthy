import DateUtil from '../../utils/DateUtil'
import { PlanBasicStates } from './PlanBasicStates'
import { PlanAllStates } from './PlanAllStates'
import PlanPickDialog from './PlanPickDialog'

@Component
export struct PlanStatsCard {
    @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

    controller: CustomDialogController = new CustomDialogController({
        builder: PlanPickDialog({selectedDate: new Date(this.selectedDate)})
    })

    build() {
        Column() {
            Row() {
                Text(DateUtil.formatDate(this.selectedDate))
                    .fontColor(Color.Black)
                Image($r('app.media.ic_public_spinner'))
                    .width(20)
                    .fillColor(Color.Black)
            }
            .padding(6)
            .onClick(() => this.controller.open())

            Swiper() {
                PlanBasicStates()
                PlanAllStates()
            }
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(18)
            .indicatorStyle({selectedColor: '#02BD79'})
        }
        .width('94%')
        .backgroundColor('#E9EAEC')
        .borderRadius(18)
    }
}