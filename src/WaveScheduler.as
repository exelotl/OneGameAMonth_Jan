package  {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Signal;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import states.PlayWorld;
	
	public class WaveScheduler extends Entity {
		
		private var
			currentWave:Wave,
			waveName:Text = new Text("", 10, 20),
			nameShade:Text = new Text("", 12, 22),
			waveNote:Text = new Text("", 10, 40),
			noteShade:Text = new Text("", 12, 42),
			time:Text = new Text("Time left: ", 450, 0),
			timeShade:Text = new Text("Time left: ", 452, 2),
			alphaTween:NumTween,
			timeTween:NumTween,
			onEndWave:Tween,
			waveIndex:int = -1;
		
		public function WaveScheduler() {
			waveName.scrollX = 0; waveName.scrollY = 0;
			waveNote.scrollX = 0; waveNote.scrollY = 0;
			nameShade.scrollX = 0; nameShade.scrollY = 0;
			noteShade.scrollX = 0; noteShade.scrollY = 0;
			time.scrollX = 0; time.scrollY = 0;
			timeShade.scrollX = 0; timeShade.scrollY = 0;
			waveName.alpha = 0; nameShade.alpha = waveName.alpha;
			waveNote.alpha = 0; noteShade.alpha = waveNote.alpha;
			nameShade.color = 0x000000;
			noteShade.color = 0x000000;
			timeShade.color = 0x000000;
			alphaTween = new NumTween();
			timeTween = new NumTween();
			addTween(alphaTween);
			addTween(timeTween);
		}
		
		
		private function startNewWave():void {
			if (onEndWave) {
				if (onEndWave.active) removeTween(onEndWave);
			}
			waveIndex++;
			if (waveIndex < Wave.gameSequence.length) {
				setWave(new Wave(Wave.gameSequence[waveIndex]));
			} else {
				setWave(new RandomWave(waveIndex-3));
			}
			onEndWave = new Tween(currentWave.time, Tween.ONESHOT, startNewWave);
			if (!onEndWave.active) addTween(onEndWave, true);
		}
		
		override public function added():void {
			addGraphic(nameShade); addGraphic(waveName);
			addGraphic(noteShade); addGraphic(waveNote);
			addGraphic(timeShade); addGraphic(time);
			startNewWave();
		}
		
		override public function update():void {
			if (alphaTween) {
				waveName.alpha = alphaTween.value;
				waveNote.alpha = alphaTween.value;
				nameShade.alpha = waveName.alpha;
				noteShade.alpha = waveNote.alpha;
			}
			if (timeTween) {
				if (currentWave != null) {
					time.text = "Time left: " + Math.round((currentWave.time - currentWave.time * timeTween.value) * 10) / 10;
					timeShade.text = time.text;
				}
			}
		}
		
		public function setWave(wave:Wave):void {
			currentWave = null;
			currentWave = wave;
			waveName.text = currentWave.title;
			waveNote.text = currentWave.note;
			nameShade.text = waveName.text;
			noteShade.text = waveNote.text;
			alphaTween.tween(0, 1, 2.0, Ease.expoOut);
			alphaTween.complete = fadeBackOut;
			timeTween.tween(0, 1, currentWave.time);
			world.add(currentWave.spawner);
			currentWave.startSpawning();
		}
		
		private function fadeBackOut():void {
			alphaTween.tween(1, 0, 2.0, Ease.expoIn);
			alphaTween.complete = null;
		}
	}
}