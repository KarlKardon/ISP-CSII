import Scenes
import Igis

  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayer : Layer {
   
    static let player1 = Player(teamJerseyColor : FillStyle(color:Color(.blue)))
    static let player2 = Player(teamJerseyColor : FillStyle(color:Color(.red)))
    static var player2Native = Player(teamJerseyColor: FillStyle(color:Color(.red)))
    let followPoint = player2.jersey.rect.topLeft
    init() {

        
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Interaction")

          // We insert our RenderableEntities in the constructor

          
          insert(entity:Self.player2Native, at:.front)
          Self.player2Native.move(to: Point(x: 500, y: 500))
          
          insert(entity:Self.player1, at:.front)
          Self.player1.move(to: Point(x:1000, y:500))
        /*  if Self.player1.jersey.rect.topLeft.x != 0 || Self.player1.jersey.rect.topLeft.y != 0 {
              insert(entity:Self.player2, at:.front)
              
          } */

          

        //  Self.player2Native.jersey.rect.topLeft = Self.player2.jersey.rect.topLeft
        //  Self.player2Native.head.rect.topLeft = Self.player2.head.rect.topLeft

          
    }

    func postCalculate(canvasSize: Size) {
        Self.player2Native.move(to: followPoint)
    }
  }
