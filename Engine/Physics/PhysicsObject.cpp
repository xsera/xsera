#ifdef WIN32
#define _USE_MATH_DEFINES
#include <cmath>
#endif

#include "PhysicsObject.h"
#include <math.h>

namespace Physics
{

void Object::ApplyImpulse ( vec2 impulse )
{
    velocity += (impulse / mass);
}

void Object::ApplyAngularImpulse ( float impulse )
{
    angularVelocity += (impulse / mass);
}

void Object::SetVelocity ( vec2 velocityNew )
{
	velocity = velocityNew;
}

void Object::Init ()
{
	velocity.X() = 0;
	velocity.Y() = 0;
	angle = 0;
	angularVelocity = 0;
	torque = 0;
}

const float fluidDragRho = 1.204; // this is the density of air at 20 degrees celsius

void Object::Update ( float timestep, float friction )
{
    // step 1: apply resistive force
	vec2 dragForce = -velocity.UnitVector() * fluidDragRho * velocity.ModulusSquared() * /* (2.0f * M_PI * collisionRadius) */ friction;
	//ALISTAIR: what's this 2*pi*r stuff? It's what's causing the problem!
	//on second thought, why is there drag in space??
//	force += dragForce;
    // step 2: update velocity from force
    velocity += (force * timestep);
    // step 3: update position from velocity
    position += (velocity * timestep);
    // step 4: update angular velocity from torque
    angularVelocity += (torque * timestep);
    // step 5: update angle from angular velocity
    angle += (angularVelocity * timestep);
    // step 6: limit angle to 0...2pi
    if (angle > 2.0f*M_PI)
        angle = fmodf(angle, 2.0f*M_PI);
    while (angle < 0.0f)
        angle += 2.0f*M_PI;
    // step 7: clear torque and force
    torque = 0.0f;
    force = vec2(0.0f, 0.0f);
}

/*
obj1 is the ship or planet, while obj2 is the projectile (which has an insignificant radius)
*/
bool Object::Collision( vec2 obj1, vec2 obj2, float radius )
{
	if ( hypotf(obj1.X() - obj2.X(), obj1.Y() - obj2.Y()) <= radius)
	{
		return true;
	}
	return false;
}

/*
obj1 and obj2 both have radii (ship to ship, ship to planet collisions)
*/
bool Object::Collision( vec2 obj1, vec2 obj2, float radius1, float radius2 )
{
	if ( hypotf(obj1.X() - obj2.X(), obj1.Y() - obj2.Y()) <= (radius1 + radius2))
	{
		return true;
	}
	return false;
}

}
