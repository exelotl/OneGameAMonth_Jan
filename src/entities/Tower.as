package entities {

	public class Tower extends LandSlot {
		
		public function Tower(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y, health);
		}
		
		override public function upgrade():void {
			// blah blah
		}
	}
}