
import { CommonConstants } from '../common/constant/CommonConstant';

@Component
export default struct CustomButton {
  @State buttonColor: Resource = $r('app.color.start_window_background');
  buttonText?: Resource;

  build() {
    Text(this.buttonText)
      .dialogButtonStyle()
      .backgroundColor(this.buttonColor)
      .borderRadius(CommonConstants.LIST_RADIUS)
      .textAlign(TextAlign.Center)
      .onTouch((event?: TouchEvent) => {
        if (event !== undefined && event.type === TouchType.Down) {
          this.buttonColor = $r('app.color.custom_button_color');
        }
        if (event !== undefined && event.type === TouchType.Up) {
          this.buttonColor = $r('app.color.start_window_background');
        }
      })
  }
}
/**
 * Custom button style.
 */
@Extend(Text) function dialogButtonStyle() {
  .fontSize($r('app.float.button_font'))
  .height($r('app.float.dialog_btn_height'))
  .width($r('app.float.dialog_btn_width'))
  .fontColor($r('app.color.main_blue'))
  .margin({top : 5 , left : 5 , right : 5})
}
