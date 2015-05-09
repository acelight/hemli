

local zmq = require 'lzmq'
local context = zmq.init(1)



--~ while true do
    --~ -- Recieve from broadcast
    --~ local msg = ''
    --~ if msg.code == 0 then
        --~ return 0
    --~ elseif msg.code == 1 then
        --~ return 0
    --~ elseif msg.code == 3 then
        --~ return 0
    --~ elseif msg.code == 5 or msg.code == 7 then
        --~ return 0
    --~ end
    --~ -- Recieve from everywhere else
    --~ local msg = ''
    --~ local result = my.procedure (msg)
    --~ if result == 0 then
    --~ end
--~ end

print (code)

--  Socket to talk to server
print("Connecting to hello world server…")
local socket = context:socket(zmq.REQ)
socket:connect("tcp://localhost:5555")

for n=1,10 do
    print("Sending Hello " .. n .. " …")
    socket:send("Hello")

    local reply = socket:recv()
    print("Received World " ..  n .. " [" .. reply .. "]")
end
socket:close()
context:term()

os.exit(0)