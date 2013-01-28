package entities {
	import comps.Impulse;
	import comps.Physics;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import states.PlayWorld;
	
	/**
	 * Base for players, NPCs, enemies, etc.
	 */
	public class LivingEntity extends Entity {
		
		public var
			health:int = 0,
			price:int = 0,
			maxHealth:int = 0,
			hitCooldown:int = 0,
			isOnFloor:Boolean = false,
			wasOnFloor:Boolean = false,
			direction:String = "r",
			physics:Physics;
		
		public function LivingEntity(x:Number = 0, y:Number = 0) {
			super(x, y);
			layer = Layers.LIVING_ENTITIES;
			
			physics = new Physics(EntityTypes.SOLIDS.concat());
			physics.accY = 0.5;
			physics.dragX = 1;
			physics.maxVelX = 4;
			addComponent("physics", physics);
		}
		
		override public function update():void {
			if (!dead) {
				isOnFloor = collideTypes(EntityTypes.SOLIDS, x, y+2) !== null;
				if (isOnFloor && !wasOnFloor) land();
				wasOnFloor = isOnFloor;
				if (hitCooldown > 0) hitCooldown--;
			}
		}
		
		public function jump():void {
			flags |= Flags.JUMPING;
		}
		public function land():void {
			flags &= ~Flags.JUMPING;
		}
		public function runRight():void {
			direction = "r";
			flags |= Flags.RUNNING;
		}
		public function runLeft():void {
			direction = "l";
			flags |= Flags.RUNNING;
		}
		public function idle():void {
			flags &= ~Flags.RUNNING;
		}
		public function knockback(amount:int, source:Entity):void {
			var forceX:Number = FP.sign(centerX - source.centerX) * amount;
			addComponent("knockback", new Impulse(forceX*0.5, -amount*0.5, 0.3, 0.2));
		}
		
		public function strike():void { } /// Use a melee weapon
		public function fire():void { } /// Use a ranged weapon
		
		public function faceTowards(e:Entity):void {
			direction = centerX < e.centerX ? "r" : "l";
		}
		
		public function die():void {
			type = "dead";
			(world as PlayWorld).onEntityDead.dispatch(this);
		}
		
		public function damage(damage:uint, source:Entity):void {
			if (hitCooldown != 0)
				return;
			hitCooldown = 10;
			health -= damage;
			if (health <= 0) {
				health = 0;
				die();
			}
			knockback(damage, source);
		}
		
		public function repair(repair:uint):void {
			health += repair;
			if (health > maxHealth) health = maxHealth;
		}
		
		public function get dead():Boolean {
			return health == 0;
		}
		
		protected function removeSelf():void {
			world.remove(this);
		}
	}
}