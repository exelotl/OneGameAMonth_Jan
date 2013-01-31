package entities.slots {
	
	import entities.Player;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Masklist;
	
	public class CaveLeft extends Slot {
		
		[Embed(source="../../assets/cave_l.png")] private static var IMG_CAVE_L:Class;
		[Embed(source="../../assets/cave_l_overlay.png")] private static var IMG_CAVE_L_OVERLAY:Class;
		
		private var masks:Masklist = new Masklist();
		
		public function CaveLeft(x:Number=0, y:Number=0) {
			super(x, y);
			graphic = new Image(IMG_CAVE_L);
			graphic.y -= 400;
			graphic.x -= 400;
			
			masks.add(new Hitbox(400, 200, 0, 0));
			masks.add(new Hitbox(200, 200, 0, -220));
			masks.add(new Hitbox(200, 400, -30, -220));
			mask = masks;
			
			type = "ground";
			name = "cave_l";
			layer = Layers.SLOT;
		}
		
		override public function added():void {
			world.addGraphic(new Image(IMG_CAVE_L_OVERLAY), Layers.FOREGROUND, x, y-400);
		}
		
		override public function update():void {
			var player:Player = world.getInstance("player");
			if (player && player.centerX < x+180) {
				var caveRight:CaveRight = world.getInstance("cave_r");
				player.x = caveRight.x+200;
			}
		}
		
	}

}