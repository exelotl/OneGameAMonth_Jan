package comps {
	import entities.LivingEntity;
	import net.flashpunk.Component;

	public class RandomAI extends Component {
		
		private var livingEntity:LivingEntity;
		private var count:int;
		
		public function RandomAI() { }
		
		override public function added():void {
			if (entity is LivingEntity) livingEntity = entity as LivingEntity;
		}
		
		override public function update():void {
			count++;
			if (count == 10) {
				count = 0;
				var chance:int = Math.round(Math.random() * 20);
				if (chance <= 4) livingEntity.runRight();
				else if (chance <= 9) livingEntity.runLeft();
				else if (chance <= 12) livingEntity.jump();
				else livingEntity.idle();
			}
		}
	}
}