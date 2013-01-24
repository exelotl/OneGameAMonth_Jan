package comps.ai {
	
	import entities.LivingEntity;
	import net.flashpunk.Component;
	
	/**
	 * Causes an entity to run away until it is outside a given area.
	 */
	public class FleeRectAI extends Component {
		
		public var onDone:Function;
		
		private var
			livingEntity:LivingEntity,
			x:Number, y:Number,
			w:Number, h:Number;
		
		public function FleeRectAI(x:Number, y:Number, w:Number, h:Number) {
			this.x = x;
			this.y = y;
			this.w = w;
			this.h = h;
		}
		
		override public function added():void {
			livingEntity = entity as LivingEntity;
			
			if (livingEntity.centerX > x + w/2) {
				livingEntity.runLeft();
			} else {
				livingEntity.runRight();
			}
		}
		
		override public function update():void {
			if (!entity.collideRect(entity.x, entity.y, x,y,w,h)) {
				onDone();
				livingEntity.idle();
				entity.removeComponent(name);
			}
		}
		
	}

}