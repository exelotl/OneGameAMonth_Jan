package comps {
	import net.flashpunk.Component;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * Simple physics component, with collision etc.
	 * All values are measured in pixels-per-frame.
	 */
	public class Physics extends Component {
		
		private var
			canCollide:Boolean = true,
			collideTypes:/*String*/Array;
		
		public var
			velX:Number = 0,
			velY:Number = 0,
			maxVelX:Number = 9999,
			maxVelY:Number = 9999,
			accX:Number = 0,
			accY:Number = 0,
			dragX:Number = 0,
			dragY:Number = 0,
			impulseX:Number = 0,
			impulseY:Number = 0,
			bounce:Number = 0,
			sweep:Boolean = false;
		
		public function Physics(collideTypes:/*String*/Array = null) {
			this.collideTypes = collideTypes || [];
		}
		
		/**
		 * Call this if you want the physics to ignore collision for the current frame.
		 * Always returns false, so you can return it in your entity's moveCollideX and moveCollideY handlers.
		 */
		public function passThrough():Boolean {
			return canCollide = false;
		}
		
		override public function update():void {
			if (accX === 0) {
				if (velX < 0) velX = Math.min(velX+dragX, 0);
				else if (velX > 0) velX = Math.max(velX-dragX, 0);
			} else {
				velX = velX + accX;
			}
			if (velX < -maxVelX) velX = -maxVelX;
			else if (velX > maxVelX) velX = maxVelX;
			
			if (accY === 0) {
				if (velY < 0) velY = Math.min(velY+dragY, 0);
				else if (velY > 0) velY = Math.max(velY-dragY, 0);
			} else {
				velY = velY + accY;
			}
			if (velY < -maxVelY) velY = -maxVelY;
			else if (velY > maxVelY) velY = maxVelY;
			
			entity.moveBy(velX+impulseX, velY+impulseY, collideTypes, sweep);
			
			impulseX = impulseY = 0;
		}
		
		override public function moveCollideX(e:Entity):void {
			velX = FP.sign(velX) * -bounce;
		}
		override public function moveCollideY(e:Entity):void {
			velY = FP.sign(velY) * -bounce;
		}
		
		public function addCollideType(type:String):void {
			if (!collidesWithType(type))
				collideTypes.push(type);
		}
		
		public function removeCollideType(type:String):void {
			var index:int = collideTypes.indexOf(type);
			if (index !== -1)
				collideTypes.splice(index, 1);
		}
		
		public function collidesWithType(type:String):Boolean {
			return collideTypes.indexOf(type) !== -1;
		}
		
	}

}