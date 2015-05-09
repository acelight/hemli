--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    Assign.lua
------------------------------------------------------------------------------]]

local Assign = {}

function Assign:actors ()

	io.write ' Hemlis:\t'

	print 'Done'

end

function Assign:agents (register, env)
	--~ function Assign:agentsb (register, env)

	io.write ' Agents:\t'

	if #register > 1 then
		for i = 1, #register do

			local struct, name, code = register[i][1], register[i][2], register[i][3]

			--~ print (struct, name, code)
			--~ pt(struct)


			local thread = llthreads.new (Models.Agent)
			assert(thread:start(true))
			--~ local pid = concurrent.spawn (Models:Agent (struct, name, code))

			--~ concurrent.register (code, pid)
			--~ concurrent.register (name, pid)
			--~ Agent.lookup_lu[code][4] = pid

		end
		--~ Agent.fallback = Agent.lookup_rl['fallback']

	end

	print 'Done'

end


return Assign