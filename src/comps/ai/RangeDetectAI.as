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
			onEnterRange:Function,
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
		
		override public function update():void {
			var e:Entity;
			
			for each (var t:String in types) {
				e = entity.world.collideRect(t, entity.centerX-width, entity.centerY-height, width*2, height*2);
				if (e != null && !inRange) {
					inRange = true;
					if (onEnterRange) onEnterRange(entity, e);
					return;
				}
			}
			
			if (inRange && e == null) {
				if (onLeaveRange) onLeaveRange(entity);
				inRange = false;
			}
		}
		
	}

}