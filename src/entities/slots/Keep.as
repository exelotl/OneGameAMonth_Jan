package entities.slots {
	import entities.Archer;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Masklist;

	public class Keep extends Tower {
		
		[Embed(source="../../assets/keep.png")]
		private static const IMG_KEEP:Class;
		
		private static const
			maxArchers:uint = 2,
			maxArchersOnGround:uint = 3;
			
		private var
			roof:KeepRoof,
			amountOfArchers:uint = 0,
			amountOfArchersOnGround:uint = 0;
		
		public function Keep(x:Number = 0, y:Number = 0) {
			super(x, y);
			health = maxHealth = 70;
			currentUpgrade = Upgrade.KEEP;
			maxKnights = 2;
			graphic = new Image(IMG_KEEP);
			graphic.y = -200;
			width = 200;
			height = 200;
			type = "keep";
		}
		
		override public function added():void {
			super.added();
			roof = new KeepRoof(this);
			world.add(roof);
		}
		
		override public function removed():void {
			super.removed();
			world.remove(roof);
		}
		
		override public function update():void {
			super.update();
			if (amountOfArchers < maxArchers) {
				if (Math.random() < 0.002) {
					var archer:Archer = new Archer(roof.spawnX, roof.spawnY, this);
					archer.layer = Layers.BEHIND_ROOF;
					world.add(archer);
					amountOfArchers++;
				}
			}
			if (amountOfArchersOnGround < maxArchersOnGround) {
				if (Math.random() < 0.001) {
					world.add(new Archer(x + width / 2, y - 21, this, true));
					amountOfArchersOnGround++;
				}
			}
		}
		
		override public function get upgrades():Array {
			return [];
		}
		
		public function archerIsKilled(onGround:Boolean):void {
			if (onGround) {
				amountOfArchersOnGround--;
			} else {
				amountOfArchers--;
			}
		}
	}
}