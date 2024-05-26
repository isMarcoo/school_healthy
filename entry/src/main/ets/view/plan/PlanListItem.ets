@Component
export struct PlanListItem {
    private task_content: string;
    @State isComplete: boolean = false
    build() {
        Row() {
            if (this.isComplete) {
                this.CreateIcon($r('app.media.ic_accuracy'))
            }else {
                this.CreateIcon($r('app.media.ic_accuracy_white'))
            }

            Text(this.task_content)
                .fontSize(20)
                .fontWeight(500)
                .decoration({type: this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None})
                .opacity(this.isComplete ? 0.5 : 1)
        }
        .borderRadius(24)
        .backgroundColor(Color.White)
        .width('94%')
        .height(50)
        .onClick(() => {
            this.isComplete = !this.isComplete
        })
    }

    @Builder CreateIcon(icon: Resource) {
        Image(icon)
            .width(28)
            .height(28)
            .objectFit(ImageFit.Contain)
            .margin(20)
    }
}