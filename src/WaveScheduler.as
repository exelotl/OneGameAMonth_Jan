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
			waveNote:Text = new Text("", 10, 40),
			time:Text = new Text("Time left: ", 450, 5),
			alphaTween:NumTween,
			timeTween:NumTween,
			onEndWave:Tween,
			waveIndex:int = -1;
		
		public function WaveScheduler() {
			waveName.scrollX = 0; waveName.scrollY = 0;
			waveNote.scrollX = 0; waveNote.scrollY = 0;
			time.scrollX = 0; time.scrollY = 0;
			waveName.alpha = 0;
			waveNote.alpha = 0;
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
			addGraphic(waveName);
			addGraphic(waveNote);
			addGraphic(time);
			startNewWave();
		}
		
		override public function update():void {
			if (alphaTween) {
				waveName.alpha = alphaTween.value;
				waveNote.alpha = alphaTween.value;
			}
			if (timeTween) {
				if (currentWave != null) {
					time.text = "Time left: " + Math.round((currentWave.time - currentWave.time * timeTween.value) * 10) / 10;
				}
			}
		}
		
		public function setWave(wave:Wave):void {
			currentWave = null;
			currentWave = wave;
			waveName.text = currentWave.title;
			waveNote.text = currentWave.note;
			alphaTween.tween(0, 1, 2.0, Ease.backOut);
			alphaTween.complete = fadeBackOut;
			timeTween.tween(0, 1, currentWave.time);
			world.add(currentWave.spawner);
			currentWave.startSpawning();
		}
		
		private function fadeBackOut():void {
			alphaTween.tween(1, 0, 2.0, Ease.backIn);
			alphaTween.complete = null;
		}
	}
}