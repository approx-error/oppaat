from collections.abc import Callable
import sk_saanto as sks
import sympy as sp
import subprocess

VIRHERAJA = 0.01
RAJAT = [(0.5, 1), (-1, -0.5), (-1, 1)]
KULMIOIDEN_LKM = 10000
ARVON_SIJAINTI = 0.5
x = sp.Symbol('x')

SYMPY_FUNKTIOT = {
    '1/x': 1/x, 'x': x, 'x^2': x**2, 'x^3': x**3,
    'sin': sp.sin(x), 'cos': sp.cos(x), 'tan': sp.tan(x),
    'sinh': sp.sinh(x), 'cosh': sp.cosh(x), 'tanh': sp.tanh(x),
    'exp': sp.exp(x), 'ln': sp.log(x)
}

def sympy_integraali(funktio: str, rajat: tuple[float]) -> float:
    sympy_funktio = SYMPY_FUNKTIOT[funktio]
    return sp.N(sp.integrate(sympy_funktio, (x, rajat[0], rajat[1])))

def sks_integraali(funktio: str, rajat: tuple[float]) -> float:
    sks_funktio = sks.FUNKTIOT[funktio]
    return sks.sk_saanto(sks_funktio, rajat, KULMIOIDEN_LKM, ARVON_SIJAINTI)

def testaa(funktio: str, rajat: tuple[float]) -> bool:
    sympy_epaonnistui = False
    sks_epaonnistui = False
    sympy_tulos = sympy_integraali(funktio, rajat)
    if sympy_tulos == sp.nan or sp.re(sympy_tulos) != sympy_tulos:
        sympy_epaonnistui = True
    sks_tulos = sks_integraali(funktio, rajat)
    if sks_tulos == -1:
        sks_epaonnistui = True

    try:
        absoluuttinen_virhe = abs(sympy_tulos - sks_tulos)
        suhteellinen_virhe = absoluuttinen_virhe / abs(sks_tulos)
    except ValueError:
        pass

    if sympy_epaonnistui:
        sympy_tulos = 'NaN'
        absoluuttinen_virhe = 'NaN'
        suhteellinen_virhe = 'NaN'
    if sks_epaonnistui:
        sks_tulos = 'NaN'
        absoluuttinen_virhe = 'NaN'
        suhteellinen_virhe = 'NaN'

    print(f'Funktio: {funktio}')
    print(f'Integroimisrajat: {rajat}')
    print(f'Sympy: {sympy_tulos}')
    print(f'Suorakaidesääntö: {sks_tulos}')
    print(f'Absoluuttinen virhe: {absoluuttinen_virhe}')
    print(f'Suhteellinen virhe: {suhteellinen_virhe}')
    if sympy_epaonnistui != sks_epaonnistui:
        return False
    elif sympy_epaonnistui and sks_epaonnistui:
        return True
    elif absoluuttinen_virhe <= VIRHERAJA and sympy_epaonnistui == sks_epaonnistui:
        return True
    else:
        return False 

if __name__ == '__main__':
    lapimenneet_testit = 0
    testien_lkm = len(sks.FUNKTIOT) * len(RAJAT)
    for j, rajat in enumerate(RAJAT):
        for i, funktio in enumerate(sks.FUNKTIOT):
            print(f'--- TESTI {j*len(sks.FUNKTIOT) + i + 1}/{testien_lkm} ---')
            if (testaa(funktio, rajat)):
                print('Testi läpi!')
                lapimenneet_testit += 1
            else:
                print('Testi epäonnistui!')

    if lapimenneet_testit == testien_lkm:
        print('Kaikki testit läpi!')
    else:
        print(f'{lapimenneet_testit}/{testien_lkm} testiä läpi')

