package comps.ai {
	import net.flashpunk.Entity;
	
	public class AIUtils {
		
		public static function findNearest(self:Entity, entities:Array):Entity {
			var shortest:Number = 99999999999;
			var nearest:Entity;
			for each (var e:Entity in entities) {
				var d:Number = distanceSq(e.centerX - self.centerX, e.centerY - self.centerY);
				if (d < shortest) {
					nearest = e;
					shortest = d;
				}
			}
			return nearest;
		}
		
		/// Math.sqrt is expensive, and not always necessary.
		private static function distanceSq(diffX:Number, diffY:Number):Number {
			return diffX*diffX + diffY*diffY;
		}
	}

}