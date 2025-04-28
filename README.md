# Oppaat

Tämä repositorio sisältää kirjoittamiani oppaita liittyen fysiikkaan ja erityisesti fysiikassa eteen tulevaan matematiikkaaan.
Oppaat on ensisijaisesti suunnattu yliopistotasolla fysiikkaa tai vastaavanlaista alaa opiskelevalle/opiskelleelle, mutta myös lukion pitkää
matematiikkaa opiskellut henkilö löytää todennäköisesti oppaista itselleen mielekästä sisältöä. Oppaiden rakenne ja aihealueet peilaavat
jossain määrin Helsingin Yliopiston fysiikan laitoksen kursseja, mm. Matemaattisia apuneuvoja (MApu I-III) sekä Fysiikan matemaattisia menetelmiä (FyMM I-II).
Oppaat ovat keskeneräisiä ja sisältävät varmasti virheitä, mutta toivon että niistä voisi olla tästä huolimatta hyötyä.

## Lukeminen

Oppaat löytyvät suoraan luettavina PDF-muodossa alihakemistosta `oppaat/`. Ohessa lista repositorion oppaista:

- Integrointiopas
- Johdoksia
- Satulapisteapproksimaatiot

## Ladonta

HUOM! Tämä osio olettaa, että sinulle on tuttua GNU/Linux -pohjaisen käyttöjärjestelmän komentorivin käyttäminen.

Mikäli haluat latoa oppaat itse, void kloonata repositorion omalle koneellesi ja luoda oppaat `src/[oppaan-nimi]/`-alihakemistosta
löytyvistä TeX-tiedostoista käyttäen haluamaasi menetelmää. Mikäli käytät GNU/Linux -pohjaista käyttöjärjestelmää ja tietokoneellasi on
[TeX Live](https://tug.org/texlive/) -jakelu, voit **esimerkiksi** luoda PDF:t seuraavasti:

1. Avaa komentorivi

2. Kloonaa repositorio haluamaasi paikkaan

2. Luo konfiguraatiotiedosto [Latexmk](https://www.cantab.net/users/johncollins/latexmk/)-ohjelmalle:

```sh
mkdir ~/.config/latexmk
```

```sh
asetukset="\$pdflatex = \"pdflatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1\";"
echo $asetukset > ~/.config/latexmk/latexmkrc
```

3. Luo PDF suorittamalla latexmk-ohjelma:

```sh
latexmk -pdf -output-directory=[haluamasi-hakemisto] [haluamasi-tex-tiedosto]
```

Esimerkiksi:

```sh
latexmk -pdf -output-directory=out Integrointiopas.tex
```

HUOM! Alihakemisto `out/` luodaan siihen hakemistoon, jossa komento suoritettiin. Mikäli haluat luoda hakemiston
jonnekin muualle, kirjoita hakemiston absoluuttinen polku, esim. `~/Documents/Integrointiopas/out` tai käytä suhteelista polkua,
esim. `../out` luodaksesi hakemiston nykyisen hakemiston yläpuolelle.

4. Nyt PDF löytyy hakemistosta [haluamasi-hakemisto], josta voit lukea sen käyttämällä haluamaasi PDF-lukuohjelmaa (esim. okular, evince tai xreader):


### Vaadittavat TeX-Paketit

Sinulla on oltavat seuraavat TeX-paketit asennettuna tietokoneellesi, mikäli haluat itse luoda PDF:t
(Jos tietokoneellasi TeX Live -jakelu, on sinulla mitä todennäköisimmin kaikki vaadittavat paketit):

### Tavalliset TeX-Paketit

- amsmath
- amssymb
- amsthm
- babel
- color
- fontenc
- geometry
- graphicx
- inputenc
- lastpage
- lmodern
- textcomp

### Erikoisemmat TeX-Paketit

- bigints
- cancel
- comment
- derivative
- diagbox
- esint
- listingsutf8
- physics

Lisätietoa kustakin edellämainitusta TeX-paketista saat esimerkiksi etsimällä paketin nimeä [CTAN](https://ctan.org/)-palvelusta.

## Avustaminen

(Tämä osio on kesken)

Avustaminen on tervetullutta ja mikäli korjauksesi/ehdotuksesi/lisäyksesi hyväksytään, saat halutessasi nimesi tämän tiedoston `Tekijät`-osioon

### Virheet ja puutteet

Mikäli löysit virheen tai puutteen jostakin oppaasta, tee siitä ilmoitus `Issues`-välilehdellä github:ssa.

### Lisäyksien tekeminen

Mikäli haluaisit tehdä lisäyksen johonkin oppaaseen, tee siitä Pull-request `Pull requests`-välilehdellä github:ssa.

## Tekijät

approx-error vuonna 2025
