import router from '@ohos.router';
@Styles
function allSize() {
    .width('100%')
    .height('100%')
}

@Component
export struct PlanPage {
    private scroller: Scroller = new Scroller();

    build() {

        // Stack() {
        //
        //     Column() {
        //         Column() {
        //
        //         }
        //         .alignItems(HorizontalAlign.Center)
        //         .width('100%')
        //         .height('33%')
        //         .backgroundImage($r('app.media.ic_home_bg'))
        //         .backgroundImageSize({ width: '100%', height: '90%' })
        //
        //         Column() {
        //             Column(){
        //                 Text('今日计划')
        //                     .textAlign(TextAlign.Start)
        //             }
        //             .width('100%')
        //             .alignItems(HorizontalAlign.Start)
        //
        //
        //         }
        //         .width('100%')
        //         .height('33%')
        //         .alignItems(HorizontalAlign.Center)
        //
        //         Column() {
        //
        //         }
        //     }
        //     .allSize()
        //
        //     AddBtn({ clickAction: () => {} })
        // }
        // .allSize()
    }
}

@Component
struct AddBtn {
    clickAction: Function = () => {};
    build() {
        Button({ type: ButtonType.Circle, stateEffect: false }) {
            Image($r('app.media.ic_home_add'))
                .allSize()
                .borderRadius(50)
        }
        .onClick(() => this.clickAction())
        .zIndex(2)
        .position({ x: 290, y: 620 })
        .width(48)
        .height(48)
    }
}