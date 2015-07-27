package UU
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import org.agony2d.Agony;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.ATouchEvent;
	import org.agony2d.events.DragEvent;
	import org.agony2d.flashApi.DragFusionUU;
	import org.agony2d.flashApi.ImageUU;
	import org.agony2d.flashApi.Scale9ButtonUU;
	import org.agony2d.flashApi.StateUU;
	import org.agony2d.input.Touch;
	
	public class CameraButton_StateUU extends StateUU
	{
		
		override public function onEnter() : void
		{
			TweenPlugin.activate([TintPlugin]);
			
			_bgA = new ImageUU;
			this.getFusion().addNode(_bgA);
			_bgA.textureId = "bgA.png";
			_bgA.scaleX = this.getRoot().getAdapter().rootWidth / _bgA.sourceWidth;
			_bgA.scaleY = this.getRoot().getAdapter().rootHeight / _bgA.sourceHeight;
			
			_dragFusion = new DragFusionUU(true);
			this.getFusion().addNode(_dragFusion);
			
			_scale9Btn_A = new Scale9ButtonUU(true, false);
			_scale9Btn_A.skinId = "ui/btnScale9/B";
//			_scale9Btn_A.width = INIT_W;
			
			INIT_W = _scale9Btn_A.width;
			INIT_H = this.getRoot().getAdapter().rootHeight / 6.5;
//			INIT_H = _scale9Btn_A.height;
			
			_startX = -5;
			_startY = 300;
			_endX = this.getRoot().getAdapter().rootWidth + 5;
			_endY = this.getRoot().getAdapter().rootHeight - 300;
			
			_scale9Btn_A.height = INIT_H;
			_scale9Btn_A.pivotX = INIT_W / 2;
			_scale9Btn_A.pivotY = INIT_H / 2;
			_scale9Btn_A.addEventListener(ATouchEvent.PRESS, onTouch);
			_scale9Btn_A.addEventListener(ATouchEvent.UNBINDING, onUnbinding);
			_scale9Btn_A.addEventListener(ATouchEvent.CLICK, onClick);
			
//			_dragFusion.pivotX = INIT_W / 2;
//			_dragFusion.pivotY = INIT_H / 2;
			_dragFusion.addNode(_scale9Btn_A);
			
			
			
			_dragFusion.x = _startX;
			_dragFusion.y = _startY;
			
			_iconA = new ImageUU(true);
			_iconA.textureId = "iconA.png";
			_iconA.pivotX = _iconA.getWidth() * .5;
			_iconA.pivotY = _iconA.getHeight() * .5;
			_dragFusion.addNode(_iconA);
		}
		
		
		private function onTouch(e:ATouchEvent):void {
			TweenLite.killTweensOf(_dragFusion);
			
			_timerA = new Timer(_delayTime, 1);
			_timerA.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			_timerA.start();
			
			_pressedTouch = e.touch;
			_pressedTouch.addEventListener(AEvent.CHANGE, onTouchChange);
			_moveCount = 0;
		}
		
		private function onUnbinding(e:ATouchEvent):void{
			if(_timerA){
				_timerA.removeEventListener(TimerEvent.TIMER, onTimer);
				_timerA.stop();
				_timerA = null;
			}
		}
		
		private function onClick(e:ATouchEvent):void{
//			Agony.getLog().simplify(e.type);
			
			this.getRoot().getAdapter().getTouch().touchEnabled = false;
			
			TweenLite.to(this.getFusion().displayObject, 0.2, {tint:0xdddddd, ease:Linear.easeNone, onComplete:function():void{
				getFusion().displayObject.transform.colorTransform = new ColorTransform;
				
				getRoot().getAdapter().getTouch().touchEnabled = true;
			}});
		}
		
		private function onTimer(e:TimerEvent):void{
			_timerA.removeEventListener(TimerEvent.TIMER, onTimer);
			_timerA = null;
			
			if(_moveCount < 11){
				_scale9Btn_A.enabled = _scale9Btn_A.touchable = false;
				_pressedTouch.unbinding();
				
				TweenLite.to(_dragFusion, 0.3, { scaleX:1.2, scaleY:1.2, ease:Cubic.easeIn } );
				
				_dragFusion.startDrag(_pressedTouch, new Rectangle(_startX, _startY, _endX - _startX, _endY - _startY), 0, 0, true);
				_dragFusion.addEventListener(DragEvent.STOP_DRAG, onStopDrag);
			}
			else {
				
			}
		}
		
		private function onTouchChange(e:AEvent):void{
			_moveCount++;
		}
		
		private function onStopDrag(e:DragEvent):void{
			_dragFusion.removeEventListener(DragEvent.STOP_DRAG, onStopDrag);
			
			_scale9Btn_A.enabled = _scale9Btn_A.touchable = true;
			
			Agony.getLog().simplify(e.touch.velocityX);
			if(e.touch.velocityX <= -2){
				TweenLite.to(_dragFusion, 0.3, { x:_startX, scaleX:1.0, scaleY:1.0, ease:Cubic.easeIn } );
			}
			else if(e.touch.velocityX >= 2){
				TweenLite.to(_dragFusion, 0.3, { x:_endX, scaleX:1.0, scaleY:1.0, ease:Cubic.easeIn } );
			}
			else {
				if(_dragFusion.x < this.getRoot().getAdapter().rootWidth * .5){
					TweenLite.to(_dragFusion, 0.3, { x:_startX, scaleX:1.0, scaleY:1.0, ease:Cubic.easeIn } );
				}
				else{
					TweenLite.to(_dragFusion, 0.3, { x:_endX, scaleX:1.0, scaleY:1.0, ease:Cubic.easeIn } );
				}
			}
		}
		
		
		private var INIT_W:int
		private var INIT_H:int;
		
		private var _delayTime:int = 180;
		
		
		private var _startX:Number;
		private var _startY:Number;
		
		private var _endX:Number;
		private var _endY:Number;
		
		private var _timerA:Timer;
		
		private var _moveCount:int;
		
		private var _bgA:ImageUU;
		
		private	var _scale9Btn_A:Scale9ButtonUU;
		
		private var _dragFusion:DragFusionUU;
		
		private var _iconA:ImageUU;
		
		private var _pressedTouch:Touch;
	}
}