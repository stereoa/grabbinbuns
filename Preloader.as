package 
{

	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.text.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.DisplayObject;
	public class Preloader extends MovieClip
	{

		private var messageTextField:TextField = new TextField();
		private var loader:Loader = new Loader();
		public function Preloader()
		{

			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.load(new URLRequest("GrabbinBuns.swf"));
			//prep font
			var brainFlowerFont = new BrainFlower();
			var brainFlowerFormat = new TextFormat();
			brainFlowerFormat.font = brainFlowerFont.fontName;
			brainFlowerFormat.bold = true;
			brainFlowerFormat.color = 0xFFFFFF;
			brainFlowerFormat.size = 48;

			//create message field
			brainFlowerFormat.size = 72;
			messageTextField.defaultTextFormat = brainFlowerFormat;
			messageTextField.selectable = false;
			messageTextField.x = stage.stageWidth / 2;
			messageTextField.y = stage.stageHeight / 2;
			messageTextField.multiline = true;
			stage.addChild(messageTextField);
		}
		function onProgress(e:ProgressEvent):void
		{
			var percent:Number = Math.round(e.bytesLoaded / e.bytesTotal * 100);

			messageTextField.text = "Loading: " + percent + "%";
			messageTextField.width = messageTextField.textWidth;
			if (percent == 100)
			{
				onLoaded();
			}
		}
		function onLoaded():void
		{
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			var application:DisplayObject = loader.content;
			addChild(application);
		}

	}

}