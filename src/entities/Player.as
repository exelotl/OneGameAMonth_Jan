package entities 
{
	import comps.MovementControl;
	import comps.Physics;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author geckojsc
	 */
	public class Player extends LivingEntity {
		
		[Embed(source="../assets/player.png")]
		private static const IMG_PLAYER:Class;
		
		private var
			physics:Physics,
			control:MovementControl;
		
		public function Player(x:Number=0, y:Number=0) {
			super(x, y);
			width = 20;
			height = 20;
			
			physics = new Physics(["ground"]);
			physics.accY = 1;
			physics.dragX = 6;
			physics.maxVelX = 4;
			addComponent("physics", physics);
			
			control = new MovementControl();
			addComponent("control", control);
			
			graphic = new Image(IMG_PLAYER);
		}
		
		override public function jump():void {
			physics.velY = -8;
		}
		
		override public function runRight():void {
			physics.accX = 5;
		}
		
		override public function runLeft():void {
			physics.accX = -5;
		}
		
		override public function stopRunning():void {
			physics.accX = 0;
		}
		
	}

}