package comps.ai {
	import net.flashpunk.Component;
	import net.flashpunk.Entity;
	
	/**
	 * Trigger callbacks when entities of certain types are detected within a certain range.
	 * Useful for toggling between different AI modes
	 * (e.g. wander when there are no enemies nearby, attack when there are)
	 */
	public class RangeDetectAI extends Component {
		
		public var
			inRange:Boolean = false,
			onEnterRange:Function,  // called with current entity as context, nearest entity as parameter.
			onLeaveRange:Function;
		
		private var
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
			update();
		}
		
		private static var entitiesInRange:Array = [];
		
		override public function update():void {
			
			for each (var t:String in types) {
				entity.world.collideRectInto(t, entity.centerX-width, entity.centerY-height, width*2, height*2, entitiesInRange);
			}
			
			var e:Entity = AIUtils.findNearest(entity, entitiesInRange);
			entitiesInRange.length = 0;
			
			if (e != null && !inRange) {
				inRange = true;
				if (onEnterRange) onEnterRange.call(entity, e);
				return;
			}
			
			if (inRange && e == null) {
				if (onLeaveRange) onLeaveRange.call(entity);
				inRange = false;
			}
		}
		
	}

}