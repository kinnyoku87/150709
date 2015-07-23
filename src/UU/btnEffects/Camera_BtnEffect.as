package UU.btnEffects 
{
	import com.greensock.TweenLite;
	
	import org.agony2d.flashApi.ButtonEffectUU;
	
	public class Camera_BtnEffect extends ButtonEffectUU 
	{
		
		
		override public function onExit() :void
		{
			TweenLite.killTweensOf(this.getFusion());
		}
		
		override public function onUp() :void
		{
			TweenLite.to(this.getFusion(), 0.2, { scaleX:1.0, scaleY:1.0 } );
		}
		
		override public function onHover() :void
		{
			TweenLite.to(this.getFusion(), 0.2, { scaleX:0.95, scaleY:0.95 } );
		}
		
		override public function onDown() :void
		{
			TweenLite.to(this.getFusion(), 0.2, { scaleX:0.9, scaleY:0.9 } );
		}
	}
	
}