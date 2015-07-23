package {
	import flash.display.Sprite;
	import flash.ui.Multitouch;
	
	import initializers.Initializer150709_A;
	
	import org.agony2d.Agony;
	import org.agony2d.core.DesktopPlatform;
	import org.agony2d.core.MobilePlatform;
	import org.agony2d.logging.FlashTextLogger;
	import org.agony2d.utils.Stats;
	
	[SWF(width="1100", height="650", frameRate="45")]
	public class Main150709 extends Sprite {
		
		public function Main150709() {
			var logger:FlashTextLogger;
			
			if(Multitouch.maxTouchPoints == 0){
				
				
				logger = new FlashTextLogger(stage, false, stage.stageHeight - 10, 330, 220, true);
				
				Agony.getLog().logger = logger;
				stage.addChild(new Stats(stage.stageWidth - 80, 50));
				
				logger.visible = true;
				
				Agony.startup(1024, 768, new DesktopPlatform, stage, Initializer150709_A);
				//			Security.allowDomain("*");
			}
			else{
				Agony.startup(1024, 768, new MobilePlatform(false), stage, Initializer150709_A);
			}
		}
	}
}