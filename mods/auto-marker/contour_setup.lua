_G.AutoMarker = _G.AutoMarker or {}

-- Register a custom contour type for marking civilians with a distinct color.
-- This hook runs after lib/units/contourext is loaded so ContourExt._types is available.
if ContourExt and ContourExt._types and not ContourExt._types.mark_civilian then
    if ContourExt._types.mark_enemy then
        -- Shallow-copy the mark_enemy entry so we inherit any required fields.
        local t = {}
        for k, v in pairs(ContourExt._types.mark_enemy) do
            t[k] = v
        end
        t.color = Color(1, 1, 0)  -- Yellow to distinguish civilians from hostiles
        ContourExt._types.mark_civilian = t
    else
        -- Fallback: create a minimal civilian contour entry.
        ContourExt._types.mark_civilian = { color = Color(1, 1, 0) }
    end
end
