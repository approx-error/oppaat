from collections.abc import Callable
import math
import sys

def yksi_per_x(x: float) -> float:
    if round(x, 3) == 0:
        raise ValueError
        return -1
    else:
        return 1/x

def pelkka_x(x: float) -> float:
    return x

def x_toiseen(x: float) -> float:
    return x ** 2

def x_kolmanteen(x: float) -> float:
    return x ** 3

FUNKTIOT = {
    '1/x': yksi_per_x, 'x': pelkka_x, 'x^2': x_toiseen, 'x^3': x_kolmanteen,
    'sin': math.sin, 'cos': math.cos, 'tan': math.tan,
    'sinh': math.sinh, 'cosh': math.cosh, 'tanh': math.tanh, 
    'exp': math.exp, 'ln': math.log
}

def argumentit(argv: list[str]) -> (Callable, tuple[float], int, float):
    if len(argv) != 6:
        print('Käyttö: python3 sk-saanto <funktio> <alaraja> <ylaraja> <kulmioiden lkm> <arvon sijainti>')
        print('Tunnistetut funktiot: 1/x, x, x^2, x^3, sin, cos, tan, sinh, cosh, tanh, exp, ln')
        print('<arvon sijainti> tulkitaan lukuna väliltä [0, 1]')
        return 0, 0, 0, 0

    if argv[1] not in FUNKTIOT:
        print(f'Funktiota \'{argv[1]}\' ei tunnistettu')
        print('Tunnistetut funktiot: 1/x, x, x^2, x^3, sin, cos, tan, sinh, cosh, tanh, exp, ln')
        return 0, 0, 0, 0

    try:
        alaraja = float(argv[2])
        ylaraja = float(argv[3])
        kulmioiden_lkm = int(argv[4])
        arvon_sijainti = float(argv[5])
    except ValueError:
        print('Alarajan, ylärajan, kulmioiden lukumäärän ja arvon sijainnin on oltava numeroita')
        return 0, 0, 0, 0

    return FUNKTIOT[argv[1]], (alaraja, ylaraja), kulmioiden_lkm, arvon_sijainti

def sk_saanto(funktio: Callable, lukuvali: tuple[float], kulmioiden_lkm: int, sijainti: float) -> float:
    '''
    Laskee funktion [funktio] integraalin numeerisesti välillä [lukuväli] käyttäen suorakaidesääntöä.
    Suorakulmioiden lukumäärää säädellään kokonaislukumuuttujalla [kulmioiden_lkm] ja kohtaa,
    jossa funktion arvo lasketaan kullakin välillä säädellään liukulukumuuttujalla [sijainti].
    HUOM! Sijainti on aina välillä [0, 1], jossa 0 on välin vasen reuna ja 1 välin oikea reuna.
    '''
    summa = 0
    # Tulkitaan sijainti lukunä väliltä [0, 1]
    sijainti = abs(sijainti - int(sijainti))
    kulmion_leveys = abs(lukuvali[1] - lukuvali[0]) / kulmioiden_lkm
    for n in range(kulmioiden_lkm):
        try:
            summa += kulmion_leveys * funktio(lukuvali[0] + (n + sijainti) * kulmion_leveys)
        except ValueError:
            return -1

    return summa

if __name__ == '__main__':
    funktio, lukuvali, kulmioiden_lkm, arvon_sijainti = argumentit(sys.argv)
    if funktio != 0:
        tulos = sk_saanto(funktio, lukuvali, kulmioiden_lkm, arvon_sijainti)
        if tulos != -1:
            print(f'Tulos: {tulos}')
        else:
            print(f'Funktiolla \'{funktio}\' on lukuvälillä [{lukuvali[0]}, {lukuvali[1]}] piste, jossa se ei ole määritelty')







