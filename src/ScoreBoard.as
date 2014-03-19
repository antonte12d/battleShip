package  
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Main
	 */
	public class ScoreBoard extends TextField
	{
		private var numberOfHits:int;
		private var numberOfMiss:int;
		private var numberOfMultiClick:int;
		private var comment:String = "Lets start!" + '\n' + "Use your mouse to find the ship!";
		
		private var scoreBoardMargin:int = 20;
		
		public function ScoreBoard() 
		{
			this.x = 600;
			this.y = 100;
			this.width = 200;
			this.height = 150;
		}
		
		public function draw():void 	//Jag har en funktion för att kunna uppdatera resultaten när det behövs.
		{
			this.text = "Your hits: " + numberOfHits + '\n';
			this.appendText("Your miss: " + numberOfMiss + '\n' + '\n');
			this.appendText("Comment: " + '\n' + comment + '\n');
			this.appendText("Press space to restart");
			this.wordWrap = true;
			
		}
		
		public function addHit():void 	//comment är till för att göra spelet mer unikt och roligare än att bara leta efter ett skepp.
		{
			numberOfHits ++;
			if (numberOfHits == 3) 
			{
				comment = "Well done! The ship is down!";
			}
			else if (numberOfHits == 2)
			{
				comment = "You´re almost there! One left!";
			}
			else if (numberOfHits == 1) 
			{
				comment = "Finaly! You have found the ship!";
			}
		}
		
		public function addMiss():void 
		{
			if (numberOfHits != 3) 		//min ScoreBoard slutar räkna antalet missar när båten är sänkt men man kan fortfarande klicka på fler tiles eftersom kommentarerna fortsätter.
			{
				numberOfMiss ++;
			}
			
			if (numberOfHits == 1) 
			{
				comment = "You just hit the boat! You know where it is!";
			}
			else if (numberOfHits == 2) 
			{
				comment = "You had one job...";
			}
			else if (numberOfHits == 3)
			{
				comment = "Ehm... What are you doing? There is no more boats";
			}
			else if (numberOfMiss <= 5) 
			{
				comment = "Don´t give up! Keep searching!";
			}
			else if (numberOfMiss <= 10) 
			{
				comment = "Okey you can give up if you want...";
			}
			else if (numberOfMiss <= 20) 
			{
				comment = "Seriously? Haha no you´re joking!";
			}
			else if (numberOfMiss <= 30) 
			{
				comment = "If you´re serious, just give up...";
			}
			else if (numberOfMiss <= 40) 
			{
				comment = "No, you can´t be serious! No one is that bad!";
			}
			else if (numberOfMiss <= 50) 
			{
				comment = "Just give up... You suck!";
			}
			else if (numberOfMiss <= 60) 
			{
				comment = "You suck! Press space!";
			}
			else if (numberOfMiss <= 70) 
			{
				comment = "Are you still there?";
			}
			else if (numberOfMiss > 70) 
			{
				comment = "Okey, I´m leaving! Help yourself!";
			}
			
		}
		
		public function addClicked():void
		{
			numberOfMultiClick ++;
			if (numberOfHits == 3) 
			{
				comment = "Stop click on the clicked ones! There is no more boats!";
			}
			else if (numberOfMultiClick <= 5) 
			{
				comment = "You have already clicked here!";
			}
			else if (numberOfMultiClick <= 10) 
			{
				comment = "Okey, stop it´s clicked!"
			}
			else if (numberOfMultiClick > 10) 
			{
				comment = "I did not see that..."
			}
		}
		
		public function resestScoreBoard():void 
		{
			numberOfHits = 0;
			numberOfMiss = 0;
			numberOfMultiClick = 0;
			comment = "Lets start!" + '\n' + "Use your mouse to find the ship!";
		}
	}

}