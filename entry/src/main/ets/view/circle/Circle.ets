import { PostInfo } from '../../model/PostInfo'
import router from '@ohos.router'
import header from '../Header'
import { cancelLike, getAllPost, like } from '../../http/Api'
import promptAction from '@ohos.promptAction'
import emitter from '@ohos.events.emitter'

@Component
export struct CirclePage {
    @State postInfoList: PostInfo[] = []
    @StorageProp('token') @Watch('onTokenChange') token : string = ''

    page: number = 1
    total: number = 0
    @State isLoading: boolean = false
    scroller: Scroller = new Scroller()

    async getPostInfoPage() {
        let response = await getAllPost(this.page, 10)
        response.data.data.records.forEach(post=>this.postInfoList.push(new PostInfo(post)))
        this.total = response.data.data.total
        this.page++
    }

    onTokenChange(){
        if (this.token) {
            this.getPostInfoPage()
        } else {
            this.postInfoList = []
            this.total = 0
            this.page = 1
        }
    }

    async refresh() {
        this.isLoading = true
        this.postInfoList = []
        this.total = 0
        this.page = 1

        await this.getPostInfoPage()
        this.isLoading = false
    }

    aboutToAppear() {
        if (this.token) {
            this.getPostInfoPage()
        }

        emitter.on({eventId: 1}, () => {
            this.refresh()
        })
    }

    build() {
        Column() {
            header('运动打卡圈')

            if (this.token) {
                if (this.isLoading){
                    this.loadingBuilder()
                } else {
                    this.listBuilder()
                }
            } else {
                this.unLoginBuilder()
            }
        }
        .height('100%')
        .width('100%')
    }

    @Builder
    unLoginBuilder() {
        Column({space: 30}) {
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
        .backgroundColor('#F6F7Fb')
    }

    @Builder
    listBuilder() {
        Stack() {
            List({scroller: this.scroller}) {
                ForEach(this.postInfoList, (post) => {
                    ListItem() {
                        PostItem({ post: post })
                    }
                })
            }
            .width('100%')
            .height('100%')
            .alignListItem(ListItemAlign.Center)
            .onReachEnd(() => {
                if (this.postInfoList.length < this.total){
                    this.getPostInfoPage()
                } else {
                    promptAction.showToast({message: "没有更多数据了"})
                }
            })

            Column({ space: 20 }) {
                Button({ type: ButtonType.Circle }) {
                    Image($r('app.media.ic_top'))
                        .height(14)
                        .width(14)
                }
                .height(40)
                .width(40)
                .backgroundColor(Color.Black)
                .opacity(0.5)
                .onClick(() => {
                    this.scroller.scrollToIndex(0)
                })

                Button({ type: ButtonType.Circle }) {
                    Image($r('app.media.ic_refresh'))
                        .height(14)
                        .width(14)
                }
                .height(40)
                .width(40)
                .backgroundColor(Color.Black)
                .opacity(0.5)
                .onClick(() => {
                    this.refresh()
                })
            }
            .offset({ x: -20, y: -50 })
            .zIndex(2)
        }
        .width('100%')
        .layoutWeight(1)
        .alignContent(Alignment.BottomEnd)
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
                Text(this.post.username)
                    .height(40)
                    .width(80)
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
                        icon: $r('app.media.ic_timer'),
                        name: '锻炼时长',
                        fontColor: Color.White
                    }) {
                        Text(this.post.completedTime.toString())
                            .statTextStyle()
                    }
                    StatItem({
                        icon: $r('app.media.ic_timer'),
                        name: '完成率',
                        fontColor: Color.White
                    }) {
                        Text((this.post.completedTask === 0 ? 0 : this.post.completedTask/this.post.todayTask*100).toFixed() + '%')
                            .statTextStyle()
                    }
                    StatItem({
                        icon: $r('app.media.ic_timer'),
                        name: '任务',
                        fontColor: Color.White
                    }) {
                        Text(this.post.completedTask + '/' + this.post.todayTask)
                            .statTextStyle()
                    }
                }
                .padding(10)
                .borderRadius(10)
                .layoutWeight(1)
                .backgroundImage($r("app.media.img_card_bg_2"))
                .backgroundImageSize(ImageSize.Cover)
                .backdropBlur(5)

                Column() {
                    Text(this.post.likeCount.toString())
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.post.isLike ? '#3ECBA1' : '#000000')
                    Image(this.post.isLike ? $r('app.media.ic_post_like_selected') : $r('app.media.ic_post_like'))
                        .width(26)
                        .height(26)
                        .onClick(() => {
                            if (this.post.isLike) {
                                this.post.isLike = false
                                this.post.likeCount--
                                cancelLike(this.post.id)
                            } else {
                                this.post.isLike = true
                                this.post.likeCount++
                                like(this.post.id)
                            }
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
                .fillColor(Color.White)
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

