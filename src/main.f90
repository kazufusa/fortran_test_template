program main
  use mod_add
  use mod_multiple
  implicit none

  print '("1 + 2 =", i2)', add(1, 2)
  print '("1 * 2 =", i2)', multiple(1, 2)

end program main
