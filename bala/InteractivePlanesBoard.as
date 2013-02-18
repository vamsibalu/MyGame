

/**
 * v0.1 code by dehash.com 2008
 * Released as open source under the BSD License
 * http://www.opensource.org/licenses/bsd-license.php
 */
package bala{
	//{{{ IMPORTS
	import caurina.transitions.TweenListObj;
	import caurina.transitions.Tweener;
	
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;

	[SWF(width="800", height="600", backgroundColor="0xFFFFFF")]
	//}}}
	public class InteractivePlanesBoard extends BasicView {
		//{{{ VARS
		private var holder:DisplayObject3D;
		private var quality:uint = 2;
		[Embed(source='a.png')]
		private var pic:Class;
		private var planes:Array;
		//}}}
		public function InteractivePlanesBoard(viewportWidth:Number = 800, viewportHeight:Number = 600,
											   scaleToStage:Boolean=true, interactive:Boolean=true, cameraType:String="CAMERA3D"){
			super(viewportWidth, viewportHeight, scaleToStage, interactive, cameraType);
			//
			planes = [];
			materialsList = new MaterialsList();
			viewport.buttonMode = true;
			viewport.useHandCursor = true;
			//
			holder = new DisplayObject3D();
			//var bg:Plane = new Plane(new ColorMaterial(0xCCCCCC), 600, 600, quality, quality);
			//holder.addChild(bg);
			var gap:Number = 120;
			for (var i:int = 0; i <4;i++){
				for (var j:int = 0; j <4; j++) {
					var t:DisplayObject3D = makeTwoSidedDisplayObject();
					t.x = (i * gap) - (1.5*gap);   
					t.y = (j * gap) - (1.5*gap);   
					holder.addChild(t);
				}
			}
			scene.addChild(holder);
			camera.target = holder;
			holder.scale = 0;
			Tweener.addTween(holder, { time:3, transition:'easeinoutback', scale: 3 } );
			
			// switch a line of planes to use BitmapMaterial
			var bitmapMaterial:BitmapMaterial = new BitmapMaterial(new pic().bitmapData);
			bitmapMaterial.interactive = true;
			bitmapMaterial.smooth = true;
			bitmapMaterial.tiled = true;
			planes[0].material = bitmapMaterial;
			planes[5].material = bitmapMaterial;
			planes[10].material = bitmapMaterial;
			planes[15].material = bitmapMaterial;
			
			//bala movie texture..
			var textureMC:TextureSymbol 	= new TextureSymbol();
			textureMC.id					= i;
			textureMC.clickButton.addEventListener(MouseEvent.CLICK, onMovieMatClicked);
			
			//movie mat..
			
			//Create the MovieMat
			var movieMat:MovieMaterial 		= new MovieMaterial(textureMC, true, true);
			movieMat.doubleSided			= true;
			movieMat.interactive 			= true;
			movieMat.smooth 				= true;
			
			var pln:Plane = new Plane(movieMat,400,400,2,2);
			scene.addChild(pln);
			
			materialsList.addMaterial(movieMat, "myID");
			this.startRendering();
		}
		protected var materialsList:MaterialsList;
		protected function onMovieMatClicked(evt:MouseEvent):void 
		{
			var randomX:Number = Math.random() * 600 - 300;
			var randomY:Number = Math.random() * 200 - 100;
			//TweenLite.to(cube, 1, { x:randomX, y:randomY, ease:Quint.easeInOut});
		}
		//
		private function makeTwoSidedDisplayObject():DisplayObject3D {
			var do3d:DisplayObject3D = new DisplayObject3D();
			do3d.useOwnContainer = true;
			do3d.filters = [new DropShadowFilter()];
			var p:Plane = makePlane();
			var p2:Plane = makePlane();
			p.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS, planeClickedHandler, false, 0, true);
			p2.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS, planeClickedHandler, false, 0, true);
			do3d.addChild(p);
			do3d.addChild(p2);
			p2.rotationY = 180;
			p.z = 1;
			planes.push(p);
			return do3d;
		}
		//
		private function makePlane():Plane {
			var colorMaterial:ColorMaterial = new ColorMaterial(Math.random() * 0xffffff);
			colorMaterial.interactive = true;
			var p:Plane = new Plane(colorMaterial, 100, 100, quality, quality);
			return p;
		}
		//
		private function planeClickedHandler(e:InteractiveScene3DEvent):void {
			if (!Tweener.isTweening(e.target.parent)){
				var rot:Number = e.target.parent.rotationY + 180;
				Tweener.addTween(e.target.parent, { time:2, transition:'easeinoutback', rotationY: rot } );
			}
		}
		//
		protected override function onRenderTick(event:Event = null):void {
			var rotY: Number = (mouseY-(stage.stageHeight/2))/(stage.height/2)*(1200);
			var rotX: Number = (mouseX-(stage.stageWidth/2))/(stage.width/2)*(-1200);
			camera.x = camera.x + (rotX - camera.x) / 5;
			camera.y = camera.y + (rotY - camera.y) / 5;
			renderer.renderScene(scene, camera, viewport)
		}
	}
}