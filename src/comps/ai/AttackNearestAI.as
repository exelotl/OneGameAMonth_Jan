package comps.ai {
	import entities.LivingEntity;
	import net.flashpunk.Component;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Allyally
	 */
	public class AttackNearestAI extends Component {
		
		private var targetTypes:/*String*/Array;
		private var livingEntity:LivingEntity;
		private var target:LivingEntity;
		private var tick:int = 0;
		private var delay:int = 0;
		
		public function AttackNearestAI(types:/*String*/Array) {
			targetTypes = types;
		}
		
		override public function added():void {
			if (entity is LivingEntity) livingEntity = entity as LivingEntity;
		}
		
		override public function update():void {
			super.update();
			
			if (entity.flags & Flags.ATTACKING)
				return;
			
			if (delay > 0) {
				delay--;
				return;
			}
			
			if (++tick == 30) {
				updateTarget();
				tick = 0;
			}
			
			if (target && target.y < entity.y+20 && target.y > entity.y-10) {
				if (Math.abs(entity.centerX - target.centerX) < 20) {
					livingEntity.idle();
					livingEntity.strike();
					delay = Math.random()*40;
				}
				else if (target.x < entity.x) livingEntity.runLeft();
				else if (target.x > entity.x) livingEntity.runRight();
			}
		}
		
		
		private static var enemies:/*LivingEntity*/Array = [];
		
		private function updateTarget():void {
			var d:Number = 500;
			
			for each (var t:String in targetTypes)
				livingEntity.world.getType(t, enemies);
				
			for each (var e:LivingEntity in enemies) {
				var d1 = FP.distance(livingEntity.x, livingEntity.y, e.x, e.y);
				if (d1 < d){
					target = e;
					d = d1;
				}
			}
			enemies.length = 0;
		}
	}

}