package comps {
	import entities.LivingEntity;
	import net.flashpunk.Component;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * Simple movement control component, with jumps and moving to right and left.
	 * Uses the physics component.
	 */
	public class MovementControl extends Component{
		
		private var livingEntity:LivingEntity;
		
		public function MovementControl() { }
		
		override public function added():void {
			if (entity is LivingEntity)
				livingEntity = entity as LivingEntity;
		}
		
		override public function update():void {
			if (Input.pressed(Key.LEFT)) {
				livingEntity.runLeft()
			}
			if (Input.pressed(Key.RIGHT)) {
				livingEntity.runRight();
			}
			if (Input.released(Key.LEFT) || Input.released(Key.RIGHT)) {
				livingEntity.stopRunning();
			}
			if (Input.pressed(Key.UP)) {
				livingEntity.jump();
			}
		}
	}
}