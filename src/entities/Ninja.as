package entities {
	import comps.ai.AIUtils;
	import comps.ai.RangeDetectAI;
	import entities.ui.NinjaStar;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	
	public class Ninja extends LivingEntity {
		
		[Embed(source="../assets/ninja.png")]
		private static var IMG_NINJA:Class;
		
		private var
			target:LivingEntity,
			anim:Spritemap = new Spritemap(IMG_NINJA, 20, 20),
			sprites:MultiSpritemap = new MultiSpritemap(),
			detectFriendly:RangeDetectAI,
			runTimer:Tween;
		
		public function Ninja(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(8, 14, -12, -6);
			health = maxHealth = 30;
			physics.maxVelX = 1.8;
			price = 15;
			anim = new Spritemap(IMG_NINJA, 20, 20);
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 15, true);
			anim.add("run_r", [4,5,6,7], 15, true);
			anim.add("throw_l", [8], 15, true);
			anim.add("throw_r", [9], 15, true);
			anim.add("die_l", [10], 30, false);
			anim.add("die_r", [11], 30, false);
			sprites.addMid(anim);
			graphic = sprites;
			detectFriendly = new RangeDetectAI(EntityTypes.FRIENDLY, 100, 100);
			addComponent("detect_friendly", detectFriendly);
			detectFriendly.checkPeriod = 0.5;
			detectFriendly.onEnterRange = function(e:Entity):void {
				if (e is LivingEntity
				&& !(flags & Flags.FLEEING)
				&& !(flags & Flags.ATTACKING)) {
					target = e as LivingEntity;
					fire();
				}
			};
			
			addTween(runTimer = new Tween(0.5, 0, added));
			
			type = "ninja";
		}
		
		override public function update():void {
			super.update();
			if (dead) return;
			//if (flags & Flags.ATTACKING) {
				//var e:Entity = collideTypes(EntityTypes.FRIENDLY, x, y);
				//if (e is LivingEntity) {
					//(e as LivingEntity).damage(10, this);
				//}
			//}
			if (!(flags & Flags.RUNNING)) {
				added();
			}
		}
		
		override public function added():void {
			super.added();
			if (x < 500) runRight();
			else runLeft();
		}
		
		override public function idle():void {
			super.idle();
			sprites.play("idle_"+direction);
			flags &= ~Flags.ATTACKING;
		}
		override public function runLeft():void {
			super.runLeft();
			physics.accX = -5;
			sprites.play("run_l");
		}
		override public function runRight():void {
			super.runRight();
			physics.accX = 5;
			sprites.play("run_r");
		}
		
		override public function fire():void {
			if (target == null || target.type == "dead") {
				target = null;
				return;
			}
			physics.accX = 0;
			faceTowards(target);
			sprites.play("throw_" + direction);
			
			var diffX:Number = target.centerX - centerX;
			var diffY:Number = target.top - centerY;
			var velX:Number = AIUtils.cap(diffX/8, -6, 6);
			var velY:Number = -Math.random() - 2;
			world.add(new NinjaStar(centerX, centerY-4, velX, velY, EntityTypes.FRIENDLY));
			
			runTimer.start();
		}
		
		override public function strike():void {
			// stabbing
		}
		
		override public function damage(amount:uint, source:Entity):void {
			if (!getComponent("knockback")) {
				super.damage(amount, source);
				Audio.play(Audio.ENEMY_HURT);
			}
		}
		
		override public function die():void {
			super.die();
			physics.maxVelX = 0;
			direction = Math.random()<0.5 ? "l" : "r";
			anim.play("die_"+direction);
			clearTweens();
			removeComponent("detect_friendly");
			addTween(new Tween(2, 0, removeSelf), true);
		}
		
	}
}