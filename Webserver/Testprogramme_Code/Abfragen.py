import urllib.request
import requests
import time
import json

url2 = "http://retrorbit.spdns.de/provide_Data.php"

while True:
    print("Aktuelle Daten werden abgefragt...")
    r2 = requests.get(url2)
    print(r2.json())

    time.sleep(2)   # für 2 Sekunden warten
