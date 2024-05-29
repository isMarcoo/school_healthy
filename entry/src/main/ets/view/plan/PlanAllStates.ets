import { getTime } from '../../http/Api'
@Component
export struct PlanAllStates {
    @State allTask: number = 0
    @State allTaskCompleted: number = 0
    @State allTime: number = 0
    @State allTimeCompleted: number = 0
    @State allDay: number = 0

    @StorageLink('token') token: string = ''
    @StorageLink('refresh') @Watch('refreshF') refresh: boolean = false
    @StorageLink('upload') @Watch('uploadF') upload: boolean = false

    async uploadF() {
        let response = await getTime(this.token)
        let data = response.data.data
        this.allTask = data['allTask']
        this.allTaskCompleted = data['allTaskCompleted']
        this.allTime = data['allTime']
        this.allTimeCompleted = data['allTimeCompleted']
        this.allDay = data['allDay']
    }

    async refreshF() {
        let response = await getTime(this.token)
        let data = response.data.data
        this.allTask = data['allTask']
        this.allTaskCompleted = data['allTaskCompleted']
        this.allTime = data['allTime']
        this.allTimeCompleted = data['allTimeCompleted']
        this.allDay = data['allDay']
    }

    async aboutToAppear(){
        let response = await getTime(this.token)
        let data = response.data.data
        this.allTask = data['allTask']
        this.allTaskCompleted = data['allTaskCompleted']
        this.allTime = data['allTime']
        this.allTimeCompleted = data['allTimeCompleted']
        this.allDay = data['allDay']
    }


    build() {
        Row({space: 6}) {
            this.ProgressBuilder({
                label: '今日任务',
                value: this.allTaskCompleted,
                recommend: this.allTask,
                color: '#ffcc83'
            })
            this.statesBuilder({
                label: '总运动天数',
                value: this.allDay
            })
            this.ProgressBuilder({
                label: '今日任务',
                value: this.allTimeCompleted,
                recommend: this.allTime,
                color: '#ffcc83'
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({top: 30, bottom: 35})
    }

    @Builder statesBuilder($$: {label: string, value: number, tips?: string}) {
        Column({space: 18}) {
            Text($$.label)
                .fontColor('#676c7f')
                .fontWeight(600)
            Text($$.value.toFixed(0))
                .fontSize(20)
                .fontWeight(700)
            if($$.tips){
                Text($$.tips)
                    .fontSize(12)
                    .fontColor('#b5b5b7')
            }
        }
    }

    @Builder ProgressBuilder($$: {label: string, value: number, recommend: number, color: ResourceStr}) {
        Column({space: 6}) {
            Stack() {
                Progress({
                    value: $$.value,
                    total: $$.recommend,
                    type: ProgressType.Ring
                })
                    .width(90)
                    .style({strokeWidth: 8})
                    .color($$.color)
                Column({space: 6}) {
                    Text('摄入推荐')
                        .fontSize(12)
                        .fontColor('#b5b5b7')
                    Text(`${$$.value.toFixed(0)}/${$$.recommend.toFixed(0)}`)
                        .fontSize(18)
                        .fontWeight(600)
                }
            }
            Text(`${$$.label} (克)`)
                .fontSize(12)
                .fontColor('#b5b5b7')
        }
    }
}