




local timer = require("daylight.timer")












local daylight = {}






local configuration = {
   day = {
      name = vim.g.colors_name,
      time = 8,
   },
   night = {
      name = vim.g.colors_name,
      time = 18,
   },
   interval = 60000,
}
local current_timer = nil

local function change_colorscheme()
   local current_colorscheme = vim.g.colors_name

   local ctime = os.date("*t")
   local current_background = vim.o.background
   if os.date("*t").hour <= configuration.night.time and ctime.hour >= configuration.day.time then
      if current_background ~= "light" then
         vim.notify("[daylight.nvim] Changing background to 'light' ...")
      end
      vim.opt.background = "light"
      if current_colorscheme ~= configuration.day.name then
         vim.cmd("colorscheme " .. configuration.day.name)
      end
   else
      if current_background ~= "dark" then
         vim.notify("[daylight.nvim] Changing background to 'dark' ...")
      end
      vim.opt.background = "dark"
      if current_colorscheme ~= configuration.night.name then
         vim.cmd("colorscheme " .. configuration.night.name)
      end
   end
end

daylight.start = function()

   change_colorscheme()

   if current_timer ~= nil then
      vim.notify("[daylight.nvim] There is already a timer set!", vim.log.levels.ERROR)
      return
   end

   current_timer = timer.init(configuration.interval, change_colorscheme)
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

daylight.setup = function(user_config)
   if user_config == nil then
      user_config = configuration
   end
   configuration = vim.tbl_deep_extend("force", configuration, user_config)


   daylight.start()


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
