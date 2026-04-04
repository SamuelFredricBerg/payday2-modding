_G.AutoMarker = _G.AutoMarker or {}
if not AutoMarker.Settings then
    AutoMarker.Settings = { enabled = true }
end


function isGameOnlineOrHost()
    if game_state_machine and game_state_machine:current_state_name() then
        local state = game_state_machine:current_state_name()
        return state == "ingame_standard" or state == "menu_main"
    end
    return false
end


if LuaNetworking:IsMultiplayer() and LuaNetworking:IsClient() then return end

-- if LuaNetworking:IsHost() then
--     if managers and managers.achievment then
--         return --managers.achievment:set_achievements_disabled(true)
--     end
-- end


AutoMarker.initial_range = 15000
AutoMarker.followup_range = 8000
AutoMarker.mark_duration = 60
AutoMarker.update_interval = 5


local function is_in_game()
    return game_state_machine and game_state_machine:current_state_name() == "ingame_standard"
end


Hooks:PostHook(GroupAIStateBase, "update", "AutoMarker_Update", function(self)

    if not AutoMarker.Settings.enabled then
        return
    end

    if not is_in_game() or not managers.network:session() or not managers.network:session():are_peers_done_streaming() then
        return
    end

    local t = managers.player:player_timer():time()
    if AutoMarker._last_update_t and (t - AutoMarker._last_update_t) < AutoMarker.update_interval then
        return
    end
    AutoMarker._last_update_t = t


    local player_unit = managers.player:player_unit()
    if not player_unit or not alive(player_unit) then
        return
    end

    local player_position = player_unit:position()


    for u_key, u_data in pairs(managers.enemy:all_enemies()) do
        local unit = u_data.unit
        if unit and alive(unit) then
            local unit_position = unit:position()
            local distance = mvector3.distance(player_position, unit_position)

            if distance <= AutoMarker.initial_range and not unit:base().is_civilian then

                unit:contour():add("mark_enemy", true, AutoMarker.mark_duration)

                AutoMarker:mark_nearby_enemies(unit, self)
            end
        end
    end
end)


function AutoMarker:mark_nearby_enemies(marked_unit, state_base)
    local marked_position = marked_unit:position()


    for u_key, u_data in pairs(state_base._police) do
        local unit = u_data.unit
        if unit and alive(unit) then
            local unit_position = unit:position()
            local distance = mvector3.distance(marked_position, unit_position)

            if distance <= AutoMarker.followup_range and not unit:base().is_civilian then

                unit:contour():add("mark_enemy", true, AutoMarker.mark_duration)
            end
        end
    end
end


if managers.job and managers.job:current_level_id() then

end
