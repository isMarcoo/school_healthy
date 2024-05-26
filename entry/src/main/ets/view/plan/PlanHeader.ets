@Component
export struct PlanHeader {
    build() {
        Row({space: 6}) {
            Search({placeholder: '搜索计划信息'})
                .textFont({size: 18})
                .layoutWeight(1)
            Badge({count: 1, position: BadgePosition.RightTop, style: {fontSize: 12}}) {
                Image($r('app.media.ic_public_email'))
                    .width(22)
            }

        }
        .width('94%')
    }
}