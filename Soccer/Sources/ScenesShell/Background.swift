import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    // hi
    let background : Rectangle
    let backgroundRect : Rect
    let backgroundColor : FillStyle
    init() {

        backgroundRect = Rect(topLeft:Point(x:0,y:0), size:Size(width:10000, height: 10000))
        background = Rectangle(rect:backgroundRect, fillMode:.fill)
        backgroundColor = FillStyle(color:Color(.olive))
        
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
    }

    override func render(canvas:Canvas) {
        canvas.render(backgroundColor, background)
    }
}
