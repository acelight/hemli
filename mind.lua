--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    Mind.lua
------------------------------------------------------------------------------]]

local Mind = {}

    function Mind:CreateMind (genes)

        -- Use the "genes" or information from the Hemli file to create the NN
        local network   = Mind:MakeNetwork (genes)
        local mind      = Mind:MakeMind (network)

        return mind

    end

    function Mind:MakeNetwork (genes)

        local neurones = {}

        for _, gene in ipairs (genes) do

            -- Process the raw gene string into a table which can be used
            -- Also provides the information to which layer the neurone
            -- Should be on
            local layer, proto_neurone = Dna:make_proto_neurone (gene)

            -- If the layer does not exist, then create it
            if not neurones[layer] then neurones[layer] = {} end

            -- Insert the neurone information into the layer
            neurones[layer][ #neurones[layer]+1 ] = MakeNeurone (proto_neurone)

        end

        return neurones

    end

    TransferFunctions = {

        -- Hard-return. Either 0 or 1
        [0] = function (value)
            if value < 0 then
                return 0
            else
                return 1
            end
        end,

        -- log-sigmoid value
        [1] = function (value)
            return ( 1 / ( 1 + math.exp ( ( -1 * value ) ) ) )
        end,

        -- Returns based on a sigmoid curve
        [2] = function (value)
            return ( math.sin (value) )
        end,

    }

    --~ function Mind:MakeNeurone (proto_neurone)
    function MakeNeurone (proto_neurone)

        local neurone = {
            ['i']           = proto_neurone.i,
            ['b']           = proto_neurone.b,
            ['weights']     = proto_neurone.w,
        }

        if proto_neurone.f == 0 then
            neurone.transfer = TransferFunctions [proto_neurone.t]

        else
            neurone.transfer = function (value, hemli)
                -- concurrent.send (tonumber('t'), hemli, value)
                -- local result = concurrent.recieve ()
                -- if result then return result end
            end
        end

        function neurone:summate (input)

            local sum = 0
            for i = 1, #self.weights do
                local input_i = input[i] and input[i] or 0
                sum = sum + (input_i * self.weights[i])
            end
            sum = sum + (self.i * self.b)

            return sum

        end

        function neurone:eval (input, hemli)
            return self.transfer ( self:summate (input), hemli )
        end

        return neurone

    end

    function Mind:MakeMind (f_neurones)

        local mind = {}
        mind.neurones = f_neurones
        mind.vectors = {}

        function mind:eval (input)

            mind.vectors = {}
            mind.vectors[0] = input

            for layer = 1, #self.neurones do

                mind.vectors[layer] = {}

                for node = 1, #self.neurones[layer] do

                    mind.vectors[layer][node] = self.neurones[layer][node]:eval (mind.vectors[layer-1])

                end

            end

            return mind.vectors[#mind.vectors] -- Should output the last vector

        end

        return mind

    end


return Mind