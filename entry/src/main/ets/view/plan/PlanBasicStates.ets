@Component
export struct PlanBasicStates {
    intake: number = 192
    expend: number = 150
    recommend: number = 1962
    build() {
        Row({space: 6}) {
            this.statesBuilder('饮食摄入', this.intake)
            Stack(){
                Progress({
                    value: this.intake,
                    total: this.recommend,
                    type: ProgressType.Ring
                })
                    .width(120)
                    .style({strokeWidth: 10})
                    .color('#02BD79')
                this.statesBuilder('还可以吃', (this.recommend - this.intake + this.expend), `推荐${this.recommend}`)
            }
            this.statesBuilder('运动消耗', this.expend)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({top: 30, bottom: 35})
    }

    @Builder statesBuilder(label: string, value: number, tips?: string) {
        Column({space: 6}) {
            Text(label)
                .fontColor('#676c7f')
                .fontWeight(600)
            Text(value.toFixed(0))
                .fontSize(20)
                .fontWeight(700)
            if(tips){
                Text(tips)
                    .fontSize(12)
                    .fontColor('#b5b5b7')
            }
        }
    }
}