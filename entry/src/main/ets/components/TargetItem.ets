
import { CommonConstants } from '../common/constant/CommonConstant';
import { TargetItem } from '../type'
@Component
export default struct TargetItemComponent {
  private taskItem?: TargetItem;
  @State latestProgress?: number = 0;
  @State updateDate?: string = '';
  @Link selectArray: Array<boolean>;
  @Prop isEditMode: boolean;
  @Link @Watch('onClickIndexChanged') clickIndex: number;
  @State isExpanded: boolean = false;
  @Consume overAllProgressChanged: boolean;
  @State sliderMode: number = CommonConstants.DEFAULT_SLIDER_MODE;
  public index: number = 0;

  build(){
    Row(){
      Text("task")
    }
  }

  onClickIndexChanged(){

  }
}