import TargetModel from '../model/targetModel';
import { TargetItem  } from '../type'
import TargetItemComponent from './TargetItem'
import  { CommonConstants } from '../common/constant/CommonConstant'
import  { useDialog } from '../hooks/useDialog'
import  AddTargetDialog from './AddTargetDialog'
import promptAction from '@ohos.promptAction';
import getCurrentTime from '../common/utils/DateUtil';

@Component
export default struct TargetList{

  // get to know that there are some progress changed
  @Consume overAllProgressChanged: boolean;

  // manage target state by it self and get it from Model
  @State targetData : TargetItem[] = TargetModel.getData();

  // the array of seleced id
  @State selectArray: number[] = new Array();

  // is edit
  @State isEditMode : boolean = false

  // is select all
  @State selectAll : boolean = false

  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddTargetDialog({
      onClickOk: (value: string): void => this.onSaveAddClick(value)
    }),
    alignment: DialogAlignment.Bottom,
    offset: {
      dx: CommonConstants.DIALOG_OFFSET_X,
      dy: $r('app.float.dialog_offset_y')
    },
    customStyle: true,
    autoCancel: false
  });

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

      List({ space: CommonConstants.LIST_SPACE }) {
        ForEach(this.targetData, (item: TargetItem) => {
          ListItem() {
            TargetItemComponent({
              taskItem: item,
              index: item.id,
              selectArray: $selectArray,
              isEditMode: this.isEditMode,
            })
          }
        }, (item: TargetItem) => JSON.stringify(item.id))
      }
      .edgeEffect(EdgeEffect.None)
      .margin({ top: $r('app.float.list_margin_top') })
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.LIST_HEIGHT)

      Blank()

      this.IsShowDeleteOrAdd()
    }
    .width(CommonConstants.MAIN_BOARD_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .padding({ top: $r('app.float.operate_row_margin') })
  }

  // 全选或者全部取消
  selectAllOrCancel(cancel : boolean){
    if(cancel){
      this.selectArray = this.targetData.map(i=>i.id)
    }else{
      this.selectArray = []
    }
  }

  // 计算属性，计算当前是否全选状态
  isSelectAll() : boolean {
    if(this.selectArray.length >= this.targetData.length) {
      this.selectAll = true
      return true
    }
    else{
      this.selectAll = false
      return false
    }
  }

  // check if there any selected item.
  anySelected():boolean{
    return this.selectArray.length > 0
  }

  // click the add btn to open dialog.
  onAddClick(){
    this.dialogController.open()
  }

  onSaveAddClick(taskName : string){
    if (taskName === '') {
      promptAction.showToast({
        message: $r('app.string.cannot_input_empty'),
        duration: CommonConstants.TOAST_TIME,
        bottom: CommonConstants.TOAST_MARGIN_BOTTOM
      });
      return;
    }
    TargetModel.addData(new TargetItem(taskName, undefined ,0 ,getCurrentTime()));
    this.targetData = TargetModel.getData();
    this.overAllProgressChanged = !this.overAllProgressChanged;
    this.dialogController.close();
  }

  /**
   * Delete the selected item and exit the editing mode.
   */
  deleteSelected() {
    TargetModel.deleteData(this.selectArray);
    this.targetData = TargetModel.getData();
    this.overAllProgressChanged = !this.overAllProgressChanged;
    this.isEditMode = false;
  }


  // the logic of switching the mode between edit mode and normal mode.
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
          .select(this.isSelectAll())
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

  @Builder IsShowDeleteOrAdd(){
    if(this.isEditMode){
      Button($r('app.string.delete_button'))
        .opacity(this.anySelected() ? CommonConstants.NO_OPACITY : CommonConstants.OPACITY)
        .enabled(this.anySelected())
        .operateButtonStyle($r('app.color.main_red'))
        .onClick(() => {
          this.deleteSelected();
          this.selectAllOrCancel(false);
          this.selectAll = false;
        })
    }else{
      Button($r('app.string.add_task'))
        .operateButtonStyle($r('app.color.main_blue'))
        .onClick(() => {
          this.onAddClick && this.onAddClick()
        })
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