package ;
import jkEngine.JKSprite;
import jkEngine.JKUtils;
import nme.display.DisplayObjectContainer;
import jkEngine.input.JKKeyboard;
import nme.Lib;

/**
 * ...
 * @author Karlo
 */

enum MoveDirection
{
	Up;
	Down;
	Left;
	Right;
}
 
class Player extends JKSprite
{
	var movementSpeed : Float = 3;
	var gravity : Float = 0.05;
	var isJumping : Bool = false;

	/********************************************************************************
	 * MAIN
	 * ******************************************************************************/
	public function new( xPos : Float = 0, yPos : Float = 0, ?FrameWidth : Float
		, ?FrameHeight : Float, ?graphicFileLocation : String, IsAnimated : Bool = false, ?theLayer : DisplayObjectContainer ) 
	{
		super(xPos, yPos, FrameWidth, FrameHeight, graphicFileLocation, IsAnimated, theLayer);
		
		addAnimation("idle", [ 0, 1, 2, 3], 150 );
		addAnimation("run", [4, 5, 6, 7, 8, 9, 10, 11], 100 );
		addAnimation("jump", [ 12, 13, 14, 15, 16, 17, 18], 150 );		
		
		velocity.y = gravity;
		maxVelocity.y = 2;
		play("idle");
	}	
	
	override private function update():Dynamic 
	{		
		super.update();
		
		//trace(Registry.game.keyboard.getPressedKey());
		if ( Registry.game.keyboard.checkIfKeyPressed("w") )
		{
			Lib.trace("w is pressed");
		}
		else if ( Registry.game.keyboard.checkIfKeyPressed("a") )
		{
			if ( checkIfCanMove(MoveDirection.Left))
			{
				moveLeft();
			}
		}
		else if ( Registry.game.keyboard.checkIfKeyPressed("s") )
		{
			if ( checkIfCanMove(MoveDirection.Down))
			{
				Lib.trace("s is pressed");
			}			
		}
		else if ( Registry.game.keyboard.checkIfKeyPressed("d") )
		{
			if ( checkIfCanMove(MoveDirection.Right))
			{
				moveRight();
			}
		}				
		else if ( Registry.game.keyboard.checkIfKeyReleased("d") )
		{
			play("idle");
		}
		else if ( Registry.game.keyboard.checkIfKeyReleased("a") )
		{
			play("idle");
		}
		
		if ( Registry.game.keyboard.checkIfKeyPressed("spacebar") )
		{
			Lib.trace("spacebar is pressed");
			jump();
		}
		else
		{
			Lib.trace("spacebar is released");
			isJumping = false;
		}
		
		if ( checkIfCanMove(MoveDirection.Down) )
		{			
			velocity.y = gravity;
		}
		else
		{
			velocity.y = 0;
			velocityDelta.y = 0;
		}
	}
	
	
	/********************************************************************************
	 * MOVEMENT
	 * ******************************************************************************/
	function moveRight() : Void
	{
		x += movementSpeed;		
		play("run");
		flipGraphic(GraphicDirection.Right);
	}
	
	function moveLeft() : Void
	{
		x -= movementSpeed;
		play("run");
		flipGraphic(GraphicDirection.Left);
	}
	
	function jump() : Void
	{
		if ( isJumping )
			return;
			
		acceleration.y = -3;
		isJumping = true;
	}
	
	/********************************************************************************
	 * COLLISIONS
	 * ******************************************************************************/
	function checkIfCanMove( direction : MoveDirection ) : Bool
	{
		var yToCheck : Float = y;
		var xToCheck : Float = x;
		
		if ( direction == MoveDirection.Up )
		{
			yToCheck -= movementSpeed;
		}
		else if ( direction == MoveDirection.Down )
		{
			yToCheck += movementSpeed;
		}
		else if ( direction == MoveDirection.Left )
		{
			xToCheck -= movementSpeed;
		}
		else if ( direction == MoveDirection.Right )
		{
			xToCheck += movementSpeed;
		}		
		
		// We loop through tiles
		for ( i in 0...Registry.game.map.arrayWidth )
		{
			for ( j in 0...Registry.game.map.arrayHeight )
			{
				var theTile : Tile = Registry.game.map.get(i, j);					
				if ( theTile.tileValue != 0 )
				{
					if ( ( yToCheck + frameHeight ) > theTile.y 
						&& yToCheck < (theTile.y + theTile.frameHeight) 
						&& xToCheck + frameWidth > theTile.x 
						&& xToCheck < (theTile.x + theTile.frameWidth))
					{		
						return false;
					}
				}
			}
		}
		
		return true;
	}
}