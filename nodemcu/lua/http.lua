dofile('httpServer.lua')
-------------
-- http
------------
function setupHttp()
    if wifi.getmode()==wifi.STATION then
        httpServer.listen(80)
    end
end
-------------
-- route
------------
httpServer:use('/scanap', function(req, res)
    wifi.sta.getap(function(table)
        local aptable = {}
        for ssid,v in pairs(table) do
            local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
            aptable[ssid] = {
                authmode = authmode,
                rssi = rssi,
                bssid = bssid,
                channel = channel
            }
        end
        res:type('application/json')
        res:send(cjson.encode(aptable))
    end)
end)
-------------
httpServer:use('/config', function(req, res)
    if req.query.ssid ~= nil and req.query.pwd ~= nil then
        wifi.sta.config(req.query.ssid, req.query.pwd)

        status = 'STA_CONNECTING'
        tmr.alarm(TMR_WIFI, 1000, tmr.ALARM_AUTO, function()
            if status ~= 'STA_CONNECTING' then
                res:type('application/json')
                res:send('{"status":"' .. status .. '"}')
                tmr.stop(TMR_WIFI)
            end
        end)
    end
end)
-------------