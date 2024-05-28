import { PlanListItem } from './PlanListItem'
import { PlanListInfo } from '../../model/PlanListInfo'
import { getPlanList } from '../../http/Api'
import { PlanItem } from '../../model/PlanItem'

@Component
export struct PlanList {
    @State totalData: Array<PlanItem> = []
    @StorageLink('token') token: string = ''

    async aboutToAppear(){
        let response = await getPlanList(this.token)
        let data = response.data.data
        let planListInfo = new PlanListInfo()
        planListInfo.setData(data)
        this.totalData = planListInfo.getData()
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

            if (this.totalData) {
                ForEach(this.totalData, (item: PlanItem) => {
                    PlanListItem({
                        task_content: item.getData()['planName']
                    })
                })
            }


        }
        .width('94%')
        .height('100%')
        .borderRadius(24)
    }
}