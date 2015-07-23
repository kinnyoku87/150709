package UU {
	import org.agony2d.events.AEvent;
	import org.agony2d.flashApi.StateUU;
	import org.agony2d.resource.FilesBundle;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.resource.ZipBundle;
	import org.agony2d.resource.handlers.FrameClip_BundleHandler;
	import org.agony2d.resource.handlers.TextureUU_BundleHandler;
	
	import resHandlers.ButtonUU_BundleHandler;
	import resHandlers.ProgressBarUU_BundleHandler;
	import resHandlers.Scale9ButtonUU_BundleHandler;
	import resHandlers.Scale9ToggleUU_BundleHandler;
	import resHandlers.Scale9UU_BundleHandler;
	import resHandlers.ToggleUU_BundleHandler;
	
	public class Loading150709_StateUU extends StateUU {
		
		override public function onEnter() : void {
			this.resA = new ResMachine("common/");
			
			// swf
			this.resA.addBundle(new FilesBundle("ui/swf/swfRes.swf"));
			
			// image
			this.resA.addBundle(new ZipBundle("demo.zip"), new TextureUU_BundleHandler);
			
			// frameClip（anime）
			this.resA.addBundle(new FilesBundle("data/frameClip_A.xml"), new FrameClip_BundleHandler);
			
			// btn...A
			this.resA.addBundle(new FilesBundle("bgA.png", "iconA.png"), new TextureUU_BundleHandler);
				
			// scale9
			this.resA.addBundle(new FilesBundle("ui/scale9/scale9_A.png", "ui/scale9/scale9_B.png", "ui/scale9/scale9_C.png"), new Scale9UU_BundleHandler);
			
			// btn...A
			this.resA.addBundle(new FilesBundle("ui/btn/A/up.png", "ui/btn/A/hover.png",
				"ui/btn/A/down.png", "ui/btn/A/disabled.png"), new TextureUU_BundleHandler, new ButtonUU_BundleHandler("ui/btn/A"));
			
			// toggle...A
			this.resA.addBundle(new FilesBundle("ui/toggle/A/up.png", "ui/toggle/A/hover.png", 
				"ui/toggle/A/down.png", "ui/toggle/A/disabled.png",
				"ui/toggle/A/upA.png", "ui/toggle/A/hoverA.png", 
				"ui/toggle/A/downA.png", "ui/toggle/A/disabledA.png"), new TextureUU_BundleHandler, new ToggleUU_BundleHandler("ui/toggle/A"));
			
			// radio...A
			this.resA.addBundle(new FilesBundle("ui/toggle/radio/up.png", "ui/toggle/radio/hover.png", 
				"ui/toggle/radio/down.png", "ui/toggle/radio/disabled.png",
				"ui/toggle/radio/upA.png", "ui/toggle/radio/hoverA.png", 
				"ui/toggle/radio/downA.png", "ui/toggle/radio/disabledA.png"), new TextureUU_BundleHandler, new ToggleUU_BundleHandler("ui/toggle/radio"));
			
			// scale9Btn / scale9Toggle...A
			this.resA.addBundle(new FilesBundle("ui/btnScale9/A/up.png", 
				"ui/btnScale9/A/hover.png",
				"ui/btnScale9/A/down.png"
				//											"ui/btnScale9/A/disabled.png"
			), new Scale9UU_BundleHandler, new Scale9ButtonUU_BundleHandler("ui/btnScale9/A"), new Scale9ToggleUU_BundleHandler("ui/btnScale9/A"));
			
			// scale9Btn
			this.resA.addBundle(new FilesBundle("ui/btnScale9/combo/up.png", "ui/btnScale9/combo/hover.png",
				"ui/btnScale9/combo/down.png"), new Scale9UU_BundleHandler, new Scale9ButtonUU_BundleHandler("ui/btnScale9/combo"));
			
			this.resA.addBundle(new FilesBundle("ui/btnScale9/B/up.png", 
												"ui/btnScale9/B/hover.png",
												"ui/btnScale9/B/down.png"
				//								"ui/btnScale9/B/disabled.png"
			), new Scale9UU_BundleHandler, new Scale9ButtonUU_BundleHandler("ui/btnScale9/B"), new Scale9ToggleUU_BundleHandler("ui/btnScale9/B"));
			
			// progressBar...A
			this.resA.addBundle(new FilesBundle("ui/progress/01.png", "ui/progress/02.png","ui/progress/03.png"), new Scale9UU_BundleHandler, new ProgressBarUU_BundleHandler("ui/progress", 1));
			
			
			this.resA.addEventListener(AEvent.COMPLETE, onComplete);
		}
		
		public var resA:ResMachine;
		
		private function onComplete(e:AEvent):void {
			var AY:Array;
			var i:int;
			var l:int;
			
			this.resA.removeAllListeners();
			this.getFusion().kill();
			
			AY = this.getArg(0);
			l = AY.length;
			while (i < l) {
				this.getRoot().getView(AY[i++]).activate();
			}
		}
	}
}