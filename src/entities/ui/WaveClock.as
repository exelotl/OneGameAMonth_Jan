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
			currentWave:Wave,
			scheduler:WaveScheduler,
			clock:Spritemap = new Spritemap(IMG_CLOCK, 30, 30),
			skipBtn:Spritemap = new Spritemap(IMG_BTN_SKIP, 40, 20);
		
		public function WaveClock(scheduler:WaveScheduler, x:Number=0, y:Number=0) {
			super(x, y);
			this.scheduler = scheduler;
			
			//scheduler.onWaveBegin.add(function (wave:Wave):void {
			//	skipBtn.visible = wave.canSkip;
			//});
			
			skipBtn.x = 36;
			skipBtn.y = 5;
			
			clock.scrollX = clock.scrollY = 0;
			skipBtn.scrollX = skipBtn.scrollY = 0;
			
			addGraphic(clock);
			addGraphic(skipBtn);
			layer = Layers.GUI;
		}
		
		override public function update():void {
			setClockPos(scheduler.timeRatio);
			
			if (skipBtn.visible) {
				var mX:Number = Input.mouseX - x - skipBtn.x;
				var mY:Number = Input.mouseY - y - skipBtn.y;
				
				if (mX > 0 && mY > 0 && mX < skipBtn.width && mY < skipBtn.height) {
					skipBtn.frame = 1;
					if (Input.mousePressed)
						scheduler.startNextWave();
				} else {
					skipBtn.frame = 0;
				}
			}
		}
		
		public function setClockPos(proportion:Number):void {
			clock.frame = int(proportion * 40);
		}
		
	}

}