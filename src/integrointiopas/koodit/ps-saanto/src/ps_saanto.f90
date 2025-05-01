program pss
  use lajimaareet
  use funktiot

  implicit none

  real (kind = rk16) :: tulos
  tulos = ps_saanto(x_toiseen, 0.0_rk16, 1.0_rk16, 100_ik16, 0.0_rk16)
  
  print '(a,1x,f10.8)', 'Tulos:', tulos


  
end program pss
  
