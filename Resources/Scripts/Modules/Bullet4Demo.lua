-- Bullet handling for demo. Initial versions will only allow one bullet, subsequent
-- versions should allow more.

bullet = { x = 0, y = 0, dest = { x = 100, y = 50 }, lock = { x = false, y = false }, force = 100, velocity = 1, beta = 0, theta = 0, size = { x = 0, y = 0 }, turn_rate = 0.01, ammo = 50 }
bullet.size.x, bullet.size.y = graphics.sprite_dimensions("Weapons/WhiteYellowMissile")
firebullet = false

function fire_bullet()
	if bullet.ammo > 0 then
		local shipLocation = ship:location()
		local shipVelocity = ship:speed()
		physbullet = PhysicsObject(1.0, ship:location(), ship:velocity(), ship:angle())
		physbullet:set_top_speed(50.0)
		physbullet:set_top_angular_velocity(bullet.turn_rate)
		physbullet:set_rotational_drag(0.2)
		physbullet:set_drag(0.0)
		
		bullet.x = shipLocation.x + math.cos(ship:angle()) * 100
		bullet.y = shipLocation.y + math.sin(ship:angle()) * 100
		bullet.dest.x = 100
		bullet.dest.y = 50
		bullet.beta = math.atan2(bullet.dest.y - bullet.y, bullet.dest.x - bullet.x)
		bullet.theta = ship:angle()
		-- theta is the true angle of the bullet, and beta is the desired angle
		
		if bullet.theta ~= bullet.beta then -- if the angles are the same, don't go through this if nest
			if bullet.beta >= bullet.theta + bullet.turn_rate then
				bullet.theta = bullet.theta + bullet.turn_rate
			else -- if bullet.beta < bullet.theta + bullet.turn_rate then
				if bullet.beta > bullet.theta then -- the difference between the two is less than the turn rate
					bullet.theta = bullet.beta -- make them equal
				elseif bullet.beta > bullet.theta - bullet.turn_rate then -- the difference between the two is less than the turn rate, on the other side
					bullet.theta = bullet.beta -- make them equal
				end
			end
			if bullet.beta < bullet.theta - bullet.turn_rate then -- theta is less than beta by a difference more than the turn rate
				bullet.theta = bullet.theta - bullet.turn_rate
			end
		end
		
		bullet.theta = bullet.theta % (math.pi * 2)
		force = { x = 0, y = 0 }
		force.x = math.cos(bullet.theta) * bullet.force
		force.y = math.sin(bullet.theta) * bullet.force
--		force.x = math.cos(bullet.theta) * shipVelocity.x
--		force.y = math.sin(bullet.theta) * shipVelocity.y

		physbullet:set_angle(bullet.theta)
		physbullet:update(dt, force, 0.0)

		bullet.ammo = bullet.ammo - 1
		sound.play("RocketLaunchr")
		-- temp sound file, should be "RocketLaunch" but for some reason, that file gets errors (file included in git for troubleshooting)
	end
end
