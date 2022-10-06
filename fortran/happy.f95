program happy
    implicit none

    integer :: x,y,n,size,numsize
    integer, dimension(:), allocatable :: nums
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
    size = y-x+1
    allocate(nums(size))
    call createArray(nums, x, y)
    ! numsize = size(nums)
    do n = 1, size
        print *, nums(n)
    enddo
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

    nums = nums(1:y)


end subroutine createArray