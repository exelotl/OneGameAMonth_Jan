package entities.ui 
{
	import entities.Enemy;
	import entities.LivingEntity;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Allyally
	 */
	public class MoneySplash extends Entity
	{
		private var text:Text;
		private var tick:int = 0;
		public function MoneySplash(e:LivingEntity) 
		{
			text = new Text("+" + e.price.toString());
			super(e.x, e.y, text);
		}
		
		override public function update():void 
		{
			super.update();
			text.alpha -= 0.02;
			y--;
			tick++;
			if (tick == 50) world.remove(this);
		}
	}

}