program mod_add_test
  use mod_add
  implicit none
  integer a
  a = add(1, 2)
  if (a /= 3) then
    print *, "Failed, 1 + 2 should be 3, but", a
    stop 1
  endif
  print *, "Succeeded"
end program mod_add_test
