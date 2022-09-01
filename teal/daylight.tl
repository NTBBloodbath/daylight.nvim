-- ┌                                                          ┐
-- │  Copyright (c) 2022 NTBBloodbath. All rights reserved.   │
-- │  Use of this source code is governed by a GPL3 license   │
-- │          that can be found in the LICENSE file.          │
-- └                                                          ┘
local timer = require("daylight.timer")

local record theme
  name: string
  time: number
end

local record config
  day: theme
  night: theme
  interval: number
end

local record daylight
  setup: function(user_config: config)
  start: function()
  stop: function()
  toggle: function()
end

local configuration = {
  day = {
    name = vim.g.colors_name,
    time = 8,
  },
  night = {
    name = vim.g.colors_name,
    time = 18,
  },
  interval = 60000, -- 1m
} as config
local current_timer: vim.loop.Timer = nil

daylight.start = function()
  if current_timer == nil then
    vim.notify("[daylight.nvim] There is already a timer set!", vim.log.levels.ERROR)
    return
  end

  current_timer = timer.init(configuration.interval, function()
    local ctime = os.date("*t")
    local current_colorscheme = vim.g.colors_name

    if (os.date("*t").hour <= configuration.night.time) and (ctime.hour >= configuration.day.time) then
      vim.opt.background = "light"
      if current_colorscheme ~= configuration.day.name then
        vim.cmd("colorscheme " .. configuration.day.name)
      end
    else
      vim.opt.background = "dark"
      if current_colorscheme ~= configuration.night.name then
        vim.cmd("colorscheme " .. configuration.night.name)
      end
    end
  end)
end

daylight.stop = function()
  if current_timer == nil then
    vim.notify("[daylight.nvim] There is no timer to be stopped!", vim.log.levels.ERROR)
    return
  end

  timer.deinit(current_timer)
  current_timer = nil
end

daylight.toggle = function()
  if current_timer == nil then
    daylight.start()
  else
    daylight.stop()
  end
end

daylight.setup = function(user_config: config)
  if user_config == nil then
    user_config = configuration
  end
  configuration = vim.tbl_deep_extend("force", configuration as table, user_config as table) as config

  if current_timer == nil then
    current_timer = timer.init(configuration.interval, function()
      local ctime = os.date("*t")
      local current_colorscheme = vim.g.colors_name

      if (os.date("*t").hour <= 18) and (ctime.hour >= 8) then
        if current_colorscheme ~= configuration.day.name then
          vim.cmd("colorscheme " .. configuration.day.name)
        end
        vim.opt.background = "light"
      else
        if current_colorscheme ~= configuration.night.name then
          vim.cmd("colorscheme " .. configuration.night.name)
        end
        vim.opt.background = "dark"
      end
    end)
  end

  vim.api.nvim_create_user_command("DaylightStart", daylight.start, {
    desc = "Start daylight.nvim timer",
  })
  vim.api.nvim_create_user_command("DaylightStop", daylight.stop, {
    desc = "Stop daylight.nvim timer",
  })
  vim.api.nvim_create_user_command("DaylightToggle", daylight.toggle, {
    desc = "Toggle daylight.nvim",
  })
end

return daylight