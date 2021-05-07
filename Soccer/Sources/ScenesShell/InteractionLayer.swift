import Scenes
import Igis

  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayer : Layer {

    static let player1 = Player(teamJerseyColor : FillStyle(color:Color(.blue)))
    static let player2 = Player(teamJerseyColor : FillStyle(color:Color(.red)))
    
    init() {
        
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Interaction")

          // We insert our RenderableEntities in the constructor

          insert(entity:Self.player1, at:.front)
          if Self.player1.jersey.rect.topLeft.x != 0 || Self.player1.jersey.rect.topLeft.y != 0 {
              insert(entity:Self.player2, at:.front)
          }
      }
  }
