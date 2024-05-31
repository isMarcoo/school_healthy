import { CardInfo } from './CardInfo'
export class CardListInfo {
    private cards: Array<CardInfo> = []


    getData() : Array<CardInfo> {
        return this.cards
    }

    setData(totalData) {
        for (let data of totalData) {
            let card = new CardInfo(data['titleContent'], data['imgSrc'])
            this.cards.push(card)
        }
    }
}