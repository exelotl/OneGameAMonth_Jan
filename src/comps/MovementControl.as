package comps {
	import net.flashpunk.Component;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * Simple movement control component, with jumps and moving to right and left.
	 * Uses the physics component.
	 */
	public class MovementControl extends Component{
		
		private var physics:Physics;
		
		public function MovementControl() { }
		
		override public funtion added():void {
			physics = entity.getComponent("physics");
		}
		
		override public function update():void {
			if (physics) {
				if (Input.pressed(Key.left)) {
					physics.accX = -5;
				}
				if (Input.pressed(Key.RIGHT)) {
					physics.accX = 5;
				}
				if (Input.pressed(Key.UP)) {
					physics.velX = -8;
				}
			}
		}
	}
}