module lajimaareet
  implicit none
  integer, parameter :: ik16 = selected_int_kind(19)
  integer, parameter :: rk16 = selected_real_kind(20, 100)
end module lajimaareet

module vakiot
  use lajimaareet

  implicit none

  real (kind = rk16), parameter :: pii = 4.0_rk16 * atan(1.0_rk16)
  
end module vakiot

module funktiot
  use lajimaareet
  use vakiot

  implicit none

  contains

  real (kind = rk16) function yksi_per_x(x, virhe)
    real (kind = rk16), intent (in) :: x
    integer (kind = ik16), intent (out) :: virhe
    if (round(x, 3) == 0) then
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
        implicit none
        real funktio
        real (kind = rk16), intent (in) :: x
        integer (kind = ik16), intent (out) :: virhe
      end function funktio
    end interface ulk_funktio

    ! Funktion suoritusosa alkaa
    real (kind = rk16) :: tulos
    integer (kind = ik16) :: virhe
    ps_saanto = 0
    sijainti = abs(sijainti - int(sijainti))
    real (kind = rk16) :: suunnikkaan_leveys = abs(ylaraja - alaraja) / real(valien_lkm)
    integer :: i
    ! Alku ja loppu
    ps_saanto += (suunnikkaan_leveys / 2) * (funktio(alaraja) + funktio(ylaraja))
    ! Loput
    do i = 0, valien_lkm - 2
      tulos = funktio(alaraja + (n + sijainti) * suunnikkaan_leveys, virhe)
      if (virhe == 1) then
        ps_saanto = -1
        return
      else
        ps_saanto += tulos
      end if
    end do

    return
  end function ps_saanto
end module funktiot


program pss
  use lajimaareet
  use funktiot

  implicit none

  real (kind = rk16) :: tulos = ps_saanto(x_toiseen, 0.0_rk16, 1.0_rk16, 100, 0.0_rk16)
  
  print '(a,x,f2.10)', 'Tulos:', tulos


  
end program pss
  
