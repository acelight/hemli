--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    File.lua
------------------------------------------------------------------------------]]

local File = {}

    --~ function File:read (filename, amount)
    function File:readb (filename, amount)

        local file = assert (io.open (filename, 'r')):read(amount)

        if not file then
            print (filename.." - Could not be read. Error")
            os.exit ()
        else
            return file
        end

    end

return File