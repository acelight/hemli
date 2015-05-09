--[[----------------------------------------------------------------------------
    The Hopefully EMergent LIfeform (HEMLI) Project

    Header.lua

]]------------------------------------------------------------------------------


    dofile 'helpers.lua'

    --~ require 'luarocks.loader'
    coxpcall    = require 'coxpcall'
    copas       = require 'copas'
    --~ concurrent  = require 'concurrent'
    --~ Fs          = require 'lfs'
    --~ Posix       = require 'posix'
    --~ curses      = require 'curses'
    --~ File        = require 'file'
    --~ Init        = require 'init'
    --~ Assign      = require 'assign'
    --~ Agent       = require 'agent'
    --~ World       = require 'world']]


    zmq         = require "lzmq"
    zmq.poller  = require "lzmq.poller"

    require     "zhelpers"

    --~ pt(zmq)
    --~ pt (zmq.poller)



    Env     = {}
    Hemlis  = {}

    Vars    = {} -- Variables set by a variety of functions for easier access, like is_day

    Config = {}

    Config.dimension = {
        ['x'] = 10,
		['y'] = 10,
    }

	Config.food_bounds = {
		0.4, 0.6, 0.8
	}

    Config.path       = '/home/curt/exe/src/lua/hemli_project/project/'
    Config.population = Config.path..'population/'
    Config.cemetary   = Config.path..'cemetary/'

    Config.randomseed = {}

    Config.randomseed.food = 0.4
    Config.randomseed.agent = 5         -- ? Ensures same value is generated every time

    Patterns = {
        ['hemli_stats'] = '(%x)_(%x%x%x%x)_(%x+)_(%x+)_(%x+)_(%x+)',
        ['hemli_id']    = '%x%x%x%x',
        ['hemli_gene']  = '(%x)(%x)(%x%x)(%x%x%x)(%x%x%x)(%x*)',
        ['hemli_f_w']   = '(%x)(%x%x)',
        ['hemli_weight']= '(%x%x%x)',
    }

--------------------------------------------------------------------------------
--/Global Variables
--------------------------------------------------------------------------------