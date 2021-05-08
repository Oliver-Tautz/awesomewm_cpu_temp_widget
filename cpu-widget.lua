-- cpu widget

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local low_temp = 50
local high_temp = 85


local cpu_widget = {}
local function worker(args)
    local args = args or {}

    local low_temp = args.low_temp or low_temp
    local high_temp = args.high_temo or high_temp

    cpu_widget = awful.widget.watch('bash -c "sensors | grep Core\\ 0 | cut -c16-17"', 1,function(widget,stdout)
    temp = tonumber(stdout)
    if temp < low_temp then 
        widget.markup='<span color="blue">'.. stdout ..  '</span>'
    elseif temp < high_temp then
        widget.markup='<span color="yellow">'.. stdout ..  '</span>'
    else 
        widget.markup='<span color="red">'.. stdout ..  '</span>'

    end
end
)
    
    return cpu_widget
end

return setmetatable(cpu_widget, { __call = function(_, ...)
    return worker(...)
end })
