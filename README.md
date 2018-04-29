NodeMCU_Mqtt
===========================================

Tento projekt je vytvorený pre záznam udajov z cidla DHT22 a odsielanie tychto udajov cez Wifi pripojenie na mqtt server.
V sucasnej dobe bude tento projekt implementovany do rozsiahlejšieho projektu domacej automatizácie.
Projekt je vytvoreny pre NodeMCU(ESP8266) a napisany v jazyku LUA.



# Contents
- poziadavky
  - [Nahranie firmweru](#nahranie-firmweru)
  - [Lua Uploader](#nahranie-suborov)
- [Dokumentacia](Dokumantacia)


### nahranie firmweru

Pre spravnu cinnost NodeMcu je treba nahrat do NodeMcu firmware, ktory si vytvorite alebo stiahnete.

Pre spravnu cinnost musi firmware obsahovat moduly:
Wifi,DHT,Timer,MQTT,GPIO a dalsie standardne moduly

Tento modul musi byt Integer nie floating !!!

hotovy Floating modul Najdete v zlozke [/bin](https://github.com/bohyzeke/NodeMCU_Mqtt/tree/master/bin)

Alebo si mozete vytvorit novy na stranke [Node-build](https://nodemcu-build.com/)

ako dalsie je potrebne firmware nahrat do NodeMCU na toto potrebujete [nodemcu Flasher](https://github.com/nodemcu/nodemcu-flasher)

na tejto stranke najdete aj postup ako firmvare nahrat do NodeMcu

### nahranie suborov

Pre nahranie suborov pouzivam program [ESPLorer](https://esp8266.ru/esplorer/#download).

Vserky potrebne subory najdete v zlozke [/lua](https://github.com/bohyzeke/NodeMCU_Mqtt/tree/master/lua).
