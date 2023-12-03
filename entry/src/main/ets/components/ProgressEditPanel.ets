
import { CommonConstants } from '../common/constant/CommonConstant';
import CustomButton from './CustomButton'
@Component
export default struct ProgressEditPanel{

  @Link sliderMode : any;
  @Prop slidingProgress : number = 0;

  onCancel? : ()=>void;
  onClickOk? : (progress : number)=>void;

  build(){
    Column(){
      Row(){
        Slider({
          value: this.slidingProgress,
          min: CommonConstants.SLIDER_MIN_VALUE,
          max: CommonConstants.SLIDER_MAX_VALUE,
          style: SliderStyle.InSet,
          step: CommonConstants.SLIDER_STEP
        })
          .width(CommonConstants.SLIDER_INNER_WIDTH)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.slidingProgress = Math.floor(value);
            this.sliderMode = mode;
          })
        Text(`${this.slidingProgress}%`)
          .fontSize($r('app.float.progress_font'))
          .fontWeight(CommonConstants.FONT_WEIGHT)
          .fontColor($r('app.color.dialog_progress'))
          .textAlign(TextAlign.Center)
          .margin({ left: $r('app.float.slider_margin_left') })
      }
      .width(CommonConstants.SLIDER_WIDTH)
      .height(CommonConstants.SLIDER_HEIGHT)

      Row() {
        CustomButton({
          buttonText: $r('app.string.cancel_button')
        })
          .onClick(() => {
            if (this.onCancel !== undefined) {
              this.onCancel();
            }
          })
        CustomButton({
          buttonText: $r('app.string.confirm_button')
        })
          .onClick(() => {
            if (this.onClickOk !== undefined) {
              this.onClickOk(this.slidingProgress);
            }
          })
      }
    }
  }
}

