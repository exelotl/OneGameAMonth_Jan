package comps.ai {
	import entities.LivingEntity;
	import net.flashpunk.Component;

	public class FollowAI extends Component	{
		
		private var livingEntity:LivingEntity;
		private var following:LivingEntity;
		
		public function FollowAI(following:LivingEntity) {
			this.following = following;
		}
		
		override public function added():void {
			if (entity is LivingEntity) livingEntity = entity as LivingEntity;
		}
		
		override public function update():void {
			if (following.x < livingEntity.x) livingEntity.runLeft();
			else if (following.x > livingEntity.x) livingEntity.runRight();
			else {
				livingEntity.stopRunning();
				//livingEntity.jump();
			}
		}
	}
}