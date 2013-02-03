package {
	import net.flashpunk.Tween;
	
	public class Wave {
		
		public static var gameSequence:Array = [
			{
				name: "Welcome",
				note: "You are the king of a small town.\nArrows to move, X to jump!",
				time: 1,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Build Something",
				note: "Over a patch of land, use Z to open a menu.\nPress Up/Down and Enter to select.",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Zombies",
				note: "Press C to swipe your sword, defend the castle!",
				time: 50,
				spawns: [{type:"zombie", amount:10}],
				difficulty: 1
			},
			{
				name: "Wave over",
				note: "Now would be a good time to apply some upgrades.",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Giant Rats",
				note: "We're just getting started.",
				time: 50,
				spawns: [{type:"rat", amount:20}],
				difficulty: 1
			},
			{
				name: "Rest",
				note: "",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Parachuting zombies?",
				note: "What is this madness?",
				time: 50,
				spawns: [{type:"parachuter", amount:8}, {type:"zombie", amount:8}],
				difficulty: 1
			},
			{
				name: "That's it for now."
			},
		];
		
		public static const
			DAY:uint = 1,
			NIGHT:uint = 0;
		
		public var
			timeOfDay:uint,
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
			time = data.time || 50;
			timeOfDay = data.timeOfDay || NIGHT;
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