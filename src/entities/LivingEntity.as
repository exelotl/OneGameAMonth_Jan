package entities {
	import net.flashpunk.Entity;

	public class LivingEntity extends Entity {
		
		public function LivingEntity(x:Number = 0, y:Number = 0) {
			super(x, y);
			layer = Layers.LIVING_ENTITIES;
		}
		
		public function isOnFloor():Boolean {
			return collideTypes(EntityTypes.SOLIDS, x, y+2) !== null;
		}
		
		public function jump():void { }
		public function runRight():void { }
		public function runLeft():void { }
		public function stopRunning():void { }
		public function knockback(amount:int):void { }
	}
}