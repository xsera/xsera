#ifndef __apollo_graphics_starfield_h
#define __apollo_graphics_starfield_h

#include <Utilities/Vec2.h>
#include <string>
#ifdef WIN32
#include <gl/gl.h>
#else
#include <OpenGL/gl.h>
#endif

namespace Graphics
{

const unsigned STARFIELD_WIDTH  = 256;
const unsigned STARFIELD_HEIGHT = 256;

class Starfield
{
public:
	GLuint texID;
	Starfield ();
	~Starfield ();
	vec2 Dimensions ( float depth );
	void Draw ( float depth, vec2 centre );
};

}

#endif