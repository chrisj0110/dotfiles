vim.filetype.add({
  extension = {
    log = "log",
  },
})

require("config.lazy")
require("config.set")
require("config.remap")
