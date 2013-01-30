package entities.ui {
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	
	public class WaveClock extends Entity {
		
		[Embed(source="../../assets/clock.png")]
		private static var IMG_CLOCK:Class;
		
		[Embed(source="../../assets/btn_skip.png")]
		private static var IMG_BTN_SKIP:Class;
		
		private var
			_canSkip:Boolean = false,
			clock:Spritemap = new Spritemap(IMG_CLOCK, 30, 30),
			skipBtn:Spritemap = new Spritemap(IMG_BTN_SKIP, 40, 20);
		
		public function WaveClock(x:Number=0, y:Number=0) {
			super(x, y);
			addGraphic(clock);
			addGraphic(skipBtn);
		}
		
		public function set canSkip(val:Boolean):void {
			skipBtn.visible = val;
		}
		
		override public function update():void {
			var mX:Number = Input.mouseX + x + skipBtn.x;
			var mY:Number = Input.mouseY + y + skipBtn.y;
			
			if (mX > 0 && mY > 0 && mX < skipBtn.width && mY < skipBtn.height) {
				skipBtn.frame = 1;
			} else {
				skipBtn.frame = 0;
			}
		}
		
	}

}