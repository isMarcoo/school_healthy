@Observed
export class PlanItem {
    private planName: string = ''
    private planCost: number = 0
    private isComplete: boolean = false

    setPlanName(planName: string) {
        this.planName = planName
    }

    setPlanCost(planCost: number) {
        this.planCost = planCost
    }

    setIsComplete(isComplete: boolean) {
        this.isComplete = isComplete
    }

    getData() {
        return { 'planName': this.planName, 'planCost': this.planCost , 'isComplete': this.isComplete}
    }
}