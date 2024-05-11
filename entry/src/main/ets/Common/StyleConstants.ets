
interface IBaseStyle {
  backGroundColor:string;
  fontColor:string;
  inputBackGroundColor:string
  defaultBackGround:string
}

export class StyleConstants{

  /**
   * common style
   */
  static BASE_STYLE:IBaseStyle = {
    defaultBackGround:'#f2f3f5',
    backGroundColor:'#ffffff',
    fontColor:'#008080',
    inputBackGroundColor:'#f1f3f5'
  }

  /**
   * the common spacing size
   */
  static readonly SPACING = '20vp'

  /**
   * the common spacing smail size
   */
  static readonly SPACING_SMAIL = '8vp'

  /**
   * the width of button
   */
  static  readonly FULL_BUTTON:string = '70%'

  /**
   * the width of 100%
   */
  static  readonly  FULL_WIDTH:string = '100%'

  /**
   * the height of 100%
   */
  static  readonly  FULL_HEIGHT:string = '100%'

  /**
   * the height of input
   */
  static readonly INPUT_HEIGHT:string =  '40vp'

  /**
   * the baseGrey
   */
  static readonly BASE_GREY:string = "#8a919f"

  /**
   * the line baseGrey
   */
  static readonly LINE_BASE_GREY:string = "#e4e6eb"


  static readonly BASE_WHITE:string = "#ffffff"


}