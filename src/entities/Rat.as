package entities {
	import net.flashpunk.graphics.Spritemap;
	
	public class Rat extends LivingEntity {
		
		[Embed(source="../assets/rat.png")]
		private static const IMG_RAT:Class;
		
		private var
			anim:Spritemap = new Spritemap(IMG_RAT, 22, 16);
		
		public function Rat(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(12, 10, -5, -6);
			type = "rat";
			
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [6], 30, false);
			anim.add("run_l", [1,2,3,4,5], 30, true);
			anim.add("run_r", [7,8,9,10,11], 30, true);
			graphic = anim;
		}
		
		override public function idle():void {
			anim.play("idle_"+direction);
		}
		
		override public function runLeft():void {
			anim.play("run_l");
			physics.velX = -5;
		}
		
		override public function runRight():void {
			anim.play("run_r");
			physics.velX = 5;
		}
		
	}

}