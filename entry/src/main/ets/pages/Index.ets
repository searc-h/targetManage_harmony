import {CommonConstants} from '../common/constant/CommonConstant'
import TargetList from '../components/TargetList'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Column() {
      Text("工作目标")
        .width('80%')
        .height(32)
        .fontSize(24)
        .textAlign(TextAlign.Start)
        .margin({
          top : 12,
          bottom : 12
        })

      TargetList()

    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.index_background'))
  }
}