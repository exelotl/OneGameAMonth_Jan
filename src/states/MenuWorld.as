package states {
	import entities.Background;
	import entities.ui.ScreenFade;
	import flash.display.BlendMode;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Signal;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class MenuWorld extends World {
		
		public var onPlay:Signal = new Signal();
		
		private var
			clouds:Backdrop = new Backdrop(Sprites.CLOUDS),
			splashScreenText:Text = new Text("Press X to play"),
			splashScreenTextShade:Text = new Text("Press X to play"),
			madeBy:Text = new Text("A game by", 65, 32, { size:16}),
			madeByShade:Text = new Text("A game by", 67, 34, { size:16,color:0}),
			geckojsc:Text = new Text("geckojsc", 79, 98, {size:16}),
			geckojscShade:Text = new Text("geckojsc", 81, 100, {size:16,color:0}),
			simonm:Text = new Text("SimonM", 93, 164, {size:16}),
			simonmShade:Text = new Text("SimonM", 95, 166, {size:16,color:0}),
			ally:Text = new Text("AllyAlly", 107, 230, {size:16}),
			allyShade:Text = new Text("AllyAlly", 109, 232, {size:16,color:0}),
			gameName:Text = new Text("Lies TD", 410, 90,{size:32}),
			gameNameShade:Text = new Text("Lies TD", 412, 92,{size:32,color:0});
			
		public function MenuWorld() {
			addGraphic(clouds);
			clouds.blend = BlendMode.SUBTRACT;
			addGraphic(new Image(Sprites.TITLE_SCREEN));
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
			var fade:ScreenFade = new ScreenFade(2, 0xffffff, 0x000000, 1, 0, null);
			fade.blend = BlendMode.SUBTRACT;
			add(fade);
		}
		
		override public function begin():void {
			FP.screen.color = 0x00ffff;
		}
		
		private var t:int = 0;
		
		override public function update():void {
			super.update();
			clouds.x -= 1;
			
			if (t++ > 20) {
				t = 0;
				splashScreenText.visible = !splashScreenText.visible;
				splashScreenTextShade.visible = !splashScreenTextShade.visible;
			}
			
			if (Input.pressed(Key.X)) onPlay.dispatch();
		}
	}
}