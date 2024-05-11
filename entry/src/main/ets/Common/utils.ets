export const nonNullValidation =  (params:string|string[]):boolean => {
  let validation:boolean = false
  if ( typeof params === 'object' && Array.isArray(params)) {
    params.forEach(item=>{
     validation = item===''?false:true
    })
  }else{
    validation = params===''?false:true
  }
  return validation
}