package states {
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Signal;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class GameOverWorld extends World {
		
		[Embed(source="../assets/gameover.png")]
		private static const BG_IMG:Class;
		
		public var
			onPlayAgain:Signal = new Signal();
		
		private var
			gameOver:Text = new Text("Game Over"),
			gameOverShade:Text = new Text("Game Over"),
			splashScreenText:Text = new Text("Press X to play again"),
			splashScreenShade:Text = new Text("Press X to play again");
		
		public function GameOverWorld() {
			gameOver.size = 48;
			gameOverShade.size = 48;
			gameOverShade.color = 0;
			gameOver.x = (600 - gameOver.width) / 2;
			gameOver.y = (400 - gameOver.height) / 2;
			gameOverShade.x = gameOver.x + 3;
			gameOverShade.y = gameOver.y + 3;
			splashScreenText.x = (600 - splashScreenText.width) / 2;
			splashScreenText.y = 350;
			splashScreenShade.x = splashScreenText.x + 1;
			splashScreenShade.y = splashScreenText.y + 1;
			splashScreenShade.color = 0;
			addGraphic(new Image(BG_IMG));
			addGraphic(gameOverShade);
			addGraphic(gameOver);
			addGraphic(splashScreenShade);
			addGraphic(splashScreenText);
		}
		
		override public function begin():void {
			Audio.stop(Audio.FOOTSTEP);
		}
		
		override public function update():void {
			super.update();
			if (Input.pressed(Key.X)) onPlayAgain.dispatch();
		}
	}
}