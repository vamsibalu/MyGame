package bala 
{
	import Box2D.Common.Math.b2Vec2;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * @author : Balakrishna.  
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	
	public class userData extends MovieClip
	{
		public var id:int, texture:BitmapData;
		public var bodyID:String;
		public function userData(id:int, verticesVec:Vector.<b2Vec2>, texture:BitmapData)
		{
			this.id = id;
			this.texture = texture;
			alpha = .2
			// I use the matrix so that I can have the center of the shape I'm drawing match the center of the BitmapData image - I "move" the BitmapData projection left by half its width and up by half its height.
			var m:Matrix = new Matrix();
			m.tx = -texture.width*0.5;
			m.ty = -texture.height*0.5;
			
			// I then draw lines from each vertex to the next, in clockwise order and use the beginBitmapFill() method to add the texture.
			this.graphics.lineStyle(2);
			this.graphics.beginBitmapFill(texture, m, true, true);
			this.graphics.moveTo(verticesVec[0].x*30, verticesVec[0].y*30);
			for (var i:int=1; i<verticesVec.length; i++) this.graphics.lineTo(verticesVec[i].x*30, verticesVec[i].y*30);
			this.graphics.lineTo(verticesVec[0].x*30, verticesVec[0].y*30);
			this.graphics.endFill();
		}
	}
}