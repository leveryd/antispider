local config = require "config"
local util = require "util"


if config.enable ~= nil and config.enable==false then
    util.log(config.msg_inject_js_off)
    return
end


-- 获取当前响应数据
local chunk, eof = ngx.arg[1], ngx.arg[2]
util.debug(type(ngx.ctx.buffered))
util.debug(ngx.arg[2])

-- 定义全局变量，收集全部响应
if ngx.ctx.buffered == nil then
    ngx.ctx.buffered = {}
end
--util.debug(chunk)
-- 如果非最后一次响应，将当前响应赋值
if chunk ~= "" and not ngx.is_subrequest then
    util.debug("chunk")
    util.debug(chunk)
    table.insert(ngx.ctx.buffered, chunk)
    -- 将当前响应赋值为空，以修改后的内容作为最终响应
    ngx.arg[1] = nil
end

-- 如果为最后一次响应，对所有响应数据进行处理
if eof then
    -- 获取所有响应数据
    local whole = table.concat(ngx.ctx.buffered)
    util.debug(whole)
    ngx.ctx.buffered = nil

    util.debug(ngx.header.content_type)
    if(ngx.header.content_type=="text/html")
    then
        -- 进行你所需要进行的处理
        local script = "<script src=\""..config.js_url.."\" type=\"text/javascript\"></script>\n"
        local find_str = "</head>"  -- 要查找的内容
        whole = string.gsub(whole,find_str,script..find_str,1)
    end
    util.debug(whole)
    -- 重新赋值响应数据，以修改后的内容作为最终响应
    ngx.arg[1] = whole
end
