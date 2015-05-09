--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    Agent.lua
    Provides the structure for the PNS system
------------------------------------------------------------------------------]]
local mt = {}
mt.r, mt.p = {}, {}


local Agent = {}

Agent.fallback= {}

Agent.enroled = {}

-- Enroles the agents to be used in the programme
-- They are to supply a structure {data={}, procedure={}},
-- Name which is the variable name
-- Optional index
function Agent:Enrole (struct, name, index)

	if type (struct) == 'table' then
		self.enroled [ #self.enroled+1 ] = {struct, name, index}
	else
		p_err ('Agent:enrole_reg', 'The function [ '..name..' ] is invalid or does not exist', 'Unable to include on register, errant behaviour should be expected', 'NOT terminating', false)
	end

end

function Agent:MakeRegister ()

	local register = {}

	-- Inserts the calls, who specified, into their chosen place on the register
	for i = 1, #self.enroled do

		if self.enroled[i][3] then

			local index = self.enroled[i][3]

			if not register[index] then
				local struct, name = self.enroled[i][1], self.enroled[i][2]
				local code = Agent:GenerateID (name)

				register[index] = {struct, name, code}
				Agent.lookup_lu[code] = {func, name, code}
				Agent.lookup_rl[name] = code
				self.enroled[i] = {}

			else
				p_err ('Agent:MakeRegister', name..' is attempting to use ['..index..']\nThis used by '..register[index][2], '', name..' Will be allocated a different index. Errant behaviour maybe expected', false)

			end
		end
	end

	-- Inserts the remaing calls where there are gaps
	local index = 1

	for i = 1, #self.enroled do

		while register[index] do
			index = index + 1
		end

		local struct, name = self.enroled[i][1], self.enroled[i][2]
		local code = Agent:GenerateID (name)

		register[index] = {struct, name, code}
		self.lookup_lu[code] = {func, name, code}
		self.lookup_rl[name] = code
		self.enroled[i] = {}

	end

	self.enroled = {}

	return register

end

function Agent:GenerateID (name)

	if self.lookup_rl[name] then
		return self.lookup_rl [name]

	else
		math.randomseed (Config.randomseed.agent)
		local code = math.random (0, 255)

		while self.lookup_lu[code] do
			code = math.random (0, 255)
		end

		Config.randomseed.agent = code
		return code

	end

end

-- Something else entirely?

Agent.lookup     = {}
Agent.lookup_lu  = {}
Agent.lookup_rl  = {}

mt.p.__index = function (t, key)

	if type (key) == 'string' or type (key) == 'number' then

		if Agent.lookup_lu[key] then
			return Agent.lookup_lu[key]
		else
			return Agent.lookup_lu[Agent.fallback]
		end

	elseif type (key) == 'function' then

		if Agent.lookup_rl[key] then
			return Agent.lookup_lu [Agent.lookup_rl[key]]
		else
			return Agent.lookup[Agent.safe.func]
		end

	else
		return Agent.lookup_rl[Agent.safe.func]
	end

end
setmetatable(Agent.lookup, mt.p)

return Agent