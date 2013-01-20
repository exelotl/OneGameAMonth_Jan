package entities {
	import comps.Physics;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	
	/**
	 * Base for players, NPCs, enemies, etc.
	 */
	public class LivingEntity extends Entity {
		
		public var
			health:int = 0,
			maxHealth:int = 0,
			isOnFloor:Boolean = false,
			wasOnFloor:Boolean = false,
			direction:String = "r",
			physics:Physics;
		
		public function LivingEntity(x:Number = 0, y:Number = 0) {
			super(x, y);
			layer = Layers.LIVING_ENTITIES;
			
			physics = new Physics(EntityTypes.SOLIDS);
			physics.accY = 1;
			physics.dragX = 1;
			physics.maxVelX = 4;
			addComponent("physics", physics);
		}
		
		override public function update():void {
			isOnFloor = collideTypes(EntityTypes.SOLIDS, x, y+2) !== null;
			if (isOnFloor && !wasOnFloor) land();
			wasOnFloor = isOnFloor;
		}
		
		public function jump():void { }
		public function land():void { }
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
		public function knockback(amount:int):void { }
		
		public function strike():void { } /// Use a melee weapon
		public function fire():void { } /// Use a ranged weapon
		
		public function die():void { }
		
		public function damage(damage:uint):void {
			health -= damage;
			if (health < 0) {
				health = 0;
				die();
			}
		}
		
		public function repair(repair:uint):void {
			health += repair;
			if (health > maxHealth) health = maxHealth;
		}
		
	}
}