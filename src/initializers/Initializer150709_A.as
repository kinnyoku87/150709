package initializers
{
	import flash.display.Stage;
	
	import UU.CameraButton_StateUU;
	import UU.Loading150709_StateUU;
	
	import org.agony2d.Agony;
	import org.agony2d.core.Adapter;
	import org.agony2d.core.IInitializer;
	import org.agony2d.flashApi.UUFacade;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.resource.converters.AtlasAssetConvert;
	import org.agony2d.resource.converters.SwfClassAssetConverter;

	public class Initializer150709_A implements IInitializer
	{
		
		private var _adapter:Adapter;
		
		public function onInit( stage:Stage ) : void {
			//stage.quality = StageQuality.LOW;
			//stage.quality = StageQuality.MEDIUM
			//stage.quality = StageQuality.HIGH;
			
			this._adapter = Agony.createAdapter(stage);
			this._adapter.getTouch().velocityEnabled = true;
			//this._adapter.getTouch().autoUnbindingWhenLeaving = true;
			
			ResMachine.activate(SwfClassAssetConverter);
			ResMachine.activate(AtlasAssetConvert);
			
			UUFacade.registerView("res",   Loading150709_StateUU);
//			UUFacade.registerView("grids", Grids_StateUU);
			UUFacade.registerView("camera",  CameraButton_StateUU);
			//UUFacade.registerView("res", EmbeddedRes_StateUU);
			
			UUFacade.createRoot(this._adapter).getView("res").activate([["camera"]]);
		}
	}
}