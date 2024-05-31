import header from '../Header'
import router from '@ohos.router'
import { AchievementPanel } from './AchievementPanel'
@Component
export struct AchievementPage {
    @StorageProp('token') token : string = ''
    build() {
        Column({space: 8}) {
            // 1.header
            header('成就')

            if (this.token) {
                AchievementPanel()
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