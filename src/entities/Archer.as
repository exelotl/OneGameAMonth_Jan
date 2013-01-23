package entities {
	import comps.items.Bow;
	import comps.ai.WanderAI;
	import comps.items.Bow;
	import fp.MultiSpritemap;
	import net.flashpunk.graphics.Spritemap;
	
	public class Archer extends LivingEntity {
		
		[Embed(source="../assets/knight.png")]
		private static const IMG_KNIGHT:Class;
		
		private var
			anim:Spritemap = new Spritemap(IMG_KNIGHT, 20, 20),
			sprites:MultiSpritemap = new MultiSpritemap();
		
		public function Archer(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(20, 20);
			physics.maxVelX = 1.4;
			
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 15, true);
			anim.add("run_r", [4,5,6,7], 15, true);
			anim.add("jump_l", [1], 30, false);
			anim.add("jump_r", [5], 30, false);
			anim.add("strike_l", [8,9,10,11], 15, false);
			anim.add("strike_r", [12,13,14,15], 15, false);
			anim.add("drawarrow_l", [16,16,17,18,19], 30, false);
			anim.add("drawarrow_r", [20,20,21,22,23], 30, false);
			anim.add("firearrow_l", [19,18,11,0], 15, false);
			anim.add("firearrow_r", [23,22,15,4], 15, false);
			sprites.addMid(anim);
			graphic = sprites;
			
			addComponent("bow", new Bow());
			addComponent("wander", new WanderAI());
		}
		
		override public function runRight():void {
			super.runRight();
			physics.accX = 5;
			sprites.play("run_r");
		}
		
		override public function runLeft():void {
			super.runLeft();
			physics.accX = -5;
			sprites.play("run_l");
		}
		
		override public function idle():void {
			super.idle();
			physics.accX = 0;
			flags &= ~Flags.ATTACKING;
			sprites.play("idle_"+direction);
		}
		
		//override public function draw():void {
		//	
		//}
		
	}
}