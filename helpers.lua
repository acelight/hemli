
    function p_err (func, problem, extra, rectify, kill)
        print '----------------------------------------'
        print '--            HEMLI  ERROR            --'
        print '----------------------------------------'
        print ('Error : '..func)
        print ('Reason: '..problem)
        if extra then
            print (extra)
        end
        print (rectify)
        print '----------------------------------------'


        if kill then
        print 'Quitting'
            os.exit (1)
        end

    end

    function pt (t, tc)

        if not tc then tc = 1 end
        tc = tc + 1

        print ''
        for index, value in pairs (t) do

            index = tostring(index)
            io.write (string.rep (' ', tc).. index )

            if type (value) == 'table' then
                io.write ':\n'
                pt (value, tc)

            else
                --~ io.write ('\t'..value..'\n')
                print ('\t\t', value)

            end

        end

    end

    function printf (fmt, ...)
        return print (string.format (fmt, ...))
    end

    -- To display Lua errors, we must close curses to return to
    -- normal terminal mode, and then write the error to stdout.
    function err (err)
        curses.endwin ()
        print "Caught an error:"
        print (debug.traceback (err, 2))
        os.exit (2)
    end
