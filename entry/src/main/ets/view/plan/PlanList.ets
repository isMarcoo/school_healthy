import { PlanListItem } from './PlanListItem'
import { PlanListInfo } from '../../model/PlanListInfo'
import { getPlanList, uploadPlan } from '../../http/Api'
import { PlanItem } from '../../model/PlanItem'
import router from '@ohos.router'

@Component
export struct PlanList {
    scroller: Scroller = new Scroller()
    @State totalData: Array<PlanItem> = []
    @StorageLink('token') token: string = ''
    @StorageLink('refresh') @Watch('refreshF') refresh: boolean = false
    @StorageProp('selectedDate') @Watch('refreshF') selectedDate: number = 0


    async refreshF() {
        let response = await getPlanList(this.token, this.selectedDate)
        let data = response.data.data
        let planListInfo = new PlanListInfo()
        planListInfo.setData(data)
        this.totalData = planListInfo.getData()
    }

    async aboutToAppear(){
        let response = await getPlanList(this.token, this.selectedDate)
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

            Scroll(this.scroller) {
                Column({space: 6}) {
                    if (this.totalData) {
                        ForEach(this.totalData, (item: PlanItem) => {
                            PlanListItem({
                                planItem: item
                            })
                        })
                    }
                }
            }
            .scrollable(ScrollDirection.Vertical)
            .edgeEffect(EdgeEffect.Spring)
            .scrollBar(BarState.Off)
        }
        .width('94%')
        .height(355)
        .borderRadius(24)
    }
}