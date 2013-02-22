package com{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.MovieClip;
	
	import bala.BaseWorld;
	
	public class gamePathFile {
		
		private var ptm_ratio:int;
		private var my_arr:Array
		

		public function gamePathFile() {
			// constructor code
			ptm_ratio = BaseWorld.ptm_ratio
		}
		
		public function creates(world:b2World)
		{
			var arr1:Array=[

                                                [   new b2Vec2(14999.5/ptm_ratio, 679/ptm_ratio)  ,  new b2Vec2(14229/ptm_ratio, 563.5/ptm_ratio)  ,  new b2Vec2(14464/ptm_ratio, 507.5/ptm_ratio)  ,  new b2Vec2(14639/ptm_ratio, 488.5/ptm_ratio)  ,  new b2Vec2(14999/ptm_ratio, 471.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(73/ptm_ratio, 462.5/ptm_ratio)  ,  new b2Vec2(246/ptm_ratio, 497.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 678/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 450.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(6893/ptm_ratio, 373.5/ptm_ratio)  ,  new b2Vec2(6888/ptm_ratio, 380.5/ptm_ratio)  ,  new b2Vec2(6890.5/ptm_ratio, 373/ptm_ratio)  ] ,
                                                [   new b2Vec2(446/ptm_ratio, 507.5/ptm_ratio)  ,  new b2Vec2(584/ptm_ratio, 524.5/ptm_ratio)  ,  new b2Vec2(729/ptm_ratio, 549.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 678/ptm_ratio)  ,  new b2Vec2(246/ptm_ratio, 497.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(6888/ptm_ratio, 380.5/ptm_ratio)  ,  new b2Vec2(7246/ptm_ratio, 468.5/ptm_ratio)  ,  new b2Vec2(6366/ptm_ratio, 540.5/ptm_ratio)  ,  new b2Vec2(6650/ptm_ratio, 382.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(2305/ptm_ratio, 443.5/ptm_ratio)  ,  new b2Vec2(3317/ptm_ratio, 518.5/ptm_ratio)  ,  new b2Vec2(1331/ptm_ratio, 561.5/ptm_ratio)  ,  new b2Vec2(1721/ptm_ratio, 421.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(2907.5/ptm_ratio, 436/ptm_ratio)  ,  new b2Vec2(2317/ptm_ratio, 439.5/ptm_ratio)  ,  new b2Vec2(2897/ptm_ratio, 375.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(9050/ptm_ratio, 522.5/ptm_ratio)  ,  new b2Vec2(8316/ptm_ratio, 509.5/ptm_ratio)  ,  new b2Vec2(8362/ptm_ratio, 504.5/ptm_ratio)  ,  new b2Vec2(8874/ptm_ratio, 489.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(6894/ptm_ratio, 373.5/ptm_ratio)  ,  new b2Vec2(7246/ptm_ratio, 468.5/ptm_ratio)  ,  new b2Vec2(6888/ptm_ratio, 380.5/ptm_ratio)  ,  new b2Vec2(6893/ptm_ratio, 373.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(6106/ptm_ratio, 494.5/ptm_ratio)  ,  new b2Vec2(6159/ptm_ratio, 506.5/ptm_ratio)  ,  new b2Vec2(6208/ptm_ratio, 519.5/ptm_ratio)  ,  new b2Vec2(6301/ptm_ratio, 550.5/ptm_ratio)  ,  new b2Vec2(5871/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(5983/ptm_ratio, 498.5/ptm_ratio)  ,  new b2Vec2(6018/ptm_ratio, 491.5/ptm_ratio)  ,  new b2Vec2(6053/ptm_ratio, 488.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(5494/ptm_ratio, 516.5/ptm_ratio)  ,  new b2Vec2(5570/ptm_ratio, 519.5/ptm_ratio)  ,  new b2Vec2(5735/ptm_ratio, 542.5/ptm_ratio)  ,  new b2Vec2(5310/ptm_ratio, 573.5/ptm_ratio)  ,  new b2Vec2(5421/ptm_ratio, 529.5/ptm_ratio)  ,  new b2Vec2(5454/ptm_ratio, 520.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(10379/ptm_ratio, 446.5/ptm_ratio)  ,  new b2Vec2(10415/ptm_ratio, 453.5/ptm_ratio)  ,  new b2Vec2(10533/ptm_ratio, 483.5/ptm_ratio)  ,  new b2Vec2(10182/ptm_ratio, 465.5/ptm_ratio)  ,  new b2Vec2(10291/ptm_ratio, 446.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(9916/ptm_ratio, 433.5/ptm_ratio)  ,  new b2Vec2(10029/ptm_ratio, 455.5/ptm_ratio)  ,  new b2Vec2(9607/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(9763/ptm_ratio, 435.5/ptm_ratio)  ,  new b2Vec2(9802/ptm_ratio, 428.5/ptm_ratio)  ,  new b2Vec2(9849/ptm_ratio, 425.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(11484/ptm_ratio, 535.5/ptm_ratio)  ,  new b2Vec2(9174/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(11292/ptm_ratio, 478.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(4967/ptm_ratio, 580.5/ptm_ratio)  ,  new b2Vec2(5069/ptm_ratio, 607.5/ptm_ratio)  ,  new b2Vec2(3343/ptm_ratio, 519.5/ptm_ratio)  ,  new b2Vec2(4695/ptm_ratio, 547.5/ptm_ratio)  ,  new b2Vec2(4838/ptm_ratio, 555.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(907/ptm_ratio, 576.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 678/ptm_ratio)  ,  new b2Vec2(729/ptm_ratio, 549.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(4039/ptm_ratio, 397.5/ptm_ratio)  ,  new b2Vec2(4093/ptm_ratio, 404.5/ptm_ratio)  ,  new b2Vec2(4134/ptm_ratio, 413.5/ptm_ratio)  ,  new b2Vec2(4265/ptm_ratio, 456.5/ptm_ratio)  ,  new b2Vec2(3863/ptm_ratio, 433.5/ptm_ratio)  ,  new b2Vec2(3975/ptm_ratio, 403.5/ptm_ratio)  ,  new b2Vec2(4015/ptm_ratio, 397.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(14464/ptm_ratio, 507.5/ptm_ratio)  ,  new b2Vec2(14287/ptm_ratio, 549.5/ptm_ratio)  ,  new b2Vec2(14404/ptm_ratio, 515.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(8515/ptm_ratio, 477.5/ptm_ratio)  ,  new b2Vec2(8588/ptm_ratio, 480.5/ptm_ratio)  ,  new b2Vec2(8706/ptm_ratio, 492.5/ptm_ratio)  ,  new b2Vec2(8362/ptm_ratio, 504.5/ptm_ratio)  ,  new b2Vec2(8468/ptm_ratio, 480.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(7819/ptm_ratio, 506.5/ptm_ratio)  ,  new b2Vec2(7944/ptm_ratio, 498.5/ptm_ratio)  ,  new b2Vec2(8138/ptm_ratio, 500.5/ptm_ratio)  ,  new b2Vec2(8203/ptm_ratio, 503.5/ptm_ratio)  ,  new b2Vec2(8252/ptm_ratio, 509.5/ptm_ratio)  ,  new b2Vec2(7729/ptm_ratio, 525.5/ptm_ratio)  ,  new b2Vec2(7775/ptm_ratio, 513.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(4538/ptm_ratio, 502.5/ptm_ratio)  ,  new b2Vec2(4636/ptm_ratio, 534.5/ptm_ratio)  ,  new b2Vec2(3422/ptm_ratio, 515.5/ptm_ratio)  ,  new b2Vec2(3541/ptm_ratio, 486.5/ptm_ratio)  ,  new b2Vec2(3816/ptm_ratio, 439.5/ptm_ratio)  ,  new b2Vec2(3863/ptm_ratio, 433.5/ptm_ratio)  ,  new b2Vec2(4265/ptm_ratio, 456.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(3816/ptm_ratio, 439.5/ptm_ratio)  ,  new b2Vec2(3541/ptm_ratio, 486.5/ptm_ratio)  ,  new b2Vec2(3665/ptm_ratio, 459.5/ptm_ratio)  ,  new b2Vec2(3756/ptm_ratio, 443.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(13565/ptm_ratio, 593.5/ptm_ratio)  ,  new b2Vec2(13781/ptm_ratio, 611.5/ptm_ratio)  ,  new b2Vec2(13226/ptm_ratio, 619.5/ptm_ratio)  ,  new b2Vec2(13340/ptm_ratio, 597.5/ptm_ratio)  ,  new b2Vec2(13398/ptm_ratio, 589.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(7700/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(6360/ptm_ratio, 549.5/ptm_ratio)  ,  new b2Vec2(6366/ptm_ratio, 540.5/ptm_ratio)  ,  new b2Vec2(7586/ptm_ratio, 517.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(14122/ptm_ratio, 566.5/ptm_ratio)  ,  new b2Vec2(14229/ptm_ratio, 563.5/ptm_ratio)  ,  new b2Vec2(14999.5/ptm_ratio, 679/ptm_ratio)  ,  new b2Vec2(13861/ptm_ratio, 610.5/ptm_ratio)  ,  new b2Vec2(14027/ptm_ratio, 575.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(5735/ptm_ratio, 542.5/ptm_ratio)  ,  new b2Vec2(5793/ptm_ratio, 543.5/ptm_ratio)  ,  new b2Vec2(5240/ptm_ratio, 598.5/ptm_ratio)  ,  new b2Vec2(5310/ptm_ratio, 573.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(3102/ptm_ratio, 462.5/ptm_ratio)  ,  new b2Vec2(3202/ptm_ratio, 492.5/ptm_ratio)  ,  new b2Vec2(2910/ptm_ratio, 440.5/ptm_ratio)  ,  new b2Vec2(2990/ptm_ratio, 445.5/ptm_ratio)  ,  new b2Vec2(3061/ptm_ratio, 453.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(11987/ptm_ratio, 516.5/ptm_ratio)  ,  new b2Vec2(12013/ptm_ratio, 519.5/ptm_ratio)  ,  new b2Vec2(12252/ptm_ratio, 575.5/ptm_ratio)  ,  new b2Vec2(11784/ptm_ratio, 531.5/ptm_ratio)  ,  new b2Vec2(11892/ptm_ratio, 519.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12455/ptm_ratio, 592.5/ptm_ratio)  ,  new b2Vec2(12507/ptm_ratio, 600.5/ptm_ratio)  ,  new b2Vec2(12670/ptm_ratio, 635.5/ptm_ratio)  ,  new b2Vec2(12252/ptm_ratio, 575.5/ptm_ratio)  ,  new b2Vec2(12318/ptm_ratio, 576.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(10182/ptm_ratio, 465.5/ptm_ratio)  ,  new b2Vec2(10581/ptm_ratio, 492.5/ptm_ratio)  ,  new b2Vec2(9174/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(9324/ptm_ratio, 507.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(10129/ptm_ratio, 466.5/ptm_ratio)  ,  new b2Vec2(9540/ptm_ratio, 494.5/ptm_ratio)  ,  new b2Vec2(9607/ptm_ratio, 479.5/ptm_ratio)  ,  new b2Vec2(10029/ptm_ratio, 455.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1331/ptm_ratio, 561.5/ptm_ratio)  ,  new b2Vec2(1157/ptm_ratio, 575.5/ptm_ratio)  ,  new b2Vec2(1273/ptm_ratio, 562.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12951/ptm_ratio, 624.5/ptm_ratio)  ,  new b2Vec2(13137/ptm_ratio, 623.5/ptm_ratio)  ,  new b2Vec2(12837/ptm_ratio, 639.5/ptm_ratio)  ,  new b2Vec2(12905/ptm_ratio, 628.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(7454/ptm_ratio, 516.5/ptm_ratio)  ,  new b2Vec2(6366/ptm_ratio, 540.5/ptm_ratio)  ,  new b2Vec2(7246/ptm_ratio, 468.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(1033/ptm_ratio, 585.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 678/ptm_ratio)  ,  new b2Vec2(907/ptm_ratio, 576.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12252/ptm_ratio, 575.5/ptm_ratio)  ,  new b2Vec2(12670/ptm_ratio, 635.5/ptm_ratio)  ,  new b2Vec2(11615/ptm_ratio, 545.5/ptm_ratio)  ,  new b2Vec2(11784/ptm_ratio, 531.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(6301/ptm_ratio, 550.5/ptm_ratio)  ,  new b2Vec2(5827/ptm_ratio, 540.5/ptm_ratio)  ,  new b2Vec2(5871/ptm_ratio, 532.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(10581/ptm_ratio, 492.5/ptm_ratio)  ,  new b2Vec2(10182/ptm_ratio, 465.5/ptm_ratio)  ,  new b2Vec2(10533/ptm_ratio, 483.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(3265/ptm_ratio, 508.5/ptm_ratio)  ,  new b2Vec2(2317/ptm_ratio, 439.5/ptm_ratio)  ,  new b2Vec2(2910/ptm_ratio, 440.5/ptm_ratio)  ,  new b2Vec2(3202/ptm_ratio, 492.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(5827/ptm_ratio, 540.5/ptm_ratio)  ,  new b2Vec2(6301/ptm_ratio, 550.5/ptm_ratio)  ,  new b2Vec2(5197/ptm_ratio, 609.5/ptm_ratio)  ,  new b2Vec2(5240/ptm_ratio, 598.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(2910/ptm_ratio, 440.5/ptm_ratio)  ,  new b2Vec2(2317/ptm_ratio, 439.5/ptm_ratio)  ,  new b2Vec2(2907.5/ptm_ratio, 436/ptm_ratio)  ] ,
                                                [   new b2Vec2(4674/ptm_ratio, 544.5/ptm_ratio)  ,  new b2Vec2(3343/ptm_ratio, 519.5/ptm_ratio)  ,  new b2Vec2(3422/ptm_ratio, 515.5/ptm_ratio)  ,  new b2Vec2(4636/ptm_ratio, 534.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(3317/ptm_ratio, 518.5/ptm_ratio)  ,  new b2Vec2(2305/ptm_ratio, 443.5/ptm_ratio)  ,  new b2Vec2(2317/ptm_ratio, 439.5/ptm_ratio)  ,  new b2Vec2(3265/ptm_ratio, 508.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(9114/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(7700/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(9050/ptm_ratio, 522.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12670/ptm_ratio, 635.5/ptm_ratio)  ,  new b2Vec2(11551/ptm_ratio, 545.5/ptm_ratio)  ,  new b2Vec2(11615/ptm_ratio, 545.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(3317/ptm_ratio, 518.5/ptm_ratio)  ,  new b2Vec2(5069/ptm_ratio, 607.5/ptm_ratio)  ,  new b2Vec2(5118/ptm_ratio, 614.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 678/ptm_ratio)  ,  new b2Vec2(1331/ptm_ratio, 561.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(13841/ptm_ratio, 612.5/ptm_ratio)  ,  new b2Vec2(14999.5/ptm_ratio, 679/ptm_ratio)  ,  new b2Vec2(12837/ptm_ratio, 639.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(8252/ptm_ratio, 509.5/ptm_ratio)  ,  new b2Vec2(7700/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(7729/ptm_ratio, 525.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(9114/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(6333/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(6360/ptm_ratio, 549.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(6301/ptm_ratio, 550.5/ptm_ratio)  ,  new b2Vec2(6333/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(5152/ptm_ratio, 615.5/ptm_ratio)  ,  new b2Vec2(5197/ptm_ratio, 609.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(11517/ptm_ratio, 542.5/ptm_ratio)  ,  new b2Vec2(9174/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(11484/ptm_ratio, 535.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(14999.5/ptm_ratio, 679/ptm_ratio)  ,  new b2Vec2(13841/ptm_ratio, 612.5/ptm_ratio)  ,  new b2Vec2(13861/ptm_ratio, 610.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(4695/ptm_ratio, 547.5/ptm_ratio)  ,  new b2Vec2(3343/ptm_ratio, 519.5/ptm_ratio)  ,  new b2Vec2(4674/ptm_ratio, 544.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(14999.5/ptm_ratio, 679/ptm_ratio)  ,  new b2Vec2(12744/ptm_ratio, 641.5/ptm_ratio)  ,  new b2Vec2(12837/ptm_ratio, 639.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(-0.5/ptm_ratio, 678/ptm_ratio)  ,  new b2Vec2(5152/ptm_ratio, 615.5/ptm_ratio)  ,  new b2Vec2(14999.5/ptm_ratio, 679/ptm_ratio)  ] ,
                                                [   new b2Vec2(11551/ptm_ratio, 545.5/ptm_ratio)  ,  new b2Vec2(9174/ptm_ratio, 528.5/ptm_ratio)  ,  new b2Vec2(11517/ptm_ratio, 542.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12744/ptm_ratio, 641.5/ptm_ratio)  ,  new b2Vec2(5152/ptm_ratio, 615.5/ptm_ratio)  ,  new b2Vec2(6333/ptm_ratio, 551.5/ptm_ratio)  ,  new b2Vec2(11551/ptm_ratio, 545.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(5152/ptm_ratio, 615.5/ptm_ratio)  ,  new b2Vec2(-0.5/ptm_ratio, 678/ptm_ratio)  ,  new b2Vec2(5118/ptm_ratio, 614.5/ptm_ratio)  ]
											];
			
			var arr2:Array=[];
			var body:b2Body
			var bodyDef:b2BodyDef
			var boxDef:b2PolygonShape;
			var fixtureDef:b2FixtureDef;
			bodyDef = new b2BodyDef();
			bodyDef.position.Set(0, -100/ptm_ratio);
			bodyDef.userData=new MovieClip();
			bodyDef.userData.alpha=0
			bodyDef.userData.name="notmoving";
			//this_parent.addChildAt(bodyDef.userData,0);
			body = world.CreateBody(bodyDef);
			my_arr=new Array(arr1)
		//	var my_Bodies:Array=new Array(arr1)
			for(var n:int=0;n<my_arr.length;n++){
				for(var m:int=0;m<my_arr[n].length;m++){
					boxDef=new b2PolygonShape();
					boxDef.SetAsArray(my_arr[n][m],my_arr[n][m].length);
					fixtureDef=new b2FixtureDef();
					fixtureDef.density = 1;
					fixtureDef.friction = 1;
					fixtureDef.restitution = 0.5;
					fixtureDef.shape = boxDef;
					body.CreateFixture(fixtureDef);
					trace("array length")
				}
			}
			trace("object created")
		}

	}
	
}
