
import { TargetItem } from '../type'

const TAG = '[TargetModel]'

export class TargetModel {

  private targetData : Array<TargetItem> = [
    new TargetItem(0 ,'0000', 0.2, '123123'),
    new TargetItem(1 ,'1111', 0.2, '123123')
  ]

  getData() : Array<TargetItem> {
    return this.targetData
  }

  addData(data: TargetItem) {
    if (!data) {
      return console.log("Add Data Error : " + data);
    }
    data.id = this.targetData.length + 1
    this.targetData.push(data);
  }

  deleteData(selectArr : number[]){
    if(selectArr.length === 0) return
    this.targetData = this.targetData.filter(item=>{
      return !selectArr.includes(item.id)
    })
  }

  updateProcess(id : number , updateProcess : number , updateDate:string){
    let index = this.targetData.findIndex(item=>item.id===id)
    if(index < 0){
      return false
    }

    this.targetData[index].progressValue = updateProcess
    this.targetData[index].updateDate = updateDate
  }

}

export default  new TargetModel()