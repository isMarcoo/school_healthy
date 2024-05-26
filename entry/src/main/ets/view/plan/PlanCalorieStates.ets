@Component
export struct PlanCalorieStates {
    carbon: number = 23
    protein: number = 9
    fat: number = 7

    recommendCarbon: number = 237
    recommendProtein: number = 68
    recommendFat: number = 53
    build() {
        Row({space: 6}) {
            this.statesBuilder(
                '碳水化合物',
                this.carbon,
                this.recommendCarbon,
                '#8de2c3'
            )
            this.statesBuilder(
                '蛋白质',
                this.protein,
                this.recommendProtein,
                '#ff9c97'
            )
            this.statesBuilder(
                '脂肪',
                this.fat,
                this.recommendFat,
                '#ffcc83'
            )
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({top: 30, bottom: 35})
    }

    @Builder statesBuilder(label: string, value: number, recommend: number, color: ResourceStr) {
        Column({space: 6}) {
            Stack() {
                Progress({
                    value: value,
                    total: recommend,
                    type: ProgressType.Ring
                })
                    .width(90)
                    .style({strokeWidth: 8})
                    .color(color)
                Column({space: 6}) {
                    Text('摄入推荐')
                        .fontSize(12)
                        .fontColor('#b5b5b7')
                    Text(`${value.toFixed(0)}/${recommend.toFixed(0)}`)
                        .fontSize(18)
                        .fontWeight(600)
                }
            }
            Text(`${label} (克)`)
                .fontSize(12)
                .fontColor('#b5b5b7')
        }
    }
}