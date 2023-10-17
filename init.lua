 -- Set our preferred options
 require("core.options")
  
 -- Get and active our keymaps
 local keymaps = require("core.keymaps")
 keymaps.init()
 keymaps.plugins()
  
 require("core.lazy") -- Setup Lazy plugin manager
 require("core.colorscheme") -- Set colorscheme
