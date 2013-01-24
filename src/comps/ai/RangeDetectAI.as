package comps.ai {
	import net.flashpunk.Component;
	import net.flashpunk.Entity;
	import net.flashpunk.Signal;
	
	/**
	 * Dispatch signals when entities of certain types are detected within a certain range.
	 * Useful for toggling between different AI modes
	 * (e.g. wander when there are no enemies nearby, attack when there are)
	 */
	public class RangeDetectAI extends Component {
		
		public var
			onEnterRange:Signal = new Signal(),
			onLeaveRange:Signal = new Signal();
		
		private var
			types:/*String*/Array,
			inRange:Boolean = false,
			width:Number,
			height:Number;
		
		public function RangeDetectAI(types:Array, w:Number, h:Number) {
			this.types = types;
			width = w;
			height = h;
		}
		
		override public function update():void {
			var e:Entity;
			
			for each (var t:String in types) {
				e = entity.world.collideRect(t, entity.centerX-width/2, entity.centerY-height/2, width, height);
				if (e != null && !inRange) {
					inRange = true;
					onEnterRange.dispatch(this, e);
					return;
				}
			}
			
			if (inRange && e == null) {
				onLeaveRange.dispatch(this, e);
				inRange = false;
			}
		}
		
	}

}