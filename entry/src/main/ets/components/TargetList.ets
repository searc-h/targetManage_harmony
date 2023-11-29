import TargetModel from '../model/targetModel';
import { TargetItem  } from '../type'
import TargetItemComponent from './TargetItem'
import  { CommonConstants } from '../common/constant/CommonConstant'

@Component
export default struct TargetList{
  @Provide overAllProgressChanged: boolean = true;
  @State targetData : TargetItem[] = TargetModel.getData();
  // 这里使用Set集合来作为状态，可能引发问题
  @State selectArray: Set<number> = new Set();

  @State isEditMode : boolean = false
  @State selectAll : boolean = false
  @State clickIndex : number = -1

  build(){
    Column(){
      Row(){
        Text($r('app.string.sub_goals'))
          .fontSize($r('app.float.secondary_title'))
          .fontWeight(CommonConstants.FONT_WEIGHT_LARGE)
          .fontColor($r('app.color.title_black_color'))
        Blank()
        this.IsShowEdit()
      }
      .width(CommonConstants.FULL_WIDTH)
      .height($r('app.float.history_line_height'))
      .padding({
        left: $r('app.float.list_padding'),
        right: $r('app.float.list_padding_right')
      })

      // List({ space: CommonConstants.LIST_SPACE }) {
      //   ForEach(this.targetData, (item: TargetItem, index: number | undefined) => {
      //     ListItem() {
      //       TargetItemComponent({
      //         taskItem: item,
      //         index: index,
      //         selectArray: $selectArray,
      //         isEditMode: this.isEditMode,
      //         clickIndex: $clickIndex
      //       })
      //     }
      //   }, (item: TargetItem) => JSON.stringify(item))
      // }
      // .edgeEffect(EdgeEffect.None)
      // .margin({ top: $r('app.float.list_margin_top') })
      // .width(CommonConstants.FULL_WIDTH)
      // .height(CommonConstants.LIST_HEIGHT)

      Blank()
    }

  }
  // 全选或者全部取消
  selectAllOrCancel(cancel : boolean){
    if(cancel) {
      this.selectArray.clear();
    }else {
       this.targetData.forEach(item=>this.selectArray.add(item.id))
    }
  }

  // 计算属性，计算当前是否全选状态
  isSelectAll() : boolean {
    if(this.selectArray.size === this.targetData.length) {
      this.selectAll = true
      return true
    }
    else{
      this.selectAll = false
      return false
    }
  }

  @Builder IsShowEdit(){
    if(this.targetData.length > 0){
      if(this.isEditMode){
        Text($r('app.string.cancel_button'))
          .operateTextStyle($r('app.color.main_blue'))
          .margin({ left: $r('app.float.operate_button_margin') })
          .onClick(() => {
            this.selectAll = false;
            this.isEditMode = false;
            this.selectAllOrCancel(false);
          })
        Text($r('app.string.select_all_button'))
          .operateTextStyle($r('app.color.main_blue'))
          .margin({
            left: $r('app.float.operate_button_margin')
          })
        Checkbox()
          .select(this.selectAll)
          .selectedColor($r('app.color.main_blue'))
          .width(CommonConstants.CHECKBOX_WIDTH)
          .onClick(() => {
            this.selectAll = !this.selectAll;
            this.selectAllOrCancel(this.selectAll);
          })
      } else {
        Text($r('app.string.edit_button'))
          .operateTextStyle($r('app.color.main_blue'))
          .onClick(() => {
            this.isEditMode = true;
            // this.selectAllOrCancel(false);
          })
      }
    }

  }
}

@Extend(Text) function operateTextStyle(color: Resource) {
  .fontSize($r('app.float.text_button_font'))
  .fontColor(color)
  .lineHeight($r('app.float.text_line_height'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
}

@Extend(Button) function operateButtonStyle(color: Resource) {
  .width($r('app.float.button_width'))
  .height($r('app.float.button_height'))
  .fontSize($r('app.float.button_font'))
  .fontWeight(CommonConstants.FONT_WEIGHT)
  .fontColor(color)
  .backgroundColor($r('app.color.button_background'))
}