package
{
	import Box2D.Dynamics.b2Body;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class MazeComp extends BaseWorld
	{
		public function MazeComp()
		{
			
		}
		
		var waterBitmapData:BitmapData = new BitmapData(640, 480, true, 0);
		var waterBitmap:Bitmap = new Bitmap(this.waterBitmapData);
		var waterMatrix:Matrix = new Matrix();
		private function addingWater()
		{
			var _loc_7:b2Body = null;
			//var _loc_1:* = new Point(this.fireEngine1.rotatingEng.x, this.fireEngine1.rotatingEng.y);
			//_loc_1 = this.fireEngine1.localToGlobal(_loc_1);
			this.waterBitmapData.fillRect(this.waterBitmapData.rect, 0);
			var _loc_2:* = Math.atan2(mouseY - _loc_1.y, mouseX - _loc_1.x);
			
			world.Step(1 / 30, 6, 2);
			world.ClearForces();
			var _loc_5:* = world.GetBodyList();
			while (_loc_5)
			{
				
				if (_loc_5.GetUserData() != null)
				{
					if (_loc_5.GetUserData().name != "redPaintAdding")
					{
					}
					if (_loc_5.GetUserData().name != "greenPaintAdding")
					{
					}
					if (_loc_5.GetUserData().name != "bluePaintAdding")
					{
					}
					if (_loc_5.GetUserData().name != "waterAdding")
					{
					}
				}
				if (_loc_5.GetUserData().name == "yellowPaintAdding")
				{
					if (_loc_5.GetPosition().y * ptm_ratio <= 480)
					{
					}
					if (_loc_5.GetPosition().x * ptm_ratio <= 660)
					{
					}
					if (_loc_5.GetPosition().x * ptm_ratio < -50)
					{
						deleteBodyAndData(_loc_5);
						waterArraySound.splice(waterArraySound.indexOf(_loc_5), 1);
					}
					else
					{
						this.waterMatrix.tx = _loc_5.GetPosition().x * ptm_ratio;
						this.waterMatrix.ty = _loc_5.GetPosition().y * ptm_ratio;
						this.waterBitmapData.draw(_loc_5.GetUserData(), this.waterMatrix, null, null, null, true);
						this.waterBitmap.smoothing = true;
					}
					if (_loc_5.GetUserData().has_to_be_removed())
					{
						deleteBodyAndData(_loc_5);
						waterArraySound.splice(waterArraySound.indexOf(_loc_5), 1);
					}
				}
				_loc_5 = _loc_5.GetNext();
			}
			
			if (this.waterStock > 1)
			{
				addCircle(this.fireEngine1.x + this.fireEngine1.width / 5 * Math.cos(this.fireEngine1_angle) + 1 - Math.random() * 2, this.fireEngine1.y + this.fireEngine1.height / 2 * Math.sin(this.fireEngine1_angle), 4);
				var _loc_8:String = this;
				var _loc_9:* = this.waterStock - 1;
				_loc_8.waterStock = _loc_9;
				if (this.waterStock <= 1)
				{
					this.waterStock = 1;
				}
				
			}
			this.waterBitmapData.applyFilter(this.waterBitmapData, this.waterBitmapData.rect, new Point(0, 0), this.waterBlur);
				this.waterBitmapData.threshold(this.waterBitmapData, this.waterBitmapData.rect, new Point(0, 0), ">", 39168, 4284131840, 16777215, true);
			
			var _loc_6:Number = 0;
			
			for each (_loc_7 in waterArray)
			{
				
				_loc_7.ApplyImpulse(new b2Vec2(Math.cos(this.fireEngine1_angle) * _loc_6 / 90, Math.sin(this.fireEngine1_angle) * _loc_6 / 90), _loc_7.GetWorldCenter());
				waterArray.splice(waterArray.indexOf(_loc_7), 1);
			}
			return;
		}// end function
	}
}