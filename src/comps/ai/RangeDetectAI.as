package comps.ai {
	import net.flashpunk.Component;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * Trigger callbacks when entities of certain types are detected within a certain range.
	 * Useful for toggling between different AI modes
	 * (e.g. wander when there are no enemies nearby, attack when there are)
	 */
	public class RangeDetectAI extends Component {
		
		public var
			checkPeriod:Number = 0,
			inRange:Boolean = false,
			onEnterRange:Function,  // called with current entity as context, nearest entity as parameter.
			onLeaveRange:Function;
		
		private var
			timer:Number = 0,
			types:/*String*/Array,
			width:Number,
			height:Number;
		
		/**
		 * @param	types	Array of entity type names
		 * @param	w		Horizontal distance from entity to check
		 * @param	h		Vertical distance from entity to check
		 */
		public function RangeDetectAI(types:Array, w:Number, h:Number) {
			this.types = types;
			width = w;
			height = h;
		}
		
		/// execute onEnterRange even if the entity was already in the range.
		public function forceCheck():void {
			inRange = false;
		}
		
		private static var entitiesInRange:Array = [];
		
		override public function update():void {
			
			if (checkPeriod > 0) {
				timer -= FP.elapsed;
				if (timer <= 0) {
					timer = checkPeriod;
					forceCheck();
				}
			}
			
			for each (var t:String in types) {
				entity.world.collideRectInto(t, entity.centerX-width, entity.centerY-height, width*2, height*2, entitiesInRange);
			}
			
			var e:Entity = AIUtils.findNearest(entity, entitiesInRange);
			entitiesInRange.length = 0;
			
			if (e != null && !inRange) {
				inRange = true;
				if (onEnterRange != null) onEnterRange.call(entity, e);
				return;
			}
			
			if (inRange && e == null) {
				if (onLeaveRange != null) onLeaveRange.call(entity);
				inRange = false;
			}
		}
		
	}

}