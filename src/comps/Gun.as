package comps {

	public class Gun extends Weapon	{
		
		private var knockback:int;
		
		public function Gun(trigger:int, knockback:int) {
			super(trigger);
			this.knockback = knockback;
		}
		
		override public function attack() {
			// creating or recycling a new projectile
			user.knockback(knockback); // knockback from firing the gun
		}
	}
}