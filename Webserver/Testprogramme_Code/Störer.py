import urllib.request
import requests
import time

wert = 9999

url = "http://retrorbit.spdns.de/get_Data.php"

while True:
    time.sleep(1)   # für 1 Sekunden warten

    print("Stördaten "+str(wert)+" werden an "+url+" gesendet!")
    #payload = {'Latitude':wert, 'Longitude':wert}
    r = requests.post(url, {'wert ':wert})

    wert -= 1