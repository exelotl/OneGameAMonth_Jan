package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import states.PlayWorld;
	/**
	 * ...
	 * @author Allyally
	 */
	public class GUI extends Entity
	{
		[Embed(source = "../assets/coin_spin.png")]
		private var coin_spin:Class;
		
		private var p_world:PlayWorld;
		
		private var currencyTxt:Text;
		private var currencyImg:Spritemap;
		
		public function GUI() 
		{
			currencyTxt = new Text("Money: ", 20, 0, {color:0});
			currencyTxt.scrollX = 0;
			currencyTxt.scrollY = 0;
			
			currencyImg = new Spritemap(coin_spin, 12, 12);
			currencyImg.add("spin", FP.frames(1, 6), 10);
			currencyImg.play("spin");
			currencyImg.scrollX = 0;
			currencyImg.scrollY = 0;
			currencyImg.x = 3;
			currencyImg.y = 3;
			
			addGraphic(currencyTxt);
			addGraphic(currencyImg);
			
			layer = Layers.GUI;
		}
		
		override public function added():void 
		{
			super.added();
			p_world = world as PlayWorld;
		}
		
		override public function update():void 
		{
			super.update();
			currencyTxt.text = String(p_world.money);
		}
	}

}