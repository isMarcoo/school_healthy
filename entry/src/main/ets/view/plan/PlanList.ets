import { PlanListItem } from './PlanListItem'
import { PlanListInfo } from '../../model/PlanListInfo'

@Component
export struct PlanList {
    private totalDate: Array<string> = []

    aboutToAppear(){
        this.totalDate = new PlanListInfo().getData()
    }

    build() {
        Column({space: 6}) {
            Text('今日计划')
                .fontSize(28)
                .lineHeight(33)
                .fontWeight(FontWeight.Bold)
                .width('80%')
                .textAlign(TextAlign.Center)
                .margin({
                    top: 24,
                    bottom: 12
                })

            ForEach(this.totalDate, (item: string) => {
                PlanListItem({
                    task_content: item
                })
            })

        }
        .width('94%')
        .height('100%')
        .borderRadius(24)
    }
}