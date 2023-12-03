
import { CommonConstants } from '../common/constant/CommonConstant';
import { TargetItem } from '../type'
import getCurrentTime from '../common/utils/DateUtil';
import ProgressEditPanel from './ProgressEditPanel';
import TargetModel from '../model/targetModel'

@Component
export default struct TargetItemComponent {
  private taskItem?: TargetItem;
  public index: number = -1;

  @Prop isEditMode: boolean;

  @State latestProgress?: number = 0;
  @State updateDate?: string = '';
  @State sliderMode: number = CommonConstants.DEFAULT_SLIDER_MODE;
  @State isExpanded: boolean = true;

  @Link selectArray: Array<number>;

  @Consume overAllProgressChanged: boolean;

  aboutToAppear() {
    this.latestProgress = this.taskItem?.progressValue;
    this.updateDate = this.taskItem?.updateDate;
  }

  build(){
    Stack( { alignContent : Alignment.Start } ){
      Column(){
        this.TargetItem()
        if(this.isExpanded){
          Blank()
          ProgressEditPanel({
            sliderMode : $sliderMode,
            slidingProgress : this.latestProgress,
            onCancel: () => this.isExpanded = false,
            onClickOk: (progress: number) => {
              this.latestProgress = progress;
              this.updateDate = getCurrentTime();
              let result = TargetModel.updateProcess(this.taskItem.id, this.latestProgress, this.updateDate);
              if (result) {
                this.overAllProgressChanged = !this.overAllProgressChanged;
              }
              this.isExpanded = false;
            }
          })
            .transition({
              scale: {
                x: CommonConstants.TRANSITION_ANIMATION_X,
                y: CommonConstants.TRANSITION_ANIMATION_Y
              }
            })
        }
      }
      .padding({
        left: $r('app.float.list_padding'),
        top: $r('app.float.list_padding_top'),
        bottom: $r('app.float.list_padding_bottom'),
        right: this.isEditMode ? $r('app.float.list_edit_padding') : $r('app.float.list_padding')
      })
      .height(this.isExpanded ? $r('app.float.expanded_item_height') : $r('app.float.list_item_height'))
      .width(CommonConstants.FULL_WIDTH)
      .opacity(
        this.latestProgress === CommonConstants.SLIDER_MAX_VALUE ?
        CommonConstants.OPACITY : CommonConstants.NO_OPACITY
      )
      .animation({ duration: CommonConstants.DURATION })
      .backgroundColor(this.selectArray.includes(this.index) ? $r('app.color.edit_blue') : Color.White)
      .borderRadius(CommonConstants.LIST_RADIUS)
      .onClick(()=>{
        if (this.sliderMode === CommonConstants.CLICK_SLIDER_MODE) {
          this.sliderMode = CommonConstants.DEFAULT_SLIDER_MODE;
          return;
        }
        // this.isExpanded = !this.isExpanded;
        if (!this.isEditMode) {
          animateTo({ duration: CommonConstants.DURATION }, () => {
            this.isExpanded = !this.isExpanded;
          })
        }
      })


      if (this.isEditMode) {
        Row() {
          Checkbox()
            .select(this.selectArray.includes(this.index) )
            .selectedColor($r('app.color.main_blue'))
            .width(CommonConstants.CHECKBOX_WIDTH)
            .margin({ right: $r('app.float.list_padding') })
            .onChange((isCheck: boolean) => {
              // 取消选中
              if(!isCheck){
                this.selectArray = this.selectArray.filter(i=>i!=this.index)
              }else {
                // 避免重复选中的bug出现
                if(!this.selectArray.includes(this.index))
                  this.selectArray.push(this.index)
              }

            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.End)
      }

    }
    .width(CommonConstants.FULL_WIDTH)

  }

  @Builder TargetItem(){
    Row(){
      Text(this.taskItem?.taskName)
        .fontSize($r('app.float.list_font'))
        .fontWeight(CommonConstants.FONT_WEIGHT)
        .fontColor($r('app.color.title_black_color'))
        .width(CommonConstants.TASK_NAME_WIDTH)
        .textAlign(TextAlign.Start)
        .maxLines(CommonConstants.MAX_LINES)
      Blank()
      Column(){
        Text(`${this.latestProgress}%`)
          .fontSize($r('app.float.list_font'))
          .fontWeight(CommonConstants.FONT_WEIGHT)
          .fontColor($r('app.color.title_black_color'))
        Row(){
          Text($r('app.string.latest_updateTime'))
            .opacityTextStyle()
          Text(this.updateDate)
            .opacityTextStyle()
        }
        .margin({ top: $r('app.float.text_margin') })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width(CommonConstants.FULL_WIDTH)
  }


}

@Extend(Text) function opacityTextStyle() {
  .fontSize($r('app.float.text_font'))
  .fontColor($r('app.color.title_black_color'))
  .opacity(CommonConstants.OPACITY)
  .fontWeight(CommonConstants.FONT_WEIGHT)
}