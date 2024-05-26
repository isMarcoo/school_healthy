import DateUtil from '../../utils/DateUtil'
import { PlanBasicStates } from './PlanBasicStates'
import { PlanCalorieStates } from './PlanCalorieStates'
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
                    .fontColor('#5d907a')
                Image($r('app.media.ic_public_spinner'))
                    .width(20)
                    .fillColor('#5d907a')
            }
            .padding(6)
            .onClick(() => this.controller.open())

            Swiper() {
                PlanBasicStates()
                PlanCalorieStates()
            }
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(18)
            .indicatorStyle({selectedColor: '#02BD79'})
        }
        .width('94%')
        .backgroundColor('#d6eee1')
        .borderRadius(18)
    }
}