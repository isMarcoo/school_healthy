import { PlanItem } from './PlanItem'
import List from '@ohos.util.List'
export class PlanListInfo {
    private tasks: Array<PlanItem> = []

    init() {
        let plan = new PlanItem()
        plan.setPlanName('跑步')
        plan.setPlanCost(50)
        this.tasks.push(plan)
    }

    getData() : Array<PlanItem> {
        return this.tasks
    }

    setData(totalData) {
        for (let data of totalData) {
            let plan = new PlanItem()
            plan.setPlanName(data['planName'])
            plan.setPlanCost(data['planCost'])
            this.tasks.push(plan)
        }
    }
}