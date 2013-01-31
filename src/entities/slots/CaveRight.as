package entities.slots {
	import entities.Player;
	import entities.slots.Slot;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Masklist;
	
	public class CaveRight extends Slot {
		
		[Embed(source="../../assets/cave_r.png")] private static var IMG_CAVE_R:Class;
		[Embed(source="../../assets/cave_r_overlay.png")] private static var IMG_CAVE_R_OVERLAY:Class;
		
		private var masks:Masklist = new Masklist();
		
		public function CaveRight(x:Number=0, y:Number=0) {
			super(x, y);
			graphic = new Image(IMG_CAVE_R);
			graphic.y -= 400;
			
			masks.add(new Hitbox(400, 200, 0, 0));
			masks.add(new Hitbox(200, 200, 200, -220));
			masks.add(new Hitbox(200, 400, 230, -220));
			mask = masks;
			
			type = "ground";
			name = "cave_r";
			layer = Layers.SLOT;
		}
		
		override public function added():void {
			world.addGraphic(new Image(IMG_CAVE_R_OVERLAY), Layers.FOREGROUND, x+200, y-400);
		}
		
		override public function update():void {
			var player:Player = world.getInstance("player");
			if (player && player.centerX > x+220) {
				var caveLeft:CaveLeft = world.getInstance("cave_l");
				player.x = caveLeft.x + 176;
			}
		}
		
	}

}
