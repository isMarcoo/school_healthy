import { PlanItem } from './PlanItem'
import List from '@ohos.util.List'
export class PlanListInfo {
    private tasks: Array<PlanItem> = []

    init() {
        let plan = new PlanItem()
        plan.planName = '跑步'
        plan.planCost = 50
        this.tasks.push(plan)
    }

    getData() : Array<PlanItem> {
        return this.tasks
    }

    setData(totalData) {
        for (let data of totalData) {
            let plan = new PlanItem()
            plan.planName = data['planName']
            plan.planCost = data['planCost']
            if (data['isComplete'] == "False")
                plan.isComplete = false
            else
                plan.isComplete = true
            this.tasks.push(plan)
        }
    }
}