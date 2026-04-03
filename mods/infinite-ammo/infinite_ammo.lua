infammo = not (infammo or false)
if managers.hud then managers.hud:show_hint( { text = string.format("INFINITE AMMO (%s)", infammo and "ON" or "OFF"), time = 3 }) end
 
if not _PlayerManager_upgrade_value then _PlayerManager_upgrade_value = PlayerManager.upgrade_value end 
function PlayerManager:upgrade_value( category, upgrade, default ) 
    if upgrade == "consume_no_ammo_chance" then return 1 end
    return _PlayerManager_upgrade_value(self, category, upgrade, default)
end
 
if not _PlayerManager_has_category_upgrade then _PlayerManager_has_category_upgrade = PlayerManager.has_category_upgrade end
function PlayerManager:has_category_upgrade( category, upgrade, default ) 
    if upgrade == "consume_no_ammo_chance" then return infammo end
    return _PlayerManager_has_category_upgrade(self, category, upgrade, default) 
end