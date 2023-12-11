
import { TargetItem } from '../type'

const TAG = '[TargetModel]'

export class TargetModel {

  private targetData : Array<TargetItem> = [
  ]

  getData() : Array<TargetItem> {
    return this.targetData
  }

  addData(data: TargetItem) {
    if (!data) {
      return console.log("Add Data Error : " + data);
    }
    data.id = data.id || this.targetData.length + 1
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
    return true
  }

  getTotalNumber(){
    return this.targetData.length
  }

  getCompletedNumber(){
    return this.targetData.filter(i=>i.progressValue >= 100).length
  }

}

export default  new TargetModel()