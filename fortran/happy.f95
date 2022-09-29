program happy
    implicit none

    integer :: x,y,n
    integer, dimension(:), allocatable :: nums
    print *,'Enter first argument: '
    read *, x
    print *,'Enter second argument: '
    read *, y

    if (x == y) then
        print *,'NOBODYS HAPPY'
        return
    end if

    allocate(nums(y))
    call createArray(nums, x, y)
    do n = 1,y
        print *, nums(n)
    end do
    ! print *, sizeof(nums)

    deallocate (nums)
    
end program happy

subroutine createArray(nums, x, y)
    implicit none

    integer :: x,y,count = 1,n
    integer, dimension(x-y), intent(out) :: nums

    do n = x,y
        nums(count) = n
        count = count + 1
    end do


end subroutine createArray