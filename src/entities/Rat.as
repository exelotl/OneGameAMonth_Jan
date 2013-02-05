package entities {
	import entities.slots.Slot;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import states.PlayWorld;
	
	public class Rat extends LivingEntity {
		
		[Embed(source="../assets/rat.png")]
		private static const IMG_RAT:Class;
		
		private var
			anim:Spritemap = new Spritemap(IMG_RAT, 22, 16);
		
		public function Rat(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(10, 10, -12, -5);
			physics.maxVelX = 3;
			physics.accY = 0.2;
			price = 5;
			type = "rat";
			anim.add("idle_r", [0], 30, false);
			anim.add("idle_l", [6], 30, false);
			anim.add("run_r", [1,2,3,4,5], 30, true);
			anim.add("run_l", [7,8,9,10,11], 30, true);
			graphic = anim;
			maxHealth = 5;
			health = maxHealth;
		}
		
		override public function added():void {
			if (x < 500) runRight();
			else runLeft();
		}
		
		override public function update():void {
			super.update();
			if (Math.abs(physics.velX) == physics.maxVelX) {
				collideEach(EntityTypes.FRIENDLY, x, y, onCollideFriendly);
			}
			
			var slot:Slot = (world as PlayWorld).getSlotAt(this);
			
			if (canDamageSlot(slot)) {
				physics.velX = 0;
				physics.velY = -1;
				slot.damage(2);
			}
		}
		
		public function onCollideFriendly(e:Entity):void {
			var friendly:LivingEntity = e as LivingEntity;
			friendly.damage(10, this);
			physics.velX = 0;
		}
		
		private function canDamageSlot(slot:Slot):Boolean {
			return slot != null
				&& isOnFloor
				&& EntityTypes.ATTACKABLE_SLOTS.indexOf(slot.type) != -1
				&& Math.abs(physics.velX) == physics.maxVelX;
		}
		
		override public function damage(amount:uint, source:Entity):void {
			if (!getComponent("knockback")) {
				super.damage(amount, source);
				Audio.play(Audio.RAT_HURT, 0.8);
			}
		}
		
		override public function idle():void {
			anim.play("idle_"+direction);
			physics.accX = 0;
		}
		
		override public function runLeft():void {
			anim.play("run_l");
			physics.accX = -0.1;
		}
		
		override public function runRight():void {
			anim.play("run_r");
			physics.accX = 0.1;
		}
		
		override public function die():void {
			super.die();
			idle();
			anim.scaleY = -1;
			anim.y = 22;
			anim.alpha = 0.6;
			addTween(new Tween(1, 0, removeSelf), true);
		}
		
	}

}