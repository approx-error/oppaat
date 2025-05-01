module funktiot
  use lajimaareet

  implicit none

  contains

  integer (kind = ik16) function pyorista(x, tarkkuus)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (in) :: tarkkuus
    pyorista = nint(x * 10_ik16 ** tarkkuus) / 10_ik16 ** tarkkuus
    return
  end function pyorista

  real (kind = rk16) function yksi_per_x(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    if (pyorista(x, 3_ik16) == 0) then
      virhe = 1
      return
    else
      yksi_per_x = 1 / x
      virhe = 0
      return
    end if
  end function yksi_per_x

  real (kind = rk16) function pelkka_x(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    pelkka_x = x
    return
  end function pelkka_x

  real (kind = rk16) function x_toiseen(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    x_toiseen = x ** 2
    return
  end function x_toiseen

  real (kind = rk16) function x_kolmanteen(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    x_kolmanteen = x ** 3
    return
  end function x_kolmanteen

  real (kind = rk16) function sini(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    sini = sin(x)
    return
  end function sini

  real (kind = rk16) function kosini(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    kosini = cos(x)
    return
  end function kosini

  real (kind = rk16) function tangentti(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    real (kind = ik16) :: testattava 
    real (kind = rk16), parameter :: pii = 4.0_rk16 * atan(1.0_rk16)
    testattava = (2.0_rk16 / pii) * x
    if (modulo(int(testattava), 2) == 1) then
      virhe = 1
      return
    else
      virhe = 0
      tangentti = tan(x)
      return
    end if
  end function tangentti

  real (kind = rk16) function hyp_sini(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    hyp_sini = sinh(x)
    return
  end function hyp_sini

  real (kind = rk16) function hyp_kosini(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    hyp_kosini = cosh(x)
    return
  end function hyp_kosini

  real (kind = rk16) function hyp_tangentti(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    hyp_tangentti = tanh(x)
    return
  end function hyp_tangentti

  real (kind = rk16) function eksponentti(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    virhe = 0
    eksponentti = exp(x)
    return
  end function eksponentti

  real (kind = rk16) function logaritmi(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    if (x <= 0) then
      virhe = 1
      return
    else 
      virhe = 0
      logaritmi = log(x)
      return
    end if
  end function logaritmi

  real (kind = rk16) function ps_saanto(funktio, alaraja, ylaraja, valien_lkm, sijainti)
    real (kind = rk16), intent (in) :: alaraja, ylaraja, sijainti
    integer (kind = ik16), intent (in) :: valien_lkm
    interface ulk_funktio
      function funktio(x, virhe)
        use lajimaareet
        real (kind = rk16) funktio
        real (kind = rk16), intent (in) :: x
        integer (kind = ik16), intent (out) :: virhe
      end function funktio
    end interface ulk_funktio

    ! Funktion suoritusosa alkaa
    real (kind = rk16) :: tulos, suunnikkaan_leveys, tod_sijainti
    integer (kind = ik16) :: n, virhe
    ps_saanto = 0
    tod_sijainti = abs(sijainti - int(sijainti))
    suunnikkaan_leveys = abs(ylaraja - alaraja) / real(valien_lkm)
    ! Alku ja loppu
    ps_saanto = ps_saanto + (suunnikkaan_leveys / 2) * (funktio(alaraja, virhe) + funktio(ylaraja, virhe))
    ! Loput
    do n = 0, valien_lkm - 2
      tulos = funktio(alaraja + (n + tod_sijainti) * suunnikkaan_leveys, virhe)
      if (virhe == 1) then
        ps_saanto = -1
        return
      else
        ps_saanto = ps_saanto + tulos
      end if
    end do
    ps_saanto = ps_saanto * suunnikkaan_leveys
    return
  end function ps_saanto
end module funktiot
