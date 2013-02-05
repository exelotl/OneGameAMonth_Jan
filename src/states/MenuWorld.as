package states {
	import entities.Background;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Signal;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class MenuWorld extends World {
		
		[Embed(source="../assets/title_screen.png")]
		private static const IMG_TITLE:Class;
		
		public var onPlay:Signal = new Signal();
		
		private var
			splashScreenText:Text = new Text("Press X to play"),
			splashScreenTextShade:Text = new Text("Press X to play"),
			madeBy:Text = new Text("A game by", 65, 32, { size:32}),
			madeByShade:Text = new Text("A game by", 67, 34, { size:32,color:0}),
			geckojsc:Text = new Text("geckojsc", 79, 98, {size:32}),
			geckojscShade:Text = new Text("geckojsc", 81, 100, {size:32,color:0}),
			simonm:Text = new Text("SimonM", 93, 164, {size:32}),
			simonmShade:Text = new Text("SimonM", 95, 166, {size:32,color:0}),
			ally:Text = new Text("AllyAlly", 107, 230, {size:32}),
			allyShade:Text = new Text("AllyAlly", 109, 232, {size:32,color:0}),
			gameName:Text = new Text("Lies TD", 410, 90,{size:32}),
			gameNameShade:Text = new Text("Lies TD", 412, 92,{size:32,color:0});
			
		public function MenuWorld() {
			addGraphic(new Image(IMG_TITLE));
			addGraphic(madeByShade);
			addGraphic(madeBy);
			addGraphic(geckojscShade);
			addGraphic(geckojsc);
			addGraphic(simonmShade);
			addGraphic(simonm);
			addGraphic(allyShade);
			addGraphic(ally);
			addGraphic(gameNameShade);
			addGraphic(gameName);
			splashScreenText.x = (600 - splashScreenText.width) / 2;
			splashScreenText.y = 365;
			splashScreenTextShade.color = 0;
			splashScreenTextShade.x = splashScreenText.x + 1;
			splashScreenTextShade.y = splashScreenText.y + 1;
			addGraphic(splashScreenTextShade);
			addGraphic(splashScreenText);
		}
		
		override public function update():void {
			super.update();
			if (Input.pressed(Key.X)) onPlay.dispatch();
		}
	}
}