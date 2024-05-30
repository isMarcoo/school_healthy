import header from '../Header'
import { PlanList } from './PlanList'
import { PlanStatsCard } from './PlanStatsCard'
import router from '@ohos.router'
import { check, getTimeByDay } from '../../http/Api'
import { CheckDialog } from '../plan/CheckDialog'
import DateUtil from '../../utils/DateUtil'
@Component
export struct PlanPage {
    @State todayTask: number = 0
    @State completedTask: number = 0
    @State todayTime: number = 0
    @State completedTime: number = 0

    @StorageProp('token') token : string = ''
    @StorageLink('checked') checked: boolean = false
    @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
    @StorageLink('refresh') @Watch('refreshF') refresh: boolean = false

    checkController: CustomDialogController = new CustomDialogController({
        builder: CheckDialog({
            todayTask: this.todayTask,
            completedTask: this.completedTask,
            completedTime: this.completedTime
        }),
        customStyle: true
    })

    async refreshF() {
        if (this.token){
            let response = await getTimeByDay(this.token, this.selectedDate)
            let data = response.data.data
            this.todayTime = data['totalTime']
            this.completedTime = data['completedTime']
            this.todayTask = data['todayTask']
            this.completedTask = data['completedTask']

        }
    }

    async aboutToAppear() {
        if (this.token) {
            let response = await getTimeByDay(this.token, this.selectedDate)
            let data = response.data.data
            this.todayTime = data['totalTime']
            this.completedTime = data['completedTime']
            this.todayTask = data['todayTask']
            this.completedTask = data['completedTask']
        }
    }

    build() {
            Column({space: 8}) {
                // 1.header
                header('计划打卡')
                // PlanHeader()

                if (this.token) {
                    // 2.统计卡片
                    PlanStatsCard()
                    // 3.计划列表
                    PlanList()

                    Column({ space: 20 }) {
                        Button({ type: ButtonType.Circle }) {
                            Image($r('app.media.ic_check'))
                                .height('100%')
                                .width('100%')
                        }
                        .height(40)
                        .width(40)
                        .backgroundColor(Color.Transparent)
                        .onClick(async () => {
                            this.checkController.open()
                        })

                        Button({ type: ButtonType.Circle }) {
                            Text('+')
                                .fontColor(Color.Blue)
                                .fontSize(40)
                                .textAlign(TextAlign.Center)
                            // Image($r('app.media.ic_home_add'))
                            //     .height('100%')
                            //     .width('100%')
                                // .fillColor(Color.Blue)
                        }
                        .height(40)
                        .width(40)
                        .backgroundColor(Color.Transparent)
                        .onClick(() => {
                            router.pushUrl({url: 'pages/AddPlan'})
                        })
                    }
                    .position({x: '83%', y: '80%'})
                } else {
                    this.unLoginBuilder()
                }

            }
            .width('100%')
            .height('100%')
            .backgroundColor('#F6F7Fb')
    }

    @Builder
    unLoginBuilder() {
        Column({ space: 30 }) {
            Image($r("app.media.ic_logo"))
                .width(177)
                .height(177)
                .borderRadius(100)

            Text('未登录暂无数据')
                .fontSize(14)
                .fontColor('#999999')

            Button('去登录')
                .fontColor(Color.White)
                .fontSize(14)
                .width(100)
                .height(34)
                .backgroundColor('#43C6A0')
                .onClick(() => router.pushUrl({ url: 'pages/LoginPage' }))
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
    }

}