package entities.slots {
	import net.flashpunk.graphics.Image;

	public class Trap extends Slot {
		
		[Embed(source="../../assets/land.png")]
		private static const IMG_TRAP_SLOT:Class;
		
		private var
			image:Image,
			killed:int = 20;
			
		private static var
			trapped:Array;
			
		public function Trap(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y);
			currentUpgrade = Upgrade.TRAP;
			image = new Image(IMG_TRAP_SLOT);
			graphic = image;
			setHitbox(200, 200);
			trapped = new Array();
		}
		
		override public function update():void {
			for (var i:int = 0; i < EntityTypes.ENEMIES.length; i++) {
				world.collideRectInto(EntityTypes.ENEMIES[i], x+20, y, 160, 200, trapped);
			}
			for (i = 0; i < trapped.length; i++) {
				if (Math.random() < 0.01 && killed) {
					trapped[i].die();
					killed--;
				} else if (!killed) {
					requestUpgrade(Upgrade.LAND);
				}
			}
			trapped.length = 0;
		}
	}
}