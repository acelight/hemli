--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    Dna.lua
------------------------------------------------------------------------------]]

local Dna = {}

    function Dna:make_proto_neurone (gene)

        local layer, f, t, i, b, weights = string.match (gene, Patterns['hemli_gene'])

        return tonumber ('0x'..layer), {
            ['f'] = tonumber ('0x'..f),
            ['t'] = tonumber ('0x'..t),
            ['i'] = Dna:conv_dna_neu_val (i),
            ['b'] = Dna:conv_dna_neu_val (b),
            ['w'] = Dna:make_w_array (weights),
        }
    end

    function Dna:conv_dna_neu_val (w_exp)

        local flag, value = string.match (w_exp, Patterns['hemli_f_w'])
        value = tonumber ('0x'..value)

        if flag == '0' then
            return value

        elseif flag == '1' then
            return -1 * value

        elseif flag == '2' then
            return 0.5 + value

        elseif flag == '3' then
            return 0.5 + (-1 * value)

        end
    end

    function Dna:make_w_array (weights)

        local array = {}

        for w_exp in string.gmatch (weights, Patterns['hemli_weight']) do
            array [ #array+1 ] = Dna:conv_dna_neu_val (w_exp)
        end

        return array
    end

return Dna

