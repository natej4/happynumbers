!Asks the user for two positive integers
!and returns the 10 happy numbers between them
!with the greatest norms, sorted descending by the norms

!by Nate Jackson for CSC330
program happy
    implicit none

    !globals
    integer :: x,y,n,size,numHappies
    integer, dimension(1000) :: nums,happies
    real, dimension(1000) :: norms

    print *,'Enter first argument: '
    read *, x
    print *,'Enter second argument: '
    read *, y

    if (x == y) then
        print *,'NOBODYS HAPPY'
        return
    end if

    if (x > y) then
        n = x
        x = y
        y = n
    endif
   
    call createArray(nums, x, y, size)
    call filter(nums, happies, numHappies, size)
    call sortNorms(happies, norms, numHappies)
    
    if (numHappies == 0) then
      print *,'NOBODYS HAPPY'
      return
    end if

    if (numHappies > 10) then
      numHappies = 10
    end if

    do n = 1, numHappies
        print *, happies(n)
    enddo
    
contains

!fills array with numbers between entered values
subroutine createArray(nums, x, y, size)
    implicit none

    integer :: x,y,size,n
    integer, dimension(1000), intent(out) :: nums

    size = 1
    do n = x,y
        nums(size) = n
        size = size + 1
    end do
    size = size - 1

end subroutine createArray

!fills a new array with just numbers that are happy
subroutine filter(nums, happies, numHappies, size)
  implicit none

  integer, dimension(1000) :: nums, happies
  integer :: numHappies, size;

  numHappies = 0
  do n = 1,size
    ! print *, is_happy (nums(n))

    if(is_happy(nums(n))) then
      happies(numHappies+1) = nums(n)
      numHappies = numHappies + 1
    end if
  end do
  
end subroutine filter

!calls findNorm on each happy number, bubble sorts by norms
subroutine sortNorms (happies, norms, numHappies)
  implicit none
  integer :: numHappies, n, o
  integer, dimension(1000) :: happies
  real, dimension(1000) :: norms
  real :: norm

  do n = 1, numHappies
    
    norm = findNorm(happies(n))
    norms(n) = norm
  end do

  call bubble_sort(norms, happies, numHappies)

end subroutine sortNorms

!calculates norm of a happy number
function findNorm (number) result (result)
  implicit none
  integer, intent(in) :: number
  integer :: d = 0, cacheSize, m, n, i, j
  integer, dimension(1000) :: cache
  real :: result

  n = number
  cacheSize = 1
  do while (n > 1)
    cache(cacheSize) = n
    cacheSize = cacheSize + 1
    m = 0
    do while (n > 0)
      
      d = mod(n, 10)
      m = m + d * d
      n = n / 10
    end do
    n = m
  end do
  do i = 1, cacheSize
    j = cache(i) * cache(i)
    result = result + j
    cache(i) = 0
  end do
  result = sqrt(result)
end function findNorm

!for is_happy
function sum_digits_squared (number) result (result)
  
  implicit none
  integer, intent (in) :: number
  integer :: result
  integer :: digit
  integer :: rest
  integer :: work

  result = 0
  work = number
  do
    if (work == 0) then
      exit
    end if
    rest = work / 10
    digit = work - 10 * rest
    result = result + digit * digit
    work = rest
  end do

end function sum_digits_squared

!determines if a number is happy
function is_happy (number) result (result)

  implicit none
  integer, intent (in) :: number
  logical :: result
  integer :: turtoise
  integer :: hare

  turtoise = number
  hare = number
  do
    turtoise = sum_digits_squared (turtoise)
    hare = sum_digits_squared (sum_digits_squared (hare))
    if (turtoise == hare) then
      exit
    end if
  end do
  result = turtoise == 1

end function is_happy

! from https://www.mjr19.org.uk/IT/sorts/sorts.f90
! bubble sort implementation, sorts both arrays based on norms array
! descending
subroutine bubble_sort(norms, happies, numHappies)
  implicit none
  real, dimension(1000), intent(inout) :: norms
  real :: temp
  integer :: i,j,last, temp2, numHappies
  integer, dimension(1000) :: happies

  last=numHappies
  do i=last-1,1,-1
     do j=1,i
        if (norms(j+1).gt.norms(j)) then
           temp=norms(j+1)
           norms(j+1)=norms(j)
           norms(j)=temp
           temp2=happies(j+1)
           happies(j+1)=happies(j)
           happies(j)=temp2
        endif
     enddo
  enddo
end subroutine bubble_sort

end program happy
