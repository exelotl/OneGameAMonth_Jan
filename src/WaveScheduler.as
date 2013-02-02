package  {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Signal;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import states.PlayWorld;
	
	public class WaveScheduler extends Entity {
		
		public var currentWave:Wave;
		
		public var
			onWaveComplete:Signal = new Signal(),
			onWaveBegin:Signal = new Signal();
		
		/// 0 = start of wave, 1 = end of wave.
		public var timeRatio:Number = 0;
		
		private var
			waveName:Text = new Text("", 10, 20),
			nameShade:Text = new Text("", 11, 21),
			waveNote:Text = new Text("", 10, 40),
			noteShade:Text = new Text("", 11, 41),
			alphaTween:NumTween,
			timeTween:NumTween,
			onEndWave:Tween,
			waveIndex:int = 0,
			pauseInWave:Boolean;
		
		public function WaveScheduler() {
			waveName.scrollX = 0; waveName.scrollY = 0;
			waveNote.scrollX = 0; waveNote.scrollY = 0;
			nameShade.scrollX = 0; nameShade.scrollY = 0;
			noteShade.scrollX = 0; noteShade.scrollY = 0;
			waveName.alpha = 0; nameShade.alpha = waveName.alpha;
			waveNote.alpha = 0; noteShade.alpha = waveNote.alpha;
			nameShade.color = 0x000000;
			noteShade.color = 0x000000;
			alphaTween = new NumTween();
			timeTween = new NumTween();
			addTween(alphaTween);
			addTween(timeTween);
		}
		
		override public function added():void {
			addGraphic(nameShade); addGraphic(waveName);
			addGraphic(noteShade); addGraphic(waveNote);
			startNextWave();
		}
		
		override public function update():void {
			if (alphaTween) {
				waveName.alpha = alphaTween.value;
				waveNote.alpha = alphaTween.value;
				nameShade.alpha = waveName.alpha;
				noteShade.alpha = waveNote.alpha;
			}
			if (timeTween && currentWave != null) {
				timeRatio = timeTween.percent;
			}
		}
		
		public function startNextWave():void {
			if (onEndWave) {
				if (onEndWave.active) removeTween(onEndWave);
			}
			if (waveIndex < Wave.gameSequence.length) {
				setWave(new Wave(Wave.gameSequence[waveIndex]));
				waveIndex++;
			} else {
				if (pauseInWave) {
					pauseInWave = false;
					setWave(new PauseWave());
				} else {
					pauseInWave = true;
					setWave(new RandomWave(waveIndex - 3));
					waveIndex++;
				}
			}
			onEndWave = new Tween(currentWave.time, Tween.ONESHOT, startNextWave);
			if (!onEndWave.active) addTween(onEndWave, true);
		}
		
		public function setWave(wave:Wave):void {
			if (currentWave) onWaveComplete.dispatch(currentWave);
			currentWave = wave;
			onWaveBegin.dispatch(currentWave);
			if (wave.timeOfDay) {
				(world as PlayWorld).background.setDaytime();
			} else {
				(world as PlayWorld).background.setNighttime();
			}
			
			waveName.text = currentWave.title;
			waveNote.text = currentWave.note;
			nameShade.text = waveName.text;
			noteShade.text = waveNote.text;
			alphaTween.tween(0, 1, 4.0, Ease.expoOut);
			alphaTween.complete = fadeBackOut;
			timeTween.tween(0, 1, currentWave.time);
			world.add(currentWave.spawner);
			currentWave.startSpawning();
		}
		
		private function fadeBackOut():void {
			alphaTween.tween(1, 0, 4.0, Ease.expoIn);
			alphaTween.complete = null;
		}
	}
}