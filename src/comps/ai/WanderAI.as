package comps.ai {
	import entities.LivingEntity;
	import net.flashpunk.Component;
	
	/**
	 * Walking around aimlessly.
	 */
	public class WanderAI extends Component {
		
		private var livingEntity:LivingEntity;
		private var count:int;
		
		public function WanderAI() {
			
		}
		
		override public function added():void {
			if (entity is LivingEntity) livingEntity = entity as LivingEntity;
		}
		
		override public function update():void {
			count--;
			if (count <= 0) {
				var chance:Number = Math.random();
				if (chance < 0.2) {
					livingEntity.runRight();
					count = Math.random()*50 + 20;
				} else if (chance < 0.4) {
					livingEntity.runLeft();
					count = Math.random()*50 + 20;
				} else {
					livingEntity.idle();
					count = Math.random()*20 + 20;
				}
			}
		}
		
	}

}