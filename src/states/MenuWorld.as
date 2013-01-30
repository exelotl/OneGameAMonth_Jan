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
		
		[Embed(source = "../assets/nightsky.png")]
		private static const IMG_NIGHT_SKY:Class;
		
		public var onPlay:Signal = new Signal();
		
		private var splashScreenText:Text;
		
		public function MenuWorld() {
			addGraphic(new Image(IMG_NIGHT_SKY));
			splashScreenText = new Text("Press X to play");
			splashScreenText.x = (600 - splashScreenText.width) / 2;
			splashScreenText.y = 350;
			splashScreenText.color = 0x000000;
			addGraphic(splashScreenText);
		}
		
		override public function update():void {
			super.update();
			if (Input.pressed(Key.X)) onPlay.dispatch();
		}
	}
}