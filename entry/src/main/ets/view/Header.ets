@Builder function header(title: string) {
    Row() {
        Text(title)
            .fontSize(18)
            .textAlign(TextAlign.Center)
            .width('94%')
            .fontWeight(FontWeight.Bold)
        Divider()
            .color(Color.Black)
            .margin({ left: 20, right: 20, top: 10 })

    }
    .width('100%')
    .height(40)
    .backgroundColor('#F6F7FB')
}
export default header