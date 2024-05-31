import header from '../Header'
import { PlanList } from './PlanList'
import { PlanStatsCard } from './PlanStatsCard'
import router from '@ohos.router'
import { check, getTimeByDay } from '../../http/Api'
import { CheckDialog } from '../plan/CheckDialog'
import DateUtil from '../../utils/DateUtil'
import PlanAddDialog from './PlanAddDialog'
import emitter from '@ohos.events.emitter'
@Component
export struct PlanPage {
    @State todayTask: number = 0
    @State completedTask: number = 0
    @State completedTime: number = 0

    @StorageProp('token') token : string = ''
    @StorageLink('checked') checked: boolean = false
    @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

    checkController: CustomDialogController = new CustomDialogController({
        builder: CheckDialog({
            todayTask: this.todayTask,
            completedTask: this.completedTask,
            completedTime: this.completedTime
        }),
        customStyle: true
    })

    addController: CustomDialogController = new CustomDialogController({
        builder: PlanAddDialog(),
        customStyle: true
    })

    async refreshF() {
        if (this.token){
            this.todayTask = 0
            this.completedTask = 0
            this.completedTime = 0

            let response = await getTimeByDay(this.token, this.selectedDate)
            let data = response.data.data
            this.completedTime = data['completedTime']
            this.todayTask = data['todayTask']
            this.completedTask = data['completedTask']
        }
    }

    async aboutToAppear() {
        if (this.token) {
            let response = await getTimeByDay(this.token, this.selectedDate)
            let data = response.data.data
            this.completedTime = data['completedTime']
            this.todayTask = data['todayTask']
            this.completedTask = data['completedTask']
        }
        emitter.on({eventId: 2}, () => {
            this.refreshF()
        })
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
                        }
                        .height(40)
                        .width(40)
                        .backgroundColor(Color.Transparent)
                        .onClick(() => {
                            // router.pushUrl({url: 'pages/AddPlan'})
                            this.addController.open()
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
    loadingBuilder() {
        Column({ space: 15 }) {
            Image($r('app.media.ic_loading'))
                .width(30)
                .height(30)
            Text('加载中...')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#7e8892')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
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