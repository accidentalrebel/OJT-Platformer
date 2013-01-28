package ;
import jkengine.JKPoint;
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
	var isGrounded : Bool = false;
	
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
		if ( Registry.game.keyboard.checkIfKeyPressed("a") )
		{
			if ( checkIfCanMove(MoveDirection.Left))
			{
				moveLeft();
			}
		}		
		else if ( Registry.game.keyboard.checkIfKeyPressed("d") )
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
		if ( Registry.game.keyboard.checkIfKeyPressed("spacebar") )
		{
			if ( checkIfGrounded() )
			{			
				jump();	
			}
		}
		else
		{
			isJumping = false;
		}		
		
		super.update();
		
		if ( checkIfCanMove(MoveDirection.Down) )
		{			
			velocity.y = gravity;
		}
		else
		{
			velocity.y = 0;
			velocityDelta.y = 0;
		}	
		
		if ( !checkIfCanMove(MoveDirection.Up) )
		{
			velocity.y = gravity * 2;		
			velocityDelta.y = 0;
		}
	}
	//
	//override private function ApplyMovement():Dynamic 
	//{			
		// We apply acceleration
		//if ( acceleration.y != 0 )
		//{
			//velocity.y += acceleration.y;
			//acceleration.y -= velocity.y;
		//}
		//
		//if ( acceleration.x != 0 )
		//{
			//velocity.x += acceleration.x;
			//acceleration.x -= velocity.x;
		//}
		//
		// We apply the velocity
		//if ( velocityDelta.y < maxVelocity.y )
		//{
			//if ( velocity.y != 0 )
				//velocityDelta.y += velocity.y;
		//}
		//
		//if ( velocityDelta.x < maxVelocity.x )
		//{
			//if ( velocity.x != 0 )
				//velocityDelta.x += velocity.x;
		//}
		//
		//y += velocityDelta.y;
		//x += velocityDelta.x;
	//}
	
	
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
		var point1 : JKPoint = new JKPoint(x, y);
		var point2 : JKPoint = new JKPoint(x + frameWidth, y);
		var point3 : JKPoint = new JKPoint(x + frameWidth, y + frameHeight);
		var point4 : JKPoint = new JKPoint(x, y + frameHeight);		
		
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
					if ( yToCheck > theTile.y 
						&& yToCheck < (theTile.y + theTile.frameHeight) 
						&& xToCheck > theTile.x 
						&& xToCheck < (theTile.x + theTile.frameWidth))
					{	
						return false;
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
		var yToCheck : Float = y + (frameHeight);
		var xToCheck : Float = x;
		
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
						isGrounded = true;
						return true;
						
					}
				}
			}
		}
		isGrounded = false;
		
		return false;
	}
}