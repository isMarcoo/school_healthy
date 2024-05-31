import { CardInfo } from './CardInfo'

@Component
export struct AchievementCard {
    @ObjectLink card: CardInfo

    build() {
        Column({space: 18}) {
            Image(this.card.imgSrc)
                .width('100%')
                .height(88)
                .objectFit(ImageFit.Contain)
            Text(this.card.titleContent)
                .lineHeight(16)
                .fontSize(12)
                .fontColor(Color.Black)
        }
        .width('33%')
        .padding({
            top: 38,
            bottom: 10
        })
    }
}