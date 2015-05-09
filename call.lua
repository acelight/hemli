--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    call.lua
    Implements a "call vector" system
    Each function that needs to become an agent or service needs to be called here
    This is so the system can recruit and allocate it an id

    Pns:enrole_func (table, 'table name', entry)
        Entry is optional, allows the call to always be that position in the queue
        Due to the random number generator producing a fixed sample, should always be given the same ID

        Table should be {data={}, procedure={}}
        This then allows the generic agent framework to be used
------------------------------------------------------------------------------]]

    Agent:Enrole ({{1,2,3},(function () return 0 end)}, 'World.food')
    Agent:Enrole ({{1,2,3},(function () return 0 end)}, 'World.is_day')
    Agent:Enrole ({{1,2,3},(function () return 0 end)}, 'World.is_raining')
