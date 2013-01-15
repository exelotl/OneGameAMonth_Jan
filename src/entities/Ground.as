package entities {
	import net.flashpunk.Entity;

	public class Ground extends Entity {
		
		public function Ground(x:Number = 0, y:Number = 0) {
			super(x, y);
			width = 20;
			height = 20;
			type = "ground";
		}
	}
}