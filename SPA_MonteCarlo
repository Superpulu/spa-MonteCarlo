PROGRAM SPA_MonteCarlo

! Program first creates new set of parameter values, which are random and uniformly distributed.
! Then, the ecosystem model SPA is executed for each new parameter sets, here repeated 5000 times.

IMPLICIT NONE

real,dimension(4) :: random_number ! the random number
real :: min_par , max_par , range_par ! minimum and maximum value of parameter range
integer,dimension(4) :: iseed ! the initial number seed
integer :: i,k
integer :: size_values = 4 ! number of values to be created

! create new, empty output files
CALL system('>values_VC; >parameters_VC.csv')

! initial number seed values for pseudo-random number creation
iseed = (/204,847,1567,3875/)

! open parameter file
OPEN(12,file='parameters_VC.csv',status='old')

! write parameter names as column headers
write(12,*) 'run,iota,gplant,capacitance,root_leaf_ratio'

! start random number creation, looping 5000 times
DO k=1,5000

! random numbers from a uniform distribution of min=0 and max=1
CALL slarnv( 1, iseed, size_values, random_number ) 

! random_number(1) = iota:            
min_par = 1.002 ; max_par = 1.04
range_par = max_par - min_par
random_number(1) = min_par + random_number(1) * range_par

! random_number(2) = gplant:          
min_par = 1.    ; max_par = 3.
range_par = max_par - min_par
random_number(2) = min_par + random_number(2) * range_par

! random_number(3) = capacitance:     
min_par = 1725. ; max_par = 5175.
range_par = max_par - min_par
random_number(3) = min_par + random_number(3) * range_par

! random_number(4) = root_leaf_ratio: 
min_par = 0.3   ; max_par = 0.9
range_par = max_par - min_par
random_number(4) = min_par + random_number(4) * range_par

! write new set of random parameter values to temporary output file
OPEN(11,file='values_VC',status='old')
! write loop number
WRITE(11,'(I4)') k
! write parameter values
WRITE(11,'(F8.6)') random_number(1)
WRITE(11,'(F5.3)') random_number(2)
WRITE(11,'(F6.1)') random_number(3)
WRITE(11,'(F5.3)') random_number(4)

CLOSE(11)

! also write to file storing all created parameter sets
WRITE(12,'((I4),",",(F8.6),",",(F5.3),",",(F6.1),",",(F5.3))') k,random_number

! execute shell script that replaces old parameters with new parameter set within SPA input file and then executes SPA
CALL system('./read_Vallcebre.sh')

ENDDO

CLOSE(12)

END PROGRAM SPA_MonteCarlo
