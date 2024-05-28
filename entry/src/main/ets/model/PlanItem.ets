export class PlanItem {
    private planName: string = ''
    private planCost: number = 0

    setPlanName(planName: string) {
        this.planName = planName
    }

    setPlanCost(planCost: number) {
        this.planCost = planCost
    }

    getData() {
        return { 'planName': this.planName, 'planCost': this.planCost }
    }
}