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
		
		yAcceleration = 1;
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
			Lib.trace("a is pressed");
			moveLeft();
		}
		else if ( Registry.game.keyboard.checkIfKeyPressed("s") )
		{
			Lib.trace("s is pressed");
		}
		else if ( Registry.game.keyboard.checkIfKeyPressed("d") )
		{
			Lib.trace("d is pressed");
			moveRight();
		}		
		else if ( Registry.game.keyboard.checkIfKeyPressed("spacebar") )
		{
			Lib.trace("spacebar is pressed");
			jump();
		}
		else if ( Registry.game.keyboard.checkIfKeyReleased("d") )
		{
			play("idle");
		}
		else if ( Registry.game.keyboard.checkIfKeyReleased("a") )
		{
			play("idle");
		}
		
		if ( checkIfCanMove(MoveDirection.Down) )
		{			
			yAcceleration = 1;
		}
		else
		{
			yAcceleration = 0;
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
		
	}
	
	/********************************************************************************
	 * COLLISIONS
	 * ******************************************************************************/
	function checkIfCanMove( direction : MoveDirection ) : Bool
	{
		if ( direction == MoveDirection.Down )
		{
			// We loop through tiles
			for ( i in 0...Registry.game.map.arrayWidth )
			{
				for ( j in 0...Registry.game.map.arrayHeight )
				{
					var theTile : Tile = Registry.game.map.get(i, j);					
					if ( theTile.tileValue != 0 )
					{
						//if ( ( y + frameHeight ) > theTile.y 
							//&&  y < (theTile.y + theTile.frameHeight) )
						if ( JKUtils.collide(this, theTile) )
						{						
							Lib.trace("collision with " + theTile.objectName);
							return false;
						}
					}
				}
			}
		}
		
		Lib.trace("No collision");
		return true;
	}
}