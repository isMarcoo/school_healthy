export class PlanListInfo {
    private tasks: Array<string> = [
        "跑步",
        "吃饭",
        "跳绳"
    ]

    getData() : Array<string> {
        return this.tasks
    }
}