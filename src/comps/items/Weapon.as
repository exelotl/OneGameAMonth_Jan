package comps.items {
	import entities.LivingEntity;
	import net.flashpunk.Component;
	
	public class Weapon extends Component{
		
		protected var 
			user:LivingEntity;
		
		public function Weapon() {
		}
		
		override public function added():void {
			if (entity is LivingEntity) user = entity as LivingEntity;
		}
		
		override public function update():void {
			
		}
		
		public function attack() { }
	}
}