package  
{
	import flash.display.Bitmap;
	import flash.display.ColorCorrection;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Main
	 */
	public class Tile extends Sprite
	{
		private var tileSide:int = 50;
		private var isBoat:Boolean = false; 	//Jag sätter boolean vareabler för att ha koll på vilkka egenskaper varje tile har och utifrån det kunna göra if satser.
		private var isClicked:Boolean = false;
		public var hit:Boolean;
		
		[Embed(source = "../hit.png")] 			//Deklarerar mina bitmap bilder för att kunna måla mina tiles med dem.
		private var HitImage:Class;
		
		[Embed(source = "../miss.png")]
		private var MissImage:Class;
		
		[Embed(source="../sea.png")]
		private var SeaImage:Class;
		
		public function Tile() 
		{
			this.graphics.beginBitmapFill(Bitmap(new SeaImage()).bitmapData);
			this.graphics.drawRect(0, 0, tileSide, tileSide);
			this.graphics.endFill();
		}
		
		public function clicked():String 	//Jag returnerar ett ett värde för att få reda på vad tilen har för egenskaper.
		{	
			if (isClicked == false) 	
			{
				this.isClicked = true;
				if (isBoat == true) 
				{
					this.graphics.clear();
					this.graphics.beginBitmapFill(Bitmap(new HitImage()).bitmapData);
					this.graphics.drawRect(0, 0, tileSide, tileSide);
					this.graphics.endFill();
					return "hit";
				}
				else 
				{
					this.graphics.clear();
					this.graphics.beginBitmapFill(Bitmap(new MissImage()).bitmapData);
					this.graphics.drawRect(0, 0, tileSide, tileSide);
					this.graphics.endFill();
					return "miss";
				}
			}
			else 
			{
				return "clicked";
			} 
		}
		
		public function reset():void  
		{
			this.graphics.clear();
			this.graphics.beginBitmapFill(Bitmap(new SeaImage()).bitmapData);
			this.graphics.drawRect(0, 0, tileSide, tileSide);
			this.graphics.endFill();
			this.isBoat = false;
			this.isClicked = false;
		}
		
		public function addBoat():void 
		{
			this.isBoat = true;
		}
	}
}