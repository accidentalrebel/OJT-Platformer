package ;
import jkengine.JKPoint;
import jkEngine.JKSprite;
import jkEngine.JKUtils;
import nme.display.DisplayObjectContainer;
import jkEngine.input.JKKeyboard;
import nme.Lib;
import nme.ui.Keyboard;

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
	var movementSpeed : Float = 5;
	var gravity : Float = 0.50;
	var isJumping : Bool = false;
	var isGrounded : Bool = false;
	var maxJump : Int = 10;
	
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
		maxVelocity.y = 30;
		play("idle");
	}	
	
	override private function update():Dynamic 
	{		
		if ( Registry.game.keyboard.checkIfKeyPressed(Keyboard.A) )
		{
			if ( checkIfCanMove(MoveDirection.Left))
			{
				moveLeft();
			}
		}		
		else if ( Registry.game.keyboard.checkIfKeyPressed(Keyboard.D) )
		{
			if ( checkIfCanMove(MoveDirection.Right))
			{
				moveRight();
			}
		}				
		else
		{
			play("idle");
		}
				
		// Jumping
		if ( Registry.game.keyboard.checkIfKeyPressed(Keyboard.SPACE) )
		{
			if ( isGrounded )
			{			
				jump();	
			}
		}
		
		super.update();
		
		if ( checkIfCanMove(MoveDirection.Down) )
		{			
			velocity.y = gravity;
		}
		
		
		if ( !checkIfCanMove(MoveDirection.Up) )
		{
			velocity.y = gravity * 2;		
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
		velocity.y = 0;
		velocityDelta.y = 0;
		acceleration.y = -10;
		isGrounded = false;
	}
	
	/********************************************************************************
	 * COLLISIONS
	 * ******************************************************************************/
	function checkIfCanMove( direction : MoveDirection ) : Bool
	{
		var point1 : JKPoint = new JKPoint(x, y);
		var point2 : JKPoint = new JKPoint(x + frameWidth, y);
		var point3 : JKPoint = new JKPoint(x + frameWidth - 10, y + frameHeight - 10);
		var point4 : JKPoint = new JKPoint(x + 10, y + frameHeight - 10);		
		
		var yToCheck : Float = y + (frameHeight / 2);
		var xToCheck : Float = x + (frameWidth / 2);
		
		if ( direction == MoveDirection.Up )
		{
			yToCheck -= (( frameHeight / 2 ) - 10);
		}
		else if ( direction == MoveDirection.Down )
		{
			yToCheck += (( frameHeight / 2 ) - 3);
		}
		else if ( direction == MoveDirection.Left )
		{
			xToCheck -= (( frameHeight / 2 ) -10 );
		}
		else if ( direction == MoveDirection.Right )
		{
			xToCheck += (( frameHeight / 2 ) - 10);
		}		
		
		// We loop through tiles
		for ( i in 0...Registry.game.map.arrayWidth )
		{
			for ( j in 0...Registry.game.map.arrayHeight )
			{
				var theTile : Tile = Registry.game.map.get(i, j);					
				if ( theTile.tileValue != 0 )
				{		
					if ( direction == MoveDirection.Right )
					{
						if ( checkIfColliding(point2, theTile) || checkIfColliding(point3, theTile) )
						{
							return false;
						}
					}
					else if ( direction == MoveDirection.Left )
					{
						if ( checkIfColliding(point1, theTile) || checkIfColliding(point4, theTile) )
						{
							return false;
						}
					}
					else
					{
						if ( yToCheck > theTile.y 
							&& yToCheck <= (theTile.y + theTile.frameHeight) 
							&& xToCheck > theTile.x 
							&& xToCheck <= (theTile.x + theTile.frameWidth))
						{							
							var adjustAmount : Float = 0;
							if ( direction == MoveDirection.Down )
							{
								adjustAmount = yToCheck - theTile.y;
								y -= adjustAmount;
								
								velocity.y = 0;
								acceleration.y = 0;
								isGrounded = true;
							}
							
							return false;
						}	
					}						
				}
			}
		}
		
		return true;
	}
	
	function checkIfColliding( point : JKPoint, theTile : Tile) : Bool
	{
		if ( point.y > theTile.y 
			&& point.y < (theTile.y + theTile.frameHeight) 
			&& point.x > theTile.x 
			&& point.x < (theTile.x + theTile.frameWidth) )
		{
			return true;
		}
		
		return false;
	}
	
	function checkIfGrounded() : Bool
	{
		var yToCheck : Float = y + (frameHeight / 2) ;
		var xToCheck : Float = x + (frameWidth / 2);
		
		// We loop through tiles
		for ( i in 0...Registry.game.map.arrayWidth )
		{
			for ( j in 0...Registry.game.map.arrayHeight )
			{
				var theTile : Tile = Registry.game.map.get(i, j);					
				if ( theTile.tileValue != 0 )
				{
					if ( ( yToCheck + frameHeight ) > theTile.y 
						&& yToCheck <= (theTile.y + theTile.frameHeight) 
						&& xToCheck + frameWidth > theTile.x 
						&& xToCheck <= (theTile.x + theTile.frameWidth))
					{	
						velocity.y = 0;
						acceleration.y = 0;
						return true;						
					}
				}
			}
		}
			
		return false;
	}
}