import header from '../Header'
import { PlanHeader } from './PlanHeader'
import { PlanList } from './PlanList'
import { PlanStatsCard } from './PlanStatsCard'
import router from '@ohos.router'
@Component
export struct PlanPage {
    @StorageProp('token') token : string = ''

    build() {
        Column({space: 8}) {
            // 1.header
            header('计划打卡')
            // PlanHeader()

            if (this.token) {
                // 2.统计卡片
                PlanStatsCard()
                // 3.计划列表
                PlanList()
            } else {
                this.unLoginBuilder()
            }

        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F6F7Fb')
    }

    @Builder
    unLoginBuilder() {
        Column({ space: 30 }) {
            Image($r("app.media.ic_logo"))
                .width(177)
                .height(177)
                .borderRadius(100)

            Text('未登录暂无数据')
                .fontSize(14)
                .fontColor('#999999')

            Button('去登录')
                .fontColor(Color.White)
                .fontSize(14)
                .width(100)
                .height(34)
                .backgroundColor('#43C6A0')
                .onClick(() => router.pushUrl({ url: 'pages/LoginPage' }))
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
    }

}