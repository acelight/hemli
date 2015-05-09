
-- require section
require "../header"

Mind        = require "mind"
Dna         = require "dna"

print (arg[1])

-- ID arg
local id = arg[1]

local citizen = dofile (Config.population..id)

local hemli = {
	['alive']     = 1,
	['id']        = id,
	['age']       = citizen[1][1],
	['energy']    = citizen[1][2],
	['total']     = citizen[1][3],
	['distance']  = citizen[1][4],
	['coord']     = {citizen[1][5], citizen[1][6]},
	['mind']      = Mind:CreateMind (citizen[2]),
}

citizen = nil

local function prototypeAgent (struct, name, code, pid)

	function Agent:procedure (msg)
		return 0
	end

	function Agent:run ()
		while true do
			-- Recieve from broadcast
			local msg = concurrent.receive('broadcast')
			if msg.code == 0 then
				return
			elseif msg.code == 1 then
				return
			elseif msg.code == 3 then
				return
			elseif msg.code == 5 or msg.code == 7 then
				return
			end
			-- Recieve from everywhere else
			local msg = concurrent.receive('network')
			local result = Self:procedure (msg)
			if result == 0 then
				concurrent.sent ('controller', {from = concurrent.self, body = 'dead'})
			end
		end
	end

end


-- Subscribe to zipcode, default is NYC, 10001
local filter = "10001"

printf("Collecting updates from weather server ...\n")

local context = zmq.context()

-- Socket to talk to server
local subscriber, err = context:socket{zmq.SUB,
  subscribe = filter .. " ";
  connect   = "tcp://localhost:5556";
}
zassert(subscriber, err)

-- Process 100 updates
local update_nbr, total_temp = 100, 0
for i = 1, update_nbr do
  local message = subscriber:recv()
  local zipcode, temperature, relhumidity = string.match(message, "([%d]*)%s+([-]?[%d-]*)%s+([-]?[%d-]*)")
  print (zipcode, temperature, relhumidity)
  assert(zipcode == filter)
  total_temp = total_temp + tonumber(temperature)
end

printf ("Average temperature for zipcode '%s' was %dF\n",
  filter, (total_temp / update_nbr))

