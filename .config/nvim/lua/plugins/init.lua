local function loadPlugins(dir)
  local lsDir = '$HOME/.config/nvim/lua/plugins/' .. dir
  local plugins = {}

  for file in io.popen('ls ' .. lsDir):lines() do
    if file:match '%.lua$' then
      local pluginName = file:match '^(.-)%.lua$'
      if pluginName == 'init' then
        goto continue
      elseif pluginName == 'lazy' then
        goto continue
      end

      local pluginPath = 'plugins.' .. dir .. '.' .. pluginName
      local success, plugin = pcall(require, pluginPath)

      if success then
        table.insert(plugins, plugin)
      else
        print('Failed to load plugin:', pluginPath)
      end
    end
    ::continue::
  end
  return plugins
end

local plugins = {}
table.insert(plugins, (loadPlugins ''))
table.insert(plugins, (require 'plugins.other'))

return plugins
