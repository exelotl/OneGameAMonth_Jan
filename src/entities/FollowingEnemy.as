package entities {
	import comps.Physics;
	import comps.FollowAI;
	import net.flashpunk.graphics.Image;
	
	public class FollowingEnemy extends LivingEntity {
		
		[Embed(source="../assets/enemy.png")]
		private static const IMG_ENEMY:Class;
		
		private var
			ai:FollowAI;
		
		public function FollowingEnemy(x:Number = 0, y:Number = 0, following:LivingEntity = null) {
			super(x, y);
			width = 20;
			height = 20;
			
			physics.maxVelX = 2;
			
			ai = new FollowAI(following);
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
		
		override public function idle():void {
			physics.accX = 0;
		}
	}
}