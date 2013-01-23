package comps.ai 
{
	import entities.Enemy;
	import entities.LivingEntity;
	import net.flashpunk.Component;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Allyally
	 */
	public class AttackNearestAI extends Component
	{
		
		private var livingEntity:LivingEntity;
		private var target:Enemy;
		private var tick:int = 0;
		
		public function AttackNearestAI() { }
		
		override public function added():void {
			if (entity is LivingEntity) livingEntity = entity as LivingEntity;
		}
		
		override public function update():void 
		{
			tick++;
			
			if (tick == 30)
			{
				updateTarget();
				tick = 0;
			}
			
			if (target)
			{
				if (target.x < livingEntity.x) livingEntity.runLeft();
				if (target.x > livingEntity.x) livingEntity.runRight();
			}
			
			super.update();
		}
		
		private function updateTarget():void
		{
			var d:Number = 1000;
			for each (var t:String in EntityTypes.ENEMIES)
			{
				var a:Array = [];
				livingEntity.world.getType(t, a);
				
				for (var i:int = 0; i < a.length; i++)
				{
					var d1 = FP.distance(livingEntity.x, livingEntity.y, a[i].x, a[i].y);
					if (d1 < d)
					{
						target = a[i] as Enemy;
						d = d1;
					}
				}
			}
		}
	}

}