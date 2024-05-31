import { getCardList, getConsecutiveDay } from '../../http/Api'
import { AchievementCard } from './AchievementCard'
import { CardInfo } from './CardInfo'
import emitter from '@ohos.events.emitter'
import { CardListInfo } from './CardListInfo'
@Component
export struct AchievementPanel {
    @StorageProp('token') token: string = ''
    @State cardList: Array<CardInfo> = []

    async aboutToAppear() {
        if (this.token){
            let response = await getCardList(this.token)
            let data = response.data.data
            let cardListInfo = new CardListInfo()
            cardListInfo.setData(data)
            this.cardList = cardListInfo.getData()

            emitter.on({eventId: 1}, async () => {
                let response = await getCardList(this.token)
                let data = response.data.data
                let cardListInfo = new CardListInfo()
                cardListInfo.setData(data)
                this.cardList = cardListInfo.getData()
            })
        }

    }

    build() {
        Flex({direction: FlexDirection.Row, wrap: FlexWrap.Wrap}) {
            if (this.cardList){
                ForEach(this.cardList, (item: CardInfo) => {
                    AchievementCard({card: item})
                })
            }
        }
        .width('100%')
        .height('100%')
    }
}