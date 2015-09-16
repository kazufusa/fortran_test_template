module mod_multiple
  implicit none
  public multiple
  private

  contains
    integer function multiple(a, b)
      use mod_add
      implicit none
      integer, intent(in) :: a, b
      integer i
      multiple = 0
      do i=1, b
        multiple = add(a, multiple)
      enddo
    end function multiple
end module mod_multiple
