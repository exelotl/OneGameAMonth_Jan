package entities {
	import comps.Physics;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;

	public class LivingEntity extends Entity {
		
		public var
			isRunning:Boolean = false,
			isOnFloor:Boolean = false,
			wasOnFloor:Boolean = false,
			direction:String = "r",
			physics:Physics;
		
		public function LivingEntity(x:Number = 0, y:Number = 0) {
			super(x, y);
			layer = Layers.LIVING_ENTITIES;
			
			physics = new Physics(EntityTypes.SOLIDS);
			physics.accY = 1;
			physics.dragX = 6;
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
			isRunning = true;
		}
		public function runLeft():void {
			direction = "l";
			isRunning = true;
		}
		public function stopRunning():void {
			isRunning = false;
		}
		public function knockback(amount:int):void { }
		
		public function strike():void { } /// Use a melee weapon
		public function fire():void { } /// Use a ranged weapon
		
	}
}