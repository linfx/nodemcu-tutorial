import network

sta_if = network.WLAN(network.STA_IF)
sta_if.active(True)
sta_if.connect("LIN_NetWork", "1372708818700")
sta_if.isconnected()                      # Check for successful connection
