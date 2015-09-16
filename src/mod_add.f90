module mod_add
  implicit none
  public add
  private

  contains
  integer function add(a, b)
    implicit none
    integer, intent(in)  :: a, b
    add = a + b
  end function add

end module mod_add
