/* TODO:
New sample ideas
Camera: razzle dazzle (nba jam), camera snap sound, kids yelling cheese

*/
package 
{
	import flash.media.Sound;
	import flash.events.Event;
	import flash.media.SoundChannel;

	public class SoundManager
	{
		private var soundChannel:SoundChannel = new SoundChannel();
		private var musicChannel:SoundChannel = new SoundChannel();

		private var music:Sound;
		//SOUNDS
		//BUNS
		[Embed('/Sounds/BunsOfBronze.mp3')]
		private var BunsOfBronzeMP3:Class;
		[Embed('/Sounds/DontWantNone.mp3')]
		private var DontWantNoneMP3:Class;
		[Embed('/Sounds/LookAtHisLittleBuns.mp3')]
		private var LookAtHisLittleBunsMP3:Class;
		[Embed('/Sounds/MyBunsHaveNoSeeds.mp3')]
		private var MyBunsHaveNoSeedsMP3:Class;
		[Embed('/Sounds/SetThemBunsDownHere.mp3')]
		private var SetThemBunsDownHereMP3:Class;
		//CLAW
		[Embed('/Sounds/DodgeTheClaw.mp3')]
		private var DodgeTheClawMP3:Class;
		[Embed('/Sounds/NooneCanStopTheClaw.mp3')]
		private var NooneCanStopTheClawMP3:Class;
		[Embed('/Sounds/OohTheClawsComing.mp3')]
		private var OohTheClawsComingMP3:Class;
		[Embed('/Sounds/TheClawItMoves.mp3')]
		private var TheClawItMovesMP3:Class;
		[Embed('/Sounds/TheClawToyStory.mp3')]
		private var TheClawToyStoryMP3:Class;
		[Embed('/Sounds/WatchYourSelfItsClaw.mp3')]
		private var WatchYourSelfItsClawMP3:Class;
		//HAT
		[Embed('/Sounds/ThisTotallyMyHat.mp3')]
		private var ThisTotallyMyHatMP3:Class;
		//CAMERA
		//BEAKER
		//HURT
		//CHEESE


		private var bunSounds:Array = new Array(BunsOfBronzeMP3,DontWantNoneMP3,LookAtHisLittleBunsMP3,MyBunsHaveNoSeedsMP3,SetThemBunsDownHereMP3,ThisTotallyMyHatMP3);
		private var clawSounds:Array = new Array(DodgeTheClawMP3,NooneCanStopTheClawMP3,OohTheClawsComingMP3,TheClawItMovesMP3,TheClawToyStoryMP3,WatchYourSelfItsClawMP3);
		private var hatSounds:Array = new Array();
		private var cameraSounds:Array = new Array();
		private var beakerSounds:Array = new Array();
		private var hurtSounds:Array = new Array();
		private var cheeseSounds:Array = new Array();

		private var sound:Sound;
		private var isPlaying:Boolean = false;
		private var isMuted:Boolean = true;
		public function SoundManager()
		{
				music = new SongIntroWav();
				musicChannel = music.play();
				musicChannel.addEventListener(Event.SOUND_COMPLETE, introComplete);
		}
		public function playSound(type:uint)
		{
			if (! isMuted)
			{

				if (! isPlaying)
				{
					var sounds:Array;
					switch (type)
					{
						case Sounds.Beaker :
							sounds = beakerSounds;
							break;
						case Sounds.Buns :
							sounds = bunSounds;
							break;
						case Sounds.CameraSound :
							sounds = cameraSounds;
							break;
						case Sounds.Claws :
							sounds = clawSounds;
							break;
						case Sounds.Hurt :
							sounds = hurtSounds;
							break;
					}
					sound = new sounds[Tool.randomRange(0,sounds.length)]();
					soundChannel = sound.play();
					soundChannel.addEventListener(Event.SOUND_COMPLETE,handleSoundComplete);
					isPlaying = true;
				}
			}
		}

		private function handleSoundComplete(e:Event)
		{
			isPlaying = false;
			soundChannel.removeEventListener(Event.SOUND_COMPLETE,handleSoundComplete);
		}
		private function introComplete(e:Event)
		{
			music = new SongMainLoopWav();
			musicChannel = music.play(0,999);
			musicChannel.removeEventListener(Event.SOUND_COMPLETE,introComplete);
		}
	}

}