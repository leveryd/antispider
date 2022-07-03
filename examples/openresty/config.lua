local rsa_public_key = [[-----BEGIN RSA PUBLIC KEY-----
MEgCQQCBOrgNa/QBlI5IwMnEEjmZnLbLQ60oT4P4mCQVq85w0TUoTJOoVzYItgQi
Qkv6zMT8flq8lHjm420MqhWIIvIDAgMBAAE=
-----END RSA PUBLIC KEY-----]]

local rsa_private_key = [[-----BEGIN RSA PRIVATE KEY-----
MIIBOgIBAAJBAIE6uA1r9AGUjkjAycQSOZmctstDrShPg/iYJBWrznDRNShMk6hX
Ngi2BCJCS/rMxPx+WryUeObjbQyqFYgi8gMCAwEAAQJAImCWeauQG6ODPkNa6TfX
7s9LqUL1m1Wby9PdNY6guk3rQYoKzK5eKtjn4LTm25oH1bi8cfn5NPOgjt89F25c
EQIhANKDtiSzA0JzdXbMYUJ94txyzEtMloY/xeIXcpRKEXNNAiEAnSbYNmobYF+N
R58rfbf9JxDWl24Ep95YHA6uiJMYso8CIQCFO8MduwaHGhfv1i6ALLhWGXne9lwW
H2qYS4rC+5XLyQIgcIiqd3zQEdkawFj4udQREfJ62IFOEC+mBKF21hIPs30CIHtt
wbyhtx5w6KKc5nA3gAEclT00smFfPChwRkxSachA
-----END RSA PRIVATE KEY-----]]


local enable = true
local protected_api = "^/api/user"
local token_name = "KS-TOKEN"
local timestamp_gap = 5

local exit_status_code = 444
local forbidden_status_code = 403

local msg_no_encrypted_token = "can not find encrypted_token"
local msg_decrypted_token_fail = "can not decrypted token"
local msg_rsa_new_instance_fail = "can not new rsa instance"
local msg_protect_api_off = "'protect api' disable"
local msg_inject_js_off = "'inject js' disable"


-- init_html config
local js_url = "/js/final.js"

-- program config
local log_level = 1  -- INFO 1 DEBUG 2 ERROR 3

local _M = {}
_M.rsa_public_key = rsa_public_key
_M.rsa_private_key = rsa_private_key
_M.protected_api = protected_api
_M.token_name = token_name
_M.exit_status_code = exit_status_code
_M.forbidden_status_code = forbidden_status_code
_M.timestamp_gap = timestamp_gap
_M.msg_no_encrypted_token = msg_no_encrypted_token
_M.msg_decrypted_token_fail = msg_decrypted_token_fail
_M.msg_rsa_new_instance_fail = msg_rsa_new_instance_fail
_M.msg_protect_api_off = msg_protect_api_off
_M.msg_inject_js_off = msg_inject_js_off
_M.enable = enable

_M.js_url = js_url

_M.log_level = log_level

return _M