import { PlanHeader } from './PlanHeader'
import { PlanList } from './PlanList'
import { PlanStatsCard } from './PlanStatsCard'
@Component
export struct PlanPage {
    build() {
        Column({space: 8}) {
            // 1.header
            PlanHeader()
            // 2.统计卡片
            PlanStatsCard()
            // 3.计划列表
            PlanList()
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F6F7Fb')
    }
}