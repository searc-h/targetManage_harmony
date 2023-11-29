export class TargetItem {

  id :  number;

  taskName: string;

  updateDate: string;

  progressValue: number;

  constructor(id: number ,taskName: string, progressValue?: number, updateDate?: string) {
    this.id = id;
    this.taskName = taskName;
    this.progressValue = progressValue;
    this.updateDate = updateDate;
  }
}