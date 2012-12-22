package bala
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import bala.Box2DSeparator.b2Separator;
	import bala.Utils.BalaUtils;
	import bala.vo.PlatFormType;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.StaticText;
	
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	
	public class BaseWorld extends MovieClip
	{
		// ptm ratio
		public static var ptm_ratio:Number = 30;
		
		// create the box2d world, set up gravity
		public var world:b2World=new b2World(new b2Vec2(0,10),true);
		protected var conv:b2Separator = new b2Separator();
		//basic items 
		
		//create arrow..
		public var bodyDef:b2BodyDef;
		public var body:b2Body;
		public var boxDef:b2PolygonShape;
		public var fixtureDef:b2FixtureDef;
		public var debugging:Boolean = false;
		
		public static var bodyID:int = 1;
		
		public function BaseWorld()
		{
			//TODO: implement function
			super();
			bg();
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
			trace("BaseWorld created.")
		}
		
		private function bg():void{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xA8DCFF,0);
			sp.graphics.drawRect(-100,-100,840,680);
			addChild(sp);
			
			//var mc:MovieClip = new note();
			//addChild(mc);
			
			world.SetContactListener(new BodyContacts())
		}
		
		private function addedToStage(e:Event):void{
			setUpWalls();
			addChild(objectsCont);
			//for slicing..
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
		}
		
		protected function startRender():void{
			addEventListener(Event.ENTER_FRAME,renderGame);
		}
		
		protected function stopRender():void{
			removeEventListener(Event.ENTER_FRAME,renderGame);
		}
		
		public var wallT:b2Body;
		public var wallR:b2Body;
		public var wallL:b2Body;
		//for reloading levels and walls bala
		public function setUpWalls()
		{
			wallL = createBox("border1",-3, 500/2, 5, 500); //left
			
			wallR = createBox("border2",643, 500/2, 5,  500); //right
			
			
			wallT =	createBox("border3",640/2, -3, 700, 5);
			
			//bottom
			createBox("border4",640/2, 484, 700, 5);
		}
		
		private function resetWalls():void{
			wallT.SetPosition(new b2Vec2(320/ptm_ratio,-3/ptm_ratio));
			wallR.SetPosition(new b2Vec2(643/ptm_ratio,250/ptm_ratio));
			wallL.SetPosition(new b2Vec2(-3/ptm_ratio,250/ptm_ratio));
		}
		// this function runs the world simulation
		// and adjusts the sprites according to the positions
		// of the objects in the simulation
		public var RadtoDeg:Number = 180/Math.PI;
		public var DegtoRad:Number = Math.PI/180;
		public function renderGame(e : Event):void {
			// step the world
			world.Step(1 / 30, 10, 10);
			
			world.ClearForces();
			world.DrawDebugData();
			
			// update the sprites from the physics data
			var Body:b2Body = world.GetBodyList();
			for ( ; Body; Body = Body.GetNext()) {
				if (Body.GetUserData() is MovieClip) {
					
					// get the user date value from the body
					var mcc:MovieClip = MovieClip(Body.GetUserData());
					
					// extract the position and set the sprite to it
					mcc.x=Body.GetPosition().x*ptm_ratio;
					mcc.y=Body.GetPosition().y*ptm_ratio;
					
					// set the rotation of the sprite
					mcc.rotation = Body.GetAngle() * RadtoDeg ;
					//fallower(Body);
				}
			}
			
		}
		
		//bala create Poly...
		protected var woodTexture:BitmapData, rockTexture:BitmapData;
		protected function createPoly(bodyID:String,vec:Vector.<b2Vec2>,_name:String,polyTexture:BitmapData) : b2Body
		{
			this.bodyDef = new b2BodyDef();
			this.bodyDef.type = b2Body.b2_staticBody;
			//this.bodyDef.userData = new MovieClip();
			if(polyTexture){
				bodyDef.userData = new userData(0, vec, polyTexture); //for slicing..
			}else{
				bodyDef.userData = new MovieClip();//new userData(0, vec, new BitmapData(200,200)); //for slicing..
			}
			bodyDef.userData.bodyID = bodyID;
			objectsCont.addChild(bodyDef.userData);
			this.bodyDef.userData.name = _name;
			//this.bodyDef.position.Set(0/30, 0/30);//100
			this.body = this.world.CreateBody(this.bodyDef);
			this.fixtureDef = new b2FixtureDef();
			this.fixtureDef.density = 5;
			this.fixtureDef.friction = 0.2;
			this.fixtureDef.restitution = 0;
			this.conv.Separate(this.body, this.fixtureDef, vec);
			trace("created you poly body..")
			body.SetBullet(true);
			numEnterPoints++;
			enterPointsVec = new Vector.<b2Vec2>(numEnterPoints);
			return body;
		}
		
		private function fallower(obj:b2Body):void{
			if(obj.GetUserData().fallowme && obj.GetUserData().fallowme is b2Body){
				var fallowerb2:b2Body = b2Body(obj.GetUserData().fallowme);
				fallowerb2.SetPositionAndAngle(obj.GetPosition(),obj.GetAngularVelocity());
			}
		}
		
		final protected function createBox(bodyID:String,x:int,y:int,ww:int,hh:int,_angle:Number=0,type:String = "standard",_dynamic:Boolean = false,iron:Boolean = false):b2Body
		{
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			bodyDef.position.Set(x /ptm_ratio, y / ptm_ratio);
			bodyDef.angle = _angle / (180 / Math.PI);
			fixtureDef.friction = .1;
			fixtureDef.restitution = 0.001;
			if(_dynamic == false){
				if(iron == true){
					bodyDef.userData = new GridIron()
					bodyDef.userData.name = "iron";
					fixtureDef.restitution = 0.5;
				}else{
					bodyDef.userData = new MovieClip();
					bodyDef.userData.name = "notmoving";
				}
			}else{
				bodyDef.type = b2Body.b2_dynamicBody;
				bodyDef.userData = new Block();
				bodyDef.userData.name = "block";
				switch(type){
					case PlatFormType.STANDARD:
						bodyDef.userData.gotoAndStop("standard");
						bodyDef.userData.name = "block";
						break;
					case PlatFormType.BOUNCY:
						fixtureDef.restitution = .3;
						bodyDef.userData.gotoAndStop("bouncy");
						//bodyDef.userData.name = "bouncy";
						break;
					case PlatFormType.GLASS:
						bodyDef.userData.gotoAndStop("glass");
						bodyDef.userData.name = "rock";
						//trace("created glasssss box..")
						break;
					case PlatFormType.ICE:
						fixtureDef.friction = 0.1;
						bodyDef.userData.gotoAndStop("ice");
						//bodyDef.userData.name = "block";
						break;
				}
				
			}
			
			bodyDef.userData.bodyID = bodyID;
			
			bodyDef.userData.width = ww;
			bodyDef.userData.height = hh;
			bodyDef.userData.rotation = _angle;
			addChild(bodyDef.userData);
			
			var body:b2Body = world.CreateBody(bodyDef);
			var dynamicBox:b2PolygonShape = new b2PolygonShape();
			dynamicBox.SetAsBox(realPixels(ww),realPixels(hh));
			fixtureDef.shape = dynamicBox;
			fixtureDef.density = 0.5;
			//fixtureDef.filter.groupIndex = -2;
			body.CreateFixture(fixtureDef);
			//trace(body.GetUserData().name);
			return body;
		}
		
		public function set debugDraw(sp:Sprite)
		{
			var db:b2DebugDraw=new b2DebugDraw();
			db.SetSprite(sp);
			db.SetDrawScale(ptm_ratio);
			db.SetFillAlpha(1);
			db.SetLineThickness(2);
			db.SetFlags(b2DebugDraw.e_jointBit | b2DebugDraw.e_shapeBit) // | b2DebugDraw.e_centerOfMassBit//b2DebugDraw.e_shapeBit//t|b2DebugDraw.e_shapeBit
			world.SetDebugDraw(db);
		}
		
		public function realPixels(param1:Number) : Number
		{
			return (param1 / ptm_ratio) / 2;
		}// end function
		
		// this is the core of the script: despite the official docs which suggest to use Initialize,
		// use this method instead
		public function revoluteJointMaker(bodyA:b2Body,bodyB:b2Body,_anchor:b2Vec2,motorSpeed:Number,maxMotorTorque:Number,lowerAngle:Number,upperAngle:Number):b2Joint {
			var revoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			/*revoluteJointDef.localAnchorA.Set(anchorA.x,anchorA.y);
			revoluteJointDef.localAnchorB.Set(anchorB.x,anchorB.y);
			revoluteJointDef.bodyA=bodyA;
			revoluteJointDef.bodyB=bodyB;*/
			revoluteJointDef.Initialize(bodyA,bodyB,_anchor);
			revoluteJointDef.enableLimit = (lowerAngle>0 && upperAngle>0);
			revoluteJointDef.lowerAngle = lowerAngle;
			revoluteJointDef.upperAngle = upperAngle;
			revoluteJointDef.enableMotor = motorSpeed>0;
			revoluteJointDef.motorSpeed = motorSpeed;
			revoluteJointDef.maxMotorTorque = maxMotorTorque;
			//revoluteJointDef.collideConnected = false;
			return world.CreateJoint(revoluteJointDef);
		}
		
		
		
		
		
		
		
		
		
		
		//for slicing effect..
		var mouseReleased:Boolean = false;
		var begX:Number, begY:Number, endX:Number, endY:Number;
		var enterPointsVec:Vector.<b2Vec2> = new Vector.<b2Vec2>();
		var laserCont:Sprite = new Sprite();
		var numEnterPoints:int = 0, i:int;
		var tempBox:b2Body;
		var objectsCont:Sprite = new Sprite();
		var polyShape:b2PolygonShape;
		
		
		
		
		//require for slicing..
		
		private function mDown(e:MouseEvent)
		{
			begX = mouseX;
			begY = mouseY;
			
			//stage.addEventListener(MouseEvent.MOUSE_UP, mUp);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, mMove);
		}
		
		private function mMove(e:MouseEvent)
		{
			laserCont.graphics.clear();
			laserCont.graphics.lineStyle(2);
			laserCont.graphics.moveTo(begX, begY);
			laserCont.graphics.lineTo(mouseX, mouseY);
		}
		
		private function mUp(e:MouseEvent)
		{
			mouseReleased = true;
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, mUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mMove);
		}
		protected function doSlice():void{
			if(mouseReleased)
			{
				// Here I use the world.RayCast() method (I use it twice, see why in the comments in the intersection() method below) to get the intersection points between the line you just drew and all bodies in the Box2D world.
				
				endX = mouseX;
				endY = mouseY;
				
				var p1:b2Vec2 = new b2Vec2(begX/30, begY/30);
				var p2:b2Vec2 = new b2Vec2(endX/30, endY/30);
				trace("p1=",p1,"p2,",p2)
				world.RayCast(intersection, p1, p2);
				world.RayCast(intersection, p2, p1);
				enterPointsVec = new Vector.<b2Vec2>(numEnterPoints);
				mouseReleased = false;
			}
		}
		
		private function intersection(fixture:b2Fixture, point:b2Vec2, normal:b2Vec2, fraction:Number):Number
		{
			var spr:Sprite = fixture.GetBody().GetUserData();
			
			// Throughout this whole code I use only one global vector, and that is enterPointsVec. Why do I need it you ask? 
			// Well, the problem is that the world.RayCast() method calls this function only when it sees that a given line gets into the body - it doesnt see when the line gets out of it.
			// I must have 2 intersection points with a body so that it can be sliced, thats why I use world.RayCast() again, but this time from B to A - that way the point, at which BA enters the body is the point at which AB leaves it!
			// For that reason, I use a vector enterPointsVec, where I store the points, at which AB enters the body. And later on, if I see that BA enters a body, which has been entered already by AB, I fire the splitObj() function!
			// I need a unique ID for each body, in order to know where its corresponding enter point is - I store that id in the userData of each body.
			
			if(spr is userData)
			{
				var userD:userData = spr as userData;
				trace("enterPointsVec[userD.id]=",enterPointsVec)
				if(enterPointsVec[userD.id])
				{
					trace("intersection>enterPointsVec=",enterPointsVec[userD.id])
					// If this body has already had an intersection point, then it now has two intersection points, thus it must be split in two - thats where the splitObj() method comes in.
					// Before calling splitObj() however, I first draw the two intersection points - the blue one is the enter point and the red one is the end point.
					laserCont.graphics.lineStyle(4, 0x0000FF);
					laserCont.graphics.drawCircle(enterPointsVec[userD.id].x*30, enterPointsVec[userD.id].y*30, 7);
					
					laserCont.graphics.lineStyle(4, 0xFF0000);
					laserCont.graphics.drawCircle(point.x*30, point.y*30, 7);
					
					splitObj(fixture.GetBody(), enterPointsVec[userD.id], point.Copy());
				}
				else enterPointsVec[userD.id] = point;
			}
			
			return 1;
		}
		
		private function splitObj(sliceBody:b2Body, A:b2Vec2, B:b2Vec2):void
		{
			var origFixture:b2Fixture = sliceBody.GetFixtureList();
			var poly:b2PolygonShape = origFixture.GetShape() as b2PolygonShape;
			var verticesVec:Vector.<b2Vec2> = poly.GetVertices(), numVertices:int = poly.GetVertexCount();
			var shape1Vertices:Vector.<b2Vec2> = new Vector.<b2Vec2>(), shape2Vertices:Vector.<b2Vec2> = new Vector.<b2Vec2>();
			var origUserData:userData = sliceBody.GetUserData(), origUserDataId:int = origUserData.id, d:Number;
			
			// First, I destroy the original body and remove its Sprite representation from the childlist.
			world.DestroyBody(sliceBody);
			if(origUserData.parent)
				origUserData.parent.removeChild(origUserData); //bala118
			//trace("splitObj0=",A,B)
			// The world.RayCast() method returns points in world coordinates, so I use the b2Body.GetLocalPoint() to convert them to local coordinates.
			A = sliceBody.GetLocalPoint(A);
			B = sliceBody.GetLocalPoint(B);
			//trace(A + " : " +B)
			//trace("splitObj1=",A,B)
			// I use shape1Vertices and shape2Vertices to store the vertices of the two new shapes that are about to be created. 
			// Since both point A and B are vertices of the two new shapes, I add them to both vectors.
			shape1Vertices.push(A, B);
			shape2Vertices.push(A, B);
			
			// I iterate over all vertices of the original body. 
			// I use the function det() ("det" stands for "determinant") to see on which side of AB each point is standing on. The parameters it needs are the coordinates of 3 points:
			// - if it returns a value >0, then the three points are in clockwise order (the point is under AB)
			// - if it returns a value =0, then the three points lie on the same line (the point is on AB)
			// - if it returns a value <0, then the three points are in counter-clockwise order (the point is above AB). 
			for(i=0; i<numVertices; i++) 
			{
				
				d = det(A.x, A.y, B.x, B.y, verticesVec[i].x, verticesVec[i].y);
				//trace(d)
				if(d>0) shape1Vertices.push(verticesVec[i]);
				else shape2Vertices.push(verticesVec[i]);
			}			
			
			// In order to be able to create the two new shapes, I need to have the vertices arranged in clockwise order.
			// I call my custom method, arrangeClockwise(), which takes as a parameter a vector, representing the coordinates of the shape's vertices and returns a new vector, with the same points arranged clockwise.
			shape1Vertices = arrangeClockwise(shape1Vertices);
			shape2Vertices = arrangeClockwise(shape2Vertices);
			
			var sp1Size:Number = getSize5(shape1Vertices)
			var sp2Size:Number = getSize5(shape2Vertices)
			//bala..
			//trace("shape1Vertices",shape1Vertices.length,shape2Vertices.length)
			//trace("shape1Vertices size=",sp1Size,"shape2Vertices size=",sp2Size)
			// setting the properties of the two newly created shapes
			bodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.position.SetV(sliceBody.GetPosition());
			fixtureDef = new b2FixtureDef();
			fixtureDef.density = origFixture.GetDensity();
			fixtureDef.friction = origFixture.GetFriction();
			fixtureDef.restitution = origFixture.GetRestitution();
			
			// creating the first shape
			polyShape = new b2PolygonShape();
			polyShape.SetAsVector(shape1Vertices);
			fixtureDef.shape = polyShape;
			
			bodyDef.userData = new userData(origUserDataId, shape1Vertices, origUserData.texture);
			if(sp1Size<sp2Size){
				bodyDef.type = b2Body.b2_dynamicBody
			}
			objectsCont.addChild(bodyDef.userData);
			enterPointsVec[origUserDataId] = null;
			
			body = world.CreateBody(bodyDef);
			body.SetAngle(sliceBody.GetAngle());
			body.CreateFixture(fixtureDef);
			body.SetBullet(true);
			
			// creating the second shape
			polyShape = new b2PolygonShape();
			polyShape.SetAsVector(shape2Vertices);
			fixtureDef.shape = polyShape;
			
			bodyDef.userData = new userData(numEnterPoints, shape2Vertices, origUserData.texture);
			bodyDef.type = b2Body.b2_staticBody
			if(sp2Size<sp1Size){
				bodyDef.type = b2Body.b2_dynamicBody
			}
			objectsCont.addChild(bodyDef.userData);
			enterPointsVec.push(null);
			numEnterPoints++;
			
			body = world.CreateBody(bodyDef);
			body.SetAngle(sliceBody.GetAngle());
			body.CreateFixture(fixtureDef);
			body.SetBullet(true);		
		}
		
		private function arrangeClockwise(vec:Vector.<b2Vec2>):Vector.<b2Vec2>
		{
			// The algorithm is simple: 
			// First, it arranges all given points in ascending order, according to their x-coordinate.
			// Secondly, it takes the leftmost and rightmost points (lets call them C and D), and creates tempVec, where the points arranged in clockwise order will be stored.
			// Then, it iterates over the vertices vector, and uses the det() method I talked about earlier. It starts putting the points above CD from the beginning of the vector, and the points below CD from the end of the vector. 
			// That was it!
			
			var n:int = vec.length, d:Number, i1:int = 1, i2:int = n-1;
			var tempVec:Vector.<b2Vec2> = new Vector.<b2Vec2>(n), C:b2Vec2, D:b2Vec2;
			
			vec.sort(comp1);			
			
			tempVec[0] = vec[0];
			C = vec[0];
			D = vec[n-1];
			
			for(i=1; i<n-1; i++)
			{
				d = det(C.x, C.y, D.x, D.y, vec[i].x, vec[i].y);
				if(d<0) tempVec[i1++] = vec[i];
				else tempVec[i2--] = vec[i];
			}
			
			tempVec[i1] = vec[n-1];
			
			return tempVec;
		}
		
		private function det(x1:Number, y1:Number, x2:Number, y2:Number, x3:Number, y3:Number):Number
		{
			// This is a function which finds the determinant of a 3x3 matrix.
			// If you studied matrices, you'd know that it returns a positive number if three given points are in clockwise order, negative if they are in anti-clockwise order and zero if they lie on the same line.
			// Another useful thing about determinants is that their absolute value is two times the face of the triangle, formed by the three given points.
			return x1*y2+x2*y3+x3*y1-y1*x2-y2*x3-y3*x1;    
		}
		
		private function getSize5(shapeVertices:Vector.<b2Vec2>):Number{
			var prev:Point;
			var total:Number = 0;
			for(var i:int = 0; i<shapeVertices.length; i++){
				
				var prec:Point = new Point(shapeVertices[i].x,shapeVertices[i].y);
				if(prev){
					var nm:Number = Point.distance(prev,prec);
					total += nm;
				}
				prev = prec;
			}
			
			return total;
		}
		
		private function comp1(a:b2Vec2, b:b2Vec2):Number
		{
			// This is a compare function, used in the arrangeClockwise() method - a fast way to arrange the points in ascending order, according to their x-coordinate.
			if(a.x>b.x) return 1;
			else if(a.x<b.x) return -1;
			
			return 0;
		}
		
		public static function getB2vec(xx:Number,yy:Number):b2Vec2{
			var b2v:b2Vec2 = new b2Vec2(xx/ptm_ratio,yy/ptm_ratio);
			return b2v;
		}
		
		public static function parseXY(ary:Array):Vector.<b2Vec2>{
			var vvvc:Vector.<b2Vec2> = new Vector.<b2Vec2>();
			for(var i:int =0; i<ary.length; i++){
				var k:Array = ary[i].split("+");
				if(k && k.length>1){
					vvvc.push(BaseWorld.getB2vec(k[0],k[1]));
				}
			}
			return vvvc;
		}
	}
}