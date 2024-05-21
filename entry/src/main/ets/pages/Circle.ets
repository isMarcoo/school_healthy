import { PostInfo } from '../model/PostInfo'
import router from '@ohos.router'

@Component
export struct CirclePage {
    @State postInfoList: PostInfo[] = [new PostInfo({
        id : 1,
        postText : "健康万岁！运动万岁！",
        rightCount : 3,
        answeredCount : 4,
        timeUsed : 5747,
        createTime : "2024-05-11 14:42:58",
        likeCount : 1,
        nickname : "138****4985",
        avatarUrl : "",
        isLike : false
    }), new PostInfo({
        id: 2,
        postText: "今天差点累死了",
        rightCount: 3,
        answeredCount: 4,
        timeUsed: 5747,
        createTime: "2024-05-10 19:38:54",
        likeCount: 36,
        nickname: "cxk",
        avatarUrl: "",
        isLike: false
    })]
    @StorageProp('token') token : string = ''

    build() {
        Column() {
            Text('运动打卡圈')
                .fontSize(18)
                .margin({top : 45})
                .fontWeight(FontWeight.Bold)
            Divider()
                .color(Color.Black)
                .margin({ left: 20, right: 20, top: 10 })

            if (true) {
                this.listBuilder()
            } else {
                this.unLoginBuilder()
            }
        }
        .height('100%')
        .width('100%')
    }

    @Builder
    unLoginBuilder() {
        Column({ space: 30 }) {
            Image($r("app.media.app_icon"))
                .width(177)
                .height(177)

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

    @Builder
    listBuilder() {
        Stack() {
            List() {
                ForEach(this.postInfoList, (post) => {
                    ListItem() {
                        PostItem({ post: post })
                    }
                })
            }
            .width('100%')
            .height('100%')
            .alignListItem(ListItemAlign.Center)

            Column({ space: 20 }) {
                Button({ type: ButtonType.Circle }) {
                    Image($r('app.media.app_icon'))
                        .height(14)
                        .width(14)
                }
                .height(40)
                .width(40)
                .backgroundColor(Color.Black)
                .opacity(0.5)
                .onClick(() => {
                //     返回顶部
                })

                Button({ type: ButtonType.Circle }) {
                    Image($r('app.media.app_icon'))
                        .height(14)
                        .width(14)
                }
                .height(40)
                .width(40)
                .backgroundColor(Color.Black)
                .opacity(0.5)
                .onClick(() => {
                    //     刷新
                })
            }
            .offset({ x: -20, y: -50 })
        }
        .width('100%')
        .layoutWeight(1)
        .alignContent(Alignment.BottomEnd)
    }
}

@Component
struct PostItem {
    @ObjectLink post: PostInfo;

    build() {
        Column({ space: 10 }) {
            Row({ space: 10 }){
                Image(this.post.avatarUrl)
                    .height(40)
                    .width(40)
                    .borderRadius(20)
                Text(this.post.nickname)
                    .height(40)
                    .width(40)
                    .fontWeight(FontWeight.Bold)
                Blank()
                Text(this.post.createTime)
                    .height(40)
                    .fontSize(14)
                    .fontColor('#999999')
                    .fontWeight(FontWeight.Medium)
            }.width('100%')

            Text(this.post.postText)
                .width('100%')

            Row() {
                Column() {
                    StatItem({
                        icon: $r('app.media.app_icon'),
                        name: '跑步',
                        fontColor: Color.White
                    }) {
                        // Text(convertMillisecondsToTime(this.post.timeUsed))
                        Text('10分钟')
                            .statTextStyle()
                    }

                    StatItem({
                        icon: $r('app.media.app_icon'),
                        name: '俯卧撑',
                        fontColor: Color.White
                    }) {
                        Text('25个')
                            .statTextStyle()
                    }
                }
                .padding(10)
                .borderRadius(10)
                .layoutWeight(1)
                // .backgroundImage($r('app.media.ic_home_bg'))
                // .backgroundImageSize(ImageSize.Cover)

                Column() {
                    Text(this.post.likeCount.toString())
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.post.isLike ? '#3ECBA1' : '#000000')
                    Image(this.post.isLike ? $r('app.media.app_icon') : $r('app.media.app_icon'))
                        .width(26)
                        .height(26)
                        .onClick(() => {
                        //     点赞/取消点赞
                        })
                }
                .width(50)
            }
            .width('100%')
            .alignItems(VerticalAlign.Bottom)
        }
        .padding(10)
        .width('90%')
        .margin({ top: 10 })
        .borderRadius(10)
        .shadow({ radius: 20 })
        .backgroundImage($r('app.media.ic_home_bg'))
        .backgroundImageSize(ImageSize.Cover)
    }
}

@Component
struct StatItem {
    icon: Resource;
    name: string;
    @BuilderParam statComp: () => void
    fontColor: Color

    build() {
        Row({ space: 10 }) {
            Image(this.icon)
                .height(14)
                .width(14)
            Text(this.name)
                .fontWeight(FontWeight.Medium)
                .fontSize(14)
                .fontColor(this.fontColor)
            Blank()
            this.statComp()
        }
        .width('100%')
        .height(30)
    }
}

@Extend(Text) function statTextStyle() {
    .width(100)
    .fontSize(16)
    .textAlign(TextAlign.End)
    .fontWeight(FontWeight.Medium)
    .fontColor(Color.White)
}