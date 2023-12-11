import { Component } from '@ohos.UiTest'
interface DialogProps<T = Function> {
  builder : any;
  alignment ?: DialogAlignment;
  offsetX ?: Length,
  offsetY ?: Length
}

export const useDialog = (props : DialogProps) : CustomDialogController=>{

  let { builder , alignment = DialogAlignment.Bottom , offsetX = 0, offsetY = 0} = props

  return new CustomDialogController({
    builder ,
    alignment,
    offset : {
      dx : offsetX,
      dy : offsetY
    },
    customStyle : true,
    autoCancel : false
  })
}