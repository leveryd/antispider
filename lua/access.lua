local config = require "config"
local util = require "util"


if config.enable ~= nil and config.enable==false then
    util.log(config.msg_protect_api_off)
    return
end

local request_uri = ngx.var.request_uri
local uri_match_flag = string.match(request_uri, config.protected_api)

util.debug(request_uri)
util.debug(config.protected_api)
util.debug(uri_match_flag == nil)

if(uri_match_flag == nil)
then
    return
end


local encrypted_token = util.get_encrypted_token()

util.debug(encrypted_token)

if encrypted_token == nil then
    util.log(config.msg_no_encrypted_token)
    ngx.exit(config.exit_status_code)
end


local decrypted_token = util.get_decrypted_token(encrypted_token)

if decrypted_token == nil then
    util.log(config.msg_decrypted_token_fail)
    ngx.exit(config.exit_status_code)
end


local b = util.extract_user_flag(decrypted_token)
local t = util.extract_timestamp(decrypted_token)

util.debug(b)

if b == 1 then
    ngx.exit(config.forbidden_status_code)
else
    ngx.update_time()
    local timeStamp = ngx.time()
    util.log(timeStamp)
    if(timeStamp - t > config.timestamp_gap)
    then
        ngx.exit(config.forbidden_status_code)
    end
end
