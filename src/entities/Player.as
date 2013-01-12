package entities 
{
	import comps.Physics;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author geckojsc
	 */
	public class Player extends Entity {
		
		[Embed(source="../assets/player.png")]
		private static const IMG_PLAYER:Class;
		
		private var
			physics:Physics;
		
		public function Player(x:Number=0, y:Number=0) {
			super(x, y);
			width = 20;
			height = 20;
			
			physics = new Physics();
			physics.accY = 1;
			addComponent("physics", physics);
			
			graphic = new Image(IMG_PLAYER);
		}
		
	}

}