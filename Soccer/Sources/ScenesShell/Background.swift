import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    //Grass
    let grass : Rectangle
    let grassRect : Rect
    let grassColor : FillStyle
    init() {

        grassRect = Rect(topLeft:Point(x:0,y:0), size:Size(width: 1000000, height: 1000000))
        grass = Rectangle(rect:grassRect, fillMode:.fill)
        grassColor = FillStyle(color:Color(red: 0, green: 240, blue: 50))
        
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
    }

    override func render(canvas:Canvas) {
        canvas.render(grassColor, grass)
    }
}
