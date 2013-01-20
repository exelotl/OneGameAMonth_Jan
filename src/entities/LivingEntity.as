package entities {
	import comps.Physics;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * Base for players, NPCs, enemies, etc.
	 */
	public class LivingEntity extends Entity {
		
		public var
			health:int = 0,
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
			physics.accY = 1;
			physics.dragX = 1;
			physics.maxVelX = 4;
			addComponent("physics", physics);
		}
		
		override public function update():void {
			if (! dead) updateLiving();
			else updateDead();
		}
		
		public function updateLiving():void
		{
			isOnFloor = collideTypes(EntityTypes.SOLIDS, x, y+2) !== null;
			if (isOnFloor && !wasOnFloor) land();
			wasOnFloor = isOnFloor;
			if (hitCooldown > 0) hitCooldown--;
		}
		
		public function updateDead():void { }
		
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
		public function knockback(amount:int, damageSource:LivingEntity):void
		{
			physics.velY = -amount / 2;
		}
		
		public function strike():void { } /// Use a melee weapon
		
		public function fire():void { } /// Use a ranged weapon
		
		public function die():void
		{
			type = "dead";
		}
		
		public function damage(damage:uint, damageSource:LivingEntity):void {
			health -= damage;
			hitCooldown = 10;
			if (health <= 0) {
				health = 0;
				die();
				return;
			}
			knockback(damage, damageSource);
		}
		
		public function repair(repair:uint):void {
			health += repair;
			if (health > maxHealth) health = maxHealth;
		}
		
		public function stopRunning():void { };
		
		public function get dead():Boolean
		{
			return health == 0;
		}
	}
}