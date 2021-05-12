import Igis
import Scenes
import Foundation


class Scoreboard: RenderableEntity {
    var player1ScoreText : Text
    var player2ScoreText : Text
    let textFillStyle : FillStyle
    var player1Score : Int
    var player2Score : Int
    var field : Field
    let lineWidth : LineWidth
    
    init () {
        lineWidth = LineWidth(width:1)
        player1Score = 0
        player2Score = 0
        field = Field()
        textFillStyle = FillStyle(color:Color(.white))
        player1ScoreText = Text(location:Point(x:field.field.rect.topLeft.x, y:field.field.rect.topLeft.y - 20), text:"David Ben-Yaakov: \(player1Score)", fillMode: .fill)
      //  player1ScoreText.alignment = .left
        player1ScoreText.font = "100pt Arial"
        player2ScoreText = Text(location:Point(x:0, y:0), text:"Merlin: \(player2Score)", fillMode: .fill)
        player2ScoreText.font = "20pt Arial"
      //  player2ScoreText.alignment = .right
    }

    func increasePlayer1Score() {
        player1Score += 1
    }

    func increasePlayer2Score() {
        player2Score += 1
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        player1ScoreText = Text(location:Point(x: canvasSize.center.x - canvasSize.center.x + 50, y: canvasSize.center.y - canvasSize.center.y + 50), text:"David Ben-Yaakov: \(player1Score)", fillMode: .fill)
        player1ScoreText.font = "30pt Luminari"
        player2ScoreText = Text(location:Point(x:canvasSize.center.x + canvasSize.center.x - 200, y: canvasSize.center.y - canvasSize.center.y + 50), text:"Merlin: \(player2Score)", fillMode: .fill)
    }

    override func calculate(canvasSize:Size) {
        player1ScoreText.text = "David Ben-Yaakov: \(player1Score)"
        player2ScoreText.text = "Merlin: \(player2Score)"
    }

    override func render(canvas:Canvas) {
        canvas.render(textFillStyle,lineWidth, player1ScoreText, player2ScoreText)
    }
}
