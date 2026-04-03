-- playerlist.lua
-- Redireciona para perfil Steam no Player List

if _G.SPR_LOADED then return end
_G.SPR_LOADED = true

local function open_steam_profile_direct(steam_id64)
    if not steam_id64 or tostring(steam_id64):len() < 10 then
        return false
    end
    
    steam_id64 = tostring(steam_id64)
    
    if SystemInfo:platform() ~= Idstring("WIN32") then
        return false
    end
    
    if not (MenuCallbackHandler and MenuCallbackHandler.is_overlay_enabled and MenuCallbackHandler:is_overlay_enabled()) then
        return false
    end

    Steam:overlay_activate("url", "https://steamcommunity.com/profiles/" .. steam_id64 .. "/")
    return true
end

if MenuCallbackHandler then
    for method_name, method_func in pairs(MenuCallbackHandler) do
        if type(method_name) == "string" and 
           type(method_func) == "function" and 
           string.find(method_name:lower(), "fbi") then
            
            local original = method_func
            
            MenuCallbackHandler[method_name] = function(self, item, node, ...)
                local steamid = nil
                
                if type(item) == "table" and item.parameters and type(item.parameters) == "function" then
                    local ok, params = pcall(function() return item:parameters() end)
                    if ok and params and params.name and params.name:match("^%d+$") then
                        steamid = params.name
                    end
                end
                
                if steamid then
                    open_steam_profile_direct(steamid)
                    return
                end
                
                return original(self, item, node, ...)
            end
        end
    end
end