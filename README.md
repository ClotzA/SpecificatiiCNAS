# Specificatii de interfatare cu serviciile PIAS - CNAS

http://siui.casan.ro/cnas/siui_3.7/specificatii

***
Adrese de access online la SIUI+SIPE+CEAS

* Productie SIUI – https://www.siui.ro
* Productie SIPE – https://sipe.siui.ro
* Productie UM-CEAS – <tcp://umceas.siui.ro:443> (adresa pentru eCard.SDK)
    * **(destinate furnizorilor de servicii medicale care au contract cu CNAS)**
    * Port 443: CertSign, DigiSign, TransSped - (port implicit)
    * Port 444: AlfaSign, CertDigital
* Testare SIUI – https://testsiui.siui.ro
* Testare SIPE – https://testsipe.siui.ro
* Testare UM-CEAS – <tcp://testumceas.siui.ro:443> (adresa pentru eCard.SDK)
    * **(destinate producătorilor de aplicaţii informatice de raportare pentru SIUI)**
    * Port 443: CertSign, DigiSign, TransSped - (port implicit)
    * Port 444: AlfaSign, CertDigital