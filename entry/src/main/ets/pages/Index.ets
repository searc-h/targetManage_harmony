import {CommonConstants} from '../common/constant/CommonConstant'
import getCurrentTime from '../common/utils/DateUtil';
import TargetList from '../components/TargetList'
import TargetModel from '../model/targetModel'
import TargetInfo from '../components/TargetInfo'
@Entry
@Component
struct Index {

  @State taskTotalNumber : number = 0;
  @State completedNumber : number = 0;
  @State latestUpdateDate : string =  "";

  @Provide @Watch("onProgressChanged") overAllProgressChanged: boolean = true;

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

      TargetInfo({
        taskTotalNumber : this.taskTotalNumber,
        completedNumber : this.completedNumber,
        latestUpdateDate : this.latestUpdateDate
      })

      TargetList()
        .height(CommonConstants.LIST_BOARD_HEIGHT)

    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.index_background'))
  }

  /**
   * Listening targetData change including length and progress of each item.
   */
  onProgressChanged() {
    this.taskTotalNumber = TargetModel.getTotalNumber();
    this.completedNumber = TargetModel.getCompletedNumber();
    this.latestUpdateDate = getCurrentTime();

    console.log("change : " + this.taskTotalNumber);
    console.log("change : " + this.completedNumber);
    console.log("change : " + this.latestUpdateDate);
  }
}