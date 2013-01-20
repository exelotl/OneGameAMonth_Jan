package entities {
	import comps.Physics;
	import comps.RandomAI;
	import net.flashpunk.graphics.Image;

	public class Enemy extends LivingEntity {
		
		[Embed(source="../assets/enemy.png")]
		private static const IMG_ENEMY:Class;
		
		private var
			ai:RandomAI;
		
		public function Enemy(x:Number = 0, y:Number = 0) {
			super(x, y);
			width = 20;
			height = 20;
			
			health = maxHealth = 50;
			
			type = "enemy";
			
			physics.maxVelX = 2;
			
			ai = new RandomAI();
			//addComponent("ai", ai);
			
			runRight();
			
			graphic = new Image(IMG_ENEMY);
		}
		
		override public function update():void 
		{
			super.updateLiving();
			(graphic as Image).alpha = hitCooldown > 0 ? 0.5 : 1;
		}
		
		override public function jump():void {
			physics.velY = -8;
		}
		
		override public function runRight():void {
			physics.accX = 2;
		}
		
		override public function runLeft():void {
			physics.accX = -2;
		}
		
		override public function stopRunning():void {
			physics.accX = 0;
		}
		
		override public function die():void 
		{
			super.die();
			physics.removeCollideType("ground");
			removeComponent("ai");
			(physics as Physics).accY = 0.2;
			(physics as Physics).velY = -3;
		}
		
		override public function updateDead():void 
		{
			(graphic as Image).angle += 2;
		}
	}
}