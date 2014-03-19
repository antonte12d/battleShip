package 
{
	import flash.display.ColorCorrection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Main
	 */
	public class Main extends Sprite 
	{
		private var tile:Tile = new Tile();
		private var numberOfTiles:int = 0;
		private var battlefieldY:Vector.<Vector.<Sprite>> = new Vector.<Vector.<Sprite>>();
		private var battlefieldX:Vector.<Sprite>;
		private var scoreBoard:ScoreBoard = new ScoreBoard();
		
		private const TILE_X_START:int = 25;
		private const TILE_Y_START:int = 20;
		private var tileX:int = TILE_X_START;
		private var tileY:int = TILE_Y_START;
		private var tileMargin:int = 2;
		private var shipHorizontal:Boolean;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			scoreBoard.draw();
			addChild(scoreBoard);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, restartGame)
			
			for (var i:int = 0; i < 10; i++) 
			{	
				battlefieldX = new Vector.<Sprite>(); 	//För att få 100 tiles på scenen placerar jag 10 vektorer, med 10 tiles i vardera, i en vektor.
				for (var j:int = 0; j < 10; j++) 
				{
					var t:Tile = new Tile(); 			//Klassen Tile ärver sprite-klassens egenskaper men är uppritad i anpassning för detta spel.
					battlefieldX.push(t);
					addChild(t); 
					t.x = (t.width + tileMargin) * j + TILE_X_START;
					t.y = (t.height + tileMargin) * i + TILE_Y_START;
					numberOfTiles ++;
					t.addEventListener(MouseEvent.CLICK, shot)
				}
				battlefieldY.push(battlefieldX);
			}	
			addBoats();
			
		}
		
		function addBoats():void 
		{
			var boatX:int;
			var boatY:int; 
			
			shipHorizontal = Math.round(Math.random()); //Genom att göra en boolean-variabel som bestämmer om skeppet är horisontellt eller inte kan jag enkelt slumpa variabeln. Jag avrundar även för att svaret ska bli antingen 1 eller 0 inget där emellan.
			
			if (shipHorizontal == true) 
			{
				boatX = Math.random() * 6;
				boatY = Math.random() * 9; 		//För att skeppet inte ska befinna sig utanför spelplanen måste jag variera på boatX/boatY beroende på om skeppet är horisontellt eller ej.
				
				Tile(battlefieldY[boatX][boatY]).addBoat(); 	//När en slumpad tile har valts väljer jag även två tiles brevid för att skepptes delar ska vara utspridda.
				Tile(battlefieldY[boatX + 1][boatY]).addBoat();
				Tile(battlefieldY[boatX + 2][boatY]).addBoat();	
			}
			else if (shipHorizontal == false) 	//Samma som ovan fast anpassad för vertikal.
			{
				boatX = Math.random() * 9;
				boatY = Math.random() * 6;
				
				Tile(battlefieldY[boatX][boatY]).addBoat();
				Tile(battlefieldY[boatX][boatY + 1]).addBoat();
				Tile(battlefieldY[boatX][boatY + 2]).addBoat();
			}	
		}
		
		private function shot(e:MouseEvent):void 	//Till varje tile skapas en eventlistner som reagerar på om den blir klickad på och functionerna är skapade i Tile-klassen.
		{
			var result:String = Tile(e.target).clicked(); //Funktionen i Tile-klassen returnerar en variabel beroende på vad den klickade tilen har för egenskaper.
			if (result == "hit") 
			{
				scoreBoard.addHit(); //Kör en funktion i SocoreBoard för att den ska ha koll på resultaten i spelet.
			}
			else if (result == "miss")
			{
				scoreBoard.addMiss();
			}
			else if (result == "clicked")
			{
				scoreBoard.addClicked();
			}
			scoreBoard.draw(); 	//Ritar om scoreboarden med uppdaterade siffror för att tavlan inte ska vara missvisande.
		}
		
		private function restartGame(e:KeyboardEvent):void 
		{
			
			if (e.keyCode == Keyboard.SPACE) 
			{
				for (var i:int = 0; i < 10; i++) 
				{
					for (var j:int = 0; j < 10; j++) 
					{
						Tile(battlefieldY[i][j]).reset(); //Rensar allt till början smidigt med hjälp av vektorerna och en funktion från Tile-klassen.
					}
				}
				addBoats();	
				scoreBoard.resestScoreBoard();
				scoreBoard.draw();
			}
		}	
	}
}