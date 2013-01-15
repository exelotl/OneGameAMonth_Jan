package entities {
	import comps.Physics;
	import comps.RandomAI;
	import net.flashpunk.graphics.Image;

	public class Enemy extends LivingEntity {
		
		[Embed(source="../assets/player.png")]
		private static const IMG_ENEMY:Class;
		
		private var
			physics:Physics,
			ai:RandomAI;
		
		public function Enemy(x:Number = 0, y:Number = 0) {
			super(x, y);
			width = 20;
			height = 20;
			
			physics = new Physics(["ground"]);
			physics.accY = 1;
			physics.dragX = 6;
			physics.maxVelX = 2;
			addComponent("physics", physics);
			
			ai = new RandomAI();
			addComponent("ai", ai);
			
			graphic = new Image(IMG_ENEMY);
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