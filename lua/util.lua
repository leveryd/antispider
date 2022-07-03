local config = require "config"
local resty_rsa = require "resty.rsa"


local _M = {}


function log(msg)
    ngx.log(2, msg)
end

function debug(msg)
    if config.log_level >= 2 then
        log(msg)
    end
end

function decodeURI(s)
    s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    return s
end

function _M.log(msg)
    log(msg)
end

function _M.debug(msg)
    debug(msg)
end

function _M.get_encrypted_token()
    local headers = ngx.req.get_headers()
    local encrypted_token

    local token_not_in_header = (headers[config.token_name] == nil)

    if(token_not_in_header)
    then
        args = ngx.req.get_uri_args()
        if(args[config.token_name] == nil)
        then
            encrypted_token = nil
        else
            encrypted_token = args[config.token_name]
        end
    else
        encrypted_token = headers[config.token_name]
    end

    if encrypted_token == nil then
        debug(config.token_name)
        debug(headers[config.token_name])
        debug(ngx.req.get_uri_args()[config.token_name])
    end

    return encrypted_token
end

function _M.get_decrypted_token(encrypted_token)
    local priv, err = resty_rsa:new({private_key = config.rsa_private_key, key_type = resty_rsa.KEY_TYPE.PKCS1})
    if not priv then
        debug(err)
        log(config.msg_rsa_new_instance_fail)
        return nil
    end
    if not (err == nil) then
        debug(err)
        log(config.msg_rsa_new_instance_fail)
        return nil
    end

    local decrypted_token, err = priv:decrypt(ngx.decode_base64(decodeURI(encrypted_token)))
    if not decrypted_token then
        return nil
    end

    if not (err == nil) then
        debug(err)
        return nil
    end
    return decrypted_token
end

function _M.extract_user_flag(decrypted_token)
    local b = tonumber(string.sub(decrypted_token,6,6))
    return b
end

function _M.extract_timestamp(decrypted_token)
    local t = tonumber(string.sub(decrypted_token,13,-3))
    return t
end

return _M