package states {
	import entities.ui.ScreenFade;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Signal;
	import net.flashpunk.Tween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class SplashWorld extends World {
		
		public var
			onComplete:Signal = new Signal();
		
		private var
			timer:Tween = new Tween(5, 0, fadeout),
			fpLogo:Spritemap = new Spritemap(Sprites.FLASHPUNK, 100, 100);
		
		public function SplashWorld() {
			fpLogo.add("a", [0,1,2,3,4], 10);
			fpLogo.play("a");
			fpLogo.scale = 2;
			add(new Entity(220, 70, fpLogo));
			
			addTween(timer, true);
			var fade:ScreenFade = new ScreenFade(1, 0xffffff, 0x0, 1, 0, null);
			fade.blend = BlendMode.SUBTRACT;
			add(fade);
		}
		
		private function fadeout():void {
			var fade:ScreenFade = new ScreenFade(1, 0x0, 0xffffff, 0, 1, onComplete.dispatch);
			fade.blend = BlendMode.SUBTRACT;
			add(fade);
		}
		
		override public function begin():void {
			FP.screen.color = 0x202020;
		}
		
		override public function update():void {
			super.update();
			if (Input.pressed(Key.ANY))
				timer.percent = 1;
		}
		
	}

}