package entities {
	import comps.AttackNearestAI;
	import comps.Shield;
	import comps.Sword;
	import comps.WanderBehaviour;
	import fp.MultiSpritemap;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	
	
	public class Knight extends LivingEntity {
		
		[Embed(source="../assets/knight.png")]
		private static const IMG_KNIGHT:Class;
		
		private var
			anim:Spritemap = new Spritemap(IMG_KNIGHT, 20, 20),
			sprites:MultiSpritemap = new MultiSpritemap();
		
		public function Knight(x:Number=0, y:Number=0) {
			super(x, y);
			
			width = 20;
			height = 20;
			
			addComponent("wander", new WanderBehaviour());
			physics.maxVelX = 1;
			
			addComponent("attack ai", new AttackNearestAI());
			
			graphic = sprites;
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 15, true);
			anim.add("run_r", [4,5,6,7], 15, true);
			anim.add("jump_l", [1], 30, false);
			anim.add("jump_r", [5], 30, false);
			anim.add("strike_l", [8,9,10,11], 15, false);
			anim.add("strike_r", [12,13,14,15], 15, false);
			sprites.addMid(anim);
			
			addComponent("sword", new Sword());
			addComponent("shield", new Shield());
		}
		
		override public function jump():void {
			super.jump();
			physics.velY = -8;
			sprites.play("jump_"+direction);
		}
		
		override public function land():void {
			super.land();
			if (physics.accX === 0) {
				sprites.play("idle_"+direction);
			} else {
				sprites.play("run_"+direction);
			}
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
		
		override public function strike():void {
			sprites.play("strike_"+direction);
			flags |= Flags.ATTACKING;
			addTween(new Alarm(0.2, idle, Tween.ONESHOT), true);
			
			var e_list:Array = [];
			collideTypesInto(EntityTypes.ENEMIES, x, y, e_list);
			for each (var e:LivingEntity in e_list)
				e.damage(10, this);
		}
		
	}
}