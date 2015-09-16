program mod_multiple_test
  use mod_multiple
  implicit none
  integer a
  a = multiple(1, 2)
  if (a /= 2) then
    print *, "Failed, 1 * 2 should be 2, but", a
    stop 1
  endif
end program mod_multiple_test
