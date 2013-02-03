package entities.ui {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.ColorTween;
	
	public class ScreenFade extends Entity {
		
		private var
			start:uint, end:uint,
			startAlpha:Number, endAlpha:Number,
			image:Image = new Image(new BitmapData(FP.width, FP.height)),
			colorTween:ColorTween;
		
		public function ScreenFade(duration:Number, start:uint, end:uint,
		                           startAlpha:Number, endAlpha:Number, callback:Function) {
			colorTween = new ColorTween(callback);
			this.start = start;
			this.end = end;
			this.startAlpha = startAlpha;
			this.endAlpha = endAlpha;
			graphic = image;
			graphic.scrollX = graphic.scrollY = 0;
			layer = Layers.SCREEN_PROCESSING;
			colorTween.tween(duration, start, end, startAlpha, endAlpha);
		}
		
		override public function added():void {
			addTween(colorTween, true);
			layer = Layers.SCREEN_PROCESSING;
			update();
		}
		
		public function get complete():Function {
			return colorTween.complete;
		}
		public function set complete(val:Function):void {
			colorTween.complete = val;
		}
		
		public function get blend():String {
			return image.blend;
		}
		public function set blend(val:String):void {
			image.blend = val;
		}
		
		public function reverse(duration:Number):void {
			colorTween.tween(duration, end, start, endAlpha, startAlpha);
			colorTween.start();
		}
		
		override public function update():void {
			image.color = colorTween.color;
			image.alpha = colorTween.alpha;
		}
		
	}
}