package entities.slots {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Masklist;
	
	public class KeepRoof extends Entity {
		
		public function get spawnX():Number {
			return x + 100;
		}
		public function get spawnY():Number {
			return y + 44;
		}
		
		private var
			keep:Keep,
			masks:Masklist = new Masklist();
		
		public function KeepRoof(keep:Keep) {
			super(keep.x, keep.y-200, new Image(Sprites.KEEP_ROOF), masks);
			this.keep = keep;
			type = "roof";
			layer = Layers.ROOF;
			
			masks.add(new Hitbox(2, 2, 62, 66));
			masks.add(new Hitbox(2, 2, 140, 66));
			masks.add(new Hitbox(80, 20, 62, 68));
		}
		
	}

}