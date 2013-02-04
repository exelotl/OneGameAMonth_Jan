package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author geckojsc
	 */
	public class Explosion extends Entity {
		
		private var
			shake:Number,
			img:Image,
			tween:NumTween;
		
		public function Explosion(x:Number=0, y:Number=0, radius:Number = 100, time:Number = 1.0, shake:Number = 10) {
			super(x, y);
			this.shake = shake;
			graphic = img = Image.createCircle(radius);
			img.centerOrigin();
			addTween(tween = new NumTween(removeSelf));
			tween.tween(1, 0, time, Ease.sineOut);
			layer = Layers.FOREGROUND;
		}
		
		private var offsetX:int=0, offsetY:int=0;
		
		override public function update():void {
			img.scale = tween.value;
			FP.camera.offset(-offsetX, -offsetY);
			offsetX = (Math.random()*2*shake - shake) * tween.value;
			offsetY = (Math.random()*2*shake - shake) * tween.value;
			FP.camera.offset(offsetX, offsetY);
		}
		
		private function removeSelf():void {
			world.remove(this);
		}
		
	}

}