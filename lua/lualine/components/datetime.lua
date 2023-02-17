-- Copyright (c) 2023 Willothy
-- MIT license, see LICENSE for more details.
local lualine_require = require('lualine_require')
local M = lualine_require.require('lualine.component'):extend()

local default_options = {
    -- default, us, uk, iso, or format (ex. "%d/%m/%Y ...")
    style = 'default',
    trim_hour_leading_zero = true,
}

function M:init(options)
    M.super.init(self, options)
    self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
end

function M:update_status()
    local fmt = self.options.style
    if self.options.style == 'default' then
        fmt = '%A, %B %d | %H:%M'
    elseif self.options.style == 'us' then
        fmt = '%m/%d/%Y'
    elseif self.options.style == 'uk' then
        fmt = '%d/%m/%Y'
    elseif self.options.style == 'iso' then
        fmt = '%Y-%m-%d'
    end


    if self.options.trim_leading_zeroes then
        fmt = fmt:gsub('%%H', os.date('%H'):gsub("0(%d)", "%1"))
        fmt = fmt:gsub('%%I', os.date('%I'):gsub("0(%d)", "%1"))
    end

    local date = os.date(fmt)

    return date
end

return M
