import { check, getConsecutiveDay, getTime, getTimeByDay } from '../../http/Api'
import emitter from '@ohos.events.emitter'
@Component
export struct PlanBasicStates {
    @State todayTask: number = 0
    @State completedTask: number = 0
    @State todayTime: number = 0
    @State completedTime: number = 0
    @State consecutiveDay: number = 0

    @StorageLink('token') token: string = ''
    @StorageProp('selectedDate') selectedDate: number = 0

    async withChecked(){
        this.consecutiveDay = 0
        let consecutiveResponse = await getConsecutiveDay(this.token)
        this.consecutiveDay = consecutiveResponse.data.data
    }

    async refreshF() {
        let response = await getTimeByDay(this.token, this.selectedDate)
        let data = response.data.data
        this.todayTime = data['totalTime']
        this.completedTime = data['completedTime']
        this.todayTask = data['todayTask']
        this.completedTask = data['completedTask']
    }

    async aboutToAppear(){
        let response = await getTimeByDay(this.token, this.selectedDate)
        let data = response.data.data
        this.todayTime = data['totalTime']
        this.completedTime = data['completedTime']
        this.todayTask = data['todayTask']
        this.completedTask = data['completedTask']

        let consecutiveResponse = await getConsecutiveDay(this.token)
        this.consecutiveDay = consecutiveResponse.data.data

        emitter.on({eventId: 2}, () => {
            this.refreshF()
        })
        emitter.on({eventId: 1}, () => {
            this.withChecked()
        })
        emitter.on({eventId: 3}, () => {
            this.todayTask = 0
            this.completedTask = 0
            this.todayTime = 0
            this.completedTime = 0
            this.consecutiveDay = 0
            this.refreshF()
        })
    }


    build() {
        Row({space: 6}) {
            this.ProgressBuilder({
                label: '今日时长',
                value: this.completedTime,
                recommend: this.todayTime,
                color: '#8de2c3'
            })
            this.statesBuilder({
                label: '连续打卡天数',
                value: this.consecutiveDay
            })
            this.ProgressBuilder({
                label: '今日任务',
                value: this.completedTask,
                recommend: this.todayTask,
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
                    Text($$.label)
                        .fontSize(12)
                        .fontColor('#b5b5b7')
                    Text(`${$$.value.toFixed(0)}/${$$.recommend.toFixed(0)}`)
                        .fontSize(18)
                        .fontWeight(600)
                }
            }
        }
    }
}