import urllib.request
import requests
import time

device = "Ug0NUvBF7oPIwp2COGr1"
Lat = -43.123456
Long = +145.654321
url = "http://retrorbit.spdns.de/get_Data.php"

while True:

    Lat = round(Lat,6)
    Long = round(Long,6)

    print("Daten "+str(Lat)+" und "+str(Long)+" werden an "+url+" gesendet!")
    payload = {'device':device, 'Latitude':Lat, 'Longitude':Long}
    print(payload)
    r = requests.post(url, payload)

    time.sleep(5)   # für 5 Sekunden warten

    Lat += 1
    Long -= 1
