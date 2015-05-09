--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    Init.lua
------------------------------------------------------------------------------]]

local Init = {}

    function Init:hemli ()

        io.write ' Hemlis:\t'

        local population = LoadPopulation ()

        pt (population)

        local hemlis = {}

        for _, citizen in ipairs (population) do

            --~ io.popen ('lua '..Config.path..'hemli/actor.lua '..citizen)
            --~ io.popen ('lua actor.lua '..citizen)
            os.execute ('urxvt -e lua actor.lua '..citizen..' &')

        end

        print 'Done'
        return hemlis

    end

    function Init:world ()

        io.write ' World: \t'

        local env = World:create ()

        print 'Done'
        return env
    end

    function Init:agents ()

        io.write ' Agents:\t'

        Agent:Enrole ({{},{}}, 'fallback')

        local reg = Agent:MakeRegister ()

        print 'Done'
        return reg

    end

    function LoadPopulation (id)

        local population = {}
        -- Default serach pattern
        local match_pattern = id and id or Patterns['hemli_id']

        if not id then

            for citizen in Fs.dir (Config.population) do

                if citizen == string.match (citizen, match_pattern) then
                    population [ #population+1 ] = citizen
                end

            end
        else

            if posix.stat (match_pattern) then
                population [1] = match_pattern
            end

        end

        return population
    end

return Init