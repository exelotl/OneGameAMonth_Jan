package {
	import net.flashpunk.Tween;
	
	public class Wave {
		
		public static var gameSequence:Array = [
			{
				name: "Welcome",
				note: "Arrows to move, X to jump!",
				time: 0,
				canSkip: true
			},
			{
				name: "Build Something",
				note: "On a patch of land, use Z to open a menu.\nPress Up/Down and Enter to select.",
				time: 2,
				canSkip: true
			},
			{
				name: "Zombies",
				note: "Press C to swipe your sword, defend the castle!",
				time: 5,
				spawns: [{type:"zombie", amount:10}],
				difficulty: 1
			},
			{
				name: "Wave over",
				note: "Now would be a good time to apply some upgrades.",
				time: 2,
				canSkip: true
			},
			{
				name: "That's it for now."
			},
		];
		
		public static const
			DAY:uint = 1,
			NIGHT:uint = 1;
		
		public var
			title:String,
			note:String,
			time:Number,
			spawns:Array,
			difficulty:Number,
			canSkip:Boolean,
			spawner:MobSpawner;
		
		public function Wave(data:Object = null) {
			if (data == null) data = {};
			title = data.name || "";
			note = data.note || "";
			time = data.time || 5;
			time += 10; // to make sure all mobs reached the castle
			spawns = data.spawns || [];
			difficulty = data.difficulty || 1;
			canSkip = data.canSkip || false;
			spawner = new MobSpawner(spawns, this);
		}
		
		public function startSpawning():void {
			spawner.start();
		}
	}
}