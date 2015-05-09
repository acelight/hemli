#!/usr/bin/env lua
--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    Header.lua

]]------------------------------------------------------------------------------

require 'header'

Fs          = require 'lfs'

Init        = require 'init'
Assign      = require 'assign'
Agent       = require 'agent'

dofile 'call.lua'


-- Initialisation of factors

print 'Initialising'
--~ local register= Init:agents ()
--~ local env     = Init:world  ()
Init:hemli  ()
--~ Hemlis = hemlis

--~ pt(register[1])
--~ pt(env)
--~ pt(hemlis)

-- Assign nodes
print 'Assigning'
--~ Assign:agents (register, env)
--~ Assign:actors (hemlis)

-- Commence
print 'System Ready...'
print 'Loading UI'

--~ pt(Hemlis['0000'].mind:eval ({1, 2, 3, 4, 5, 6, 7, 8, 9}, '0000'))]]

sleep (3)

local context = zmq.context()
local publisher, err = context:socket{zmq.PUB, bind = "tcp://*:5556"}
zassert(publisher, err)
publisher:bind("ipc://weather.ipc")

while true do
  -- Get values that will fool the boss
  --~ local zipcode     = randof(100000)
  local zipcode     = "10001"
  local temperature = randof (215) - 80
  local relhumidity = randof (50) + 10

    sleep (2)

  -- Send message to all subscribers
  local update = sprintf("%05d %d %d", zipcode, temperature, relhumidity)
  print (string.format ("%05d %d %d", zipcode, temperature, relhumidity))
  publisher:send(update)
end
