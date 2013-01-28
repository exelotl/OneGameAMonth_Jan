package entities {
	import fp.MultiSpritemap;
	import net.flashpunk.graphics.Spritemap;
	
	public class Ninja extends LivingEntity {
		
		[Embed(source="../assets/ninja.png")]
		private static var IMG_NINJA:Class;
		
		private var
			anim:Spritemap,
			sprites:MultiSpritemap;
			
		
		public function Ninja(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(8, 12, -12, -8);
			anim = new Spritemap(IMG_NINJA, 20, 20);
			
		}
		
		override public function update():void {
			
		}
		
		override public function added():void {
			super.added();
			if (x < 500) runRight();
			else runLeft();
		}
		
		override public function idle():void {
			super.idle();
		}
		override public function runLeft():void {
			super.runLeft();
		}
		override public function runRight():void {
			super.runRight();
		}
		
	}
}