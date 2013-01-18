package comps {
	import entities.LivingEntity;
	import flash.sampler.NewObjectSample;
	import net.flashpunk.Component;
	import net.flashpunk.utils.Input;
	
	public class Weapon extends Component{
		
		protected var 
			user:LivingEntity,
			key:int;
		
		public function Weapon(key:int) {
			this.key = key;
		}
		
		override public function added():void {
			if (entity is LivingEntity) user = entity as LivingEntity;
		}
		
		override public function update():void {
			if (Input.pressed(key)) {
				this.attack();
			}
		}
		
		public function attack() { }
	}
}