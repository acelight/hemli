--[[

    The Hopefully EMergent LIfeform (HEMLI) Project

    World.lua
    Creates the "world" which the Hemlis interact with

]]

local World = {}

--------------------------------------------------------------------------------
-- PNS functions
--------------------------------------------------------------------------------

    function World.is_day ()

        --~ local a = a

        --~ while true do

            local msg = concurrent.receive()

            print ('is_day')

            Vars.is_day = false -- Set World variable every time
            if tonumber(os.date('%M')) % 2 == 0 then -- If even number, then day
                Vars.is_day = true
            end

            if msg.code == 1 then
                concurrent.send (msg.from, {from='World.is_day', is_day=Vars.is_day})
            end

        --~ end
    end

    function World.is_raining (args)

        while true do

            local msg = concurrent.receive()

            if msg.code == 1 then
                -- recode so that it scales
                concurrent.send (msg.from, {from='World.is_raining', is_raining=0.12})
            end

            if msg.from == 'world' then

                if msg.code == 3 then


                elseif msg.code == 0 then
                    break
                end

            end

            concurrent.send ('world', {from = concurrent.self, body = 'done'})

        end

    end

    function World.food (args)

        print 'food called erwgergertg'

        local msg = concurrent.receive()

        pt (msg)

        local food_code = Pns.pns [ 'code_food' ]

        local is_day    = Vars.is_day
        local is_raining= Vars.is_raining
        local args      = args

        -- Telling a Hemli if there is food there or not
        if msg.code == 0 then

            print 'test'

        elseif msg.code == 1 then
            print 'code1'
            local hemli = msg.hemli
            local x = hemli.coord[1]
            local y = hemli.coord[2]
            return Env[x][y][food_code]

        elseif msg.from == 'world' then

            print 'world'

            if msg.code == 3 then

                if Vars.is_day then

                    for x = 1, #Env do; for y = 1, #Env[x] do

                        Env[x][y][food_code] = (Env[x][y][food_code] < 0 or type(Env[x][y][food_code]) ~= 'number' ) and 0 or Env[x][y][food_code]

                        math.randomseed (Config.randomseed.food)
                        local r = math.random()
                        local food_level = ( math.sin(x * y) * r )
                        Config.randomseed.food = r

                        if food_level < Config.food_bounds[1] then
                            Env[x][y][food_code] = Env[x][y][food_code] + 0

                        elseif food_level < Config.food_bounds[2] then
                            Env[x][y][food_code] = Env[x][y][food_code] + 1

                        elseif food_level < Config.food_bounds[3] then
                            Env[x][y][food_code] = Env[x][y[food_code]] + 2

                        else
                            Env[x][y][food_code] = Env[x][y][food_code] + 3

                        end

                    end; end
                end

                concurrent.sent ('world', {from = pid, body 'done'})

            end
        else
            print 'odd will robison'
        end
    end



--------------------------------------------------------------------------------
--/PNS Functions
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Simulation Functions
--------------------------------------------------------------------------------

	--~ function World.h_gen_food_level (self, x, y)
	function World:gen_food (x, y)

        math.randomseed (Config.randomseed.food)
        local r = math.random()
		local food_level = math.sin(x * y) * r
        Config.randomseed.food = r

		if food_level < Config.food_bounds[1] then
			return 0

		elseif food_level < Config.food_bounds[2] then
			return 1

		elseif food_level < Config.food_bounds[3] then
			return 2

		else
			return 3

		end

	end

	function World:create ()

        world = {}

		for x = 1, Config.dimension.x do world[x] = {}
        for y = 1, Config.dimension.y do world[x][y] = {}

            -- Generate Food
            world[x][y][0] = self:gen_food(x, y)

        end end

        return world

	end

return World