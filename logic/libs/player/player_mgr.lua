local skynet = require "skynet"
local log = require "log"
local retcode = require "logic.retcode"

local card_mgr = require "logic.libs.player.card_mgr"

local M = {}

function M:new()
	local object = {}
	setmetatable(object, { __index = self, })
	return object
end

function M:init(uid)
	local db = skynet.queryservice("db")
	local err, player_basic_info = skynet.call(db, "lua", "launch_player_basic_info", uid)
	if err ~= retcode.SUCCESS then
		log("Launch player(%d) basic info failed!", uid)
		return err
	end
	self.basic_info = player_basic_info

	local card_info = card_mgr:new()
	err = card_info:init(uid)
	if err ~= retcode.SUCCESS then
		log("Launch player(%d) card info failed!", uid)
		return err
	end
	self.card_info = card_info

	return retcode.SUCCESS
end

function M:save()
	
end

function M:get_basic_info()
	return self.basic_info
end

function M:get_cards()
	return self.card_info:get_cards()
end

function M:get_card_decks()
	return self.card_info:get_card_decks()
end

return M
