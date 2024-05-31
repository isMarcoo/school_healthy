import emitter from '@ohos.events.emitter'
@CustomDialog
export default  struct PlanPickDialog {
    controller: CustomDialogController
    selectedDate: Date = new Date()
    build() {
        Column({space: 12}) {
            // 日期选择框
            DatePicker({
                start: new Date('1970-1-1'),
                end: new Date('2100-1-1'),
                selected: this.selectedDate
            })
                .onChange((value: DatePickerResult) => {
                    this.selectedDate.setFullYear(value.year, value.month, value.day)
                })
            // 按钮
            Row({space: 12}) {
                Button('取消')
                    .width(120)
                    .backgroundColor('#b5b5b7')
                    .onClick(() => this.controller.close())
                Button('确定')
                    .width(120)
                    .backgroundColor('#02BD79')
                    .onClick(() => {
                        AppStorage.SetOrCreate('selectedDate', this.selectedDate.getTime())
                        emitter.emit({eventId: 3})
                        this.controller.close()
                    })
            }
        }
        .padding(12)
    }
}