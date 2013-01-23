package comps {
	import net.flashpunk.Component;
	
	/**
	 * Use physics.impulseX and impulseY to apply a force to an entity
	 * over a number of frames, unintrusively, without being affected
	 * by maxVelX and maxVelY.
	 * The component will remove itself when its X and Y force reduces
	 * to zero.
	 */
	public class Impulse extends Component {
		
		public var
			forceX:Number,
			forceY:Number,
			dragX:Number,
			dragY:Number;
		
		private var
			physics:Physics;
		
		public function Impulse(forceX:Number, forceY:Number, dragX:Number, dragY:Number) {
			this.forceX = forceX;
			this.forceY = forceY;
			this.dragX = dragX;
			this.dragY = dragY;
		}
		
		override public function added():void {
			physics = entity.getComponent("physics");
		}
		
		override public function update():void {
			if (forceX > 0) forceX = Math.max(forceX-dragX, 0);
			else if (forceX < 0) forceX = Math.min(forceX+dragX, 0);
			
			if (forceY > 0) forceY = Math.max(forceY-dragY, 0);
			else if (forceY < 0) forceY = Math.min(forceY+dragY, 0);
			
			if (forceX === 0 && forceY === 0)
				entity.removeComponent(name);
			
			physics.impulseX += forceX;
			physics.impulseY += forceY;
		}
		
	}

}