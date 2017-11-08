local cmd = require "proto.cmd"
--local log = require "log"

local function execute_f(req, resp_f)
	local player = req.player
	local card_set = player:get_card_set()

	local c2s_gm_get_card = req.args
	local card_id = c2s_gm_get_card.id
	local amount = c2s_gm_get_card.amount

	local s2c_gm_get_card = {
		code = 0,
	}
	local flag = card_set:is_exist(card_id)
	if flag == false then
		card_set:unlock_card(card_id)
	end
	card_set:add_card(card_id, amount)

	resp_f(s2c_gm_get_card)
end

return {
    cmd = cmd.GM_GET_CARD, 
    handler = execute_f,
	protoname = "protocol.c2s_gm_get_card",
	resp_protoname = "protocol.s2c_gm_get_card",
}
