@Observed
export class CardInfo {
    titleContent: string = ''
    imgSrc: string = ''

    constructor(titleContent: string, imgSrc: string) {
        this.titleContent = titleContent
        this.imgSrc = imgSrc
    }
}