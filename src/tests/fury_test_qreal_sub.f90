!< FURY test of [[qreal]].
program fury_test_qreal
!-----------------------------------------------------------------------------------------------------------------------------------
!< FURY test of [[qreal]].
!-----------------------------------------------------------------------------------------------------------------------------------
use fury
!-----------------------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------------------
type(qreal64) :: force1         !< A force.
type(qreal64) :: force2         !< A force.
type(qreal64) :: force3         !< A force.
type(qreal32) :: force4         !< A force.
type(uom64)   :: u_acceleration !< Acceleration unit.
type(uom64)   :: u_force        !< Force unit.
type(uom64)   :: u_length       !< Length unit.
type(uom64)   :: u_mass         !< Mass unit.
type(uom64)   :: u_speed        !< Speed unit.
type(uom64)   :: u_time         !< Time unit.
logical       :: test_passed(3) !< List of passed tests.
!-----------------------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------------------
test_passed = .false.

u_length = uom64(source='m [length]', name='metre')
u_mass = uom64(source='kg [mass]', name='kilogram')
u_time = uom64(source='s [time]', name='second')

u_speed = u_length / u_time
u_acceleration = u_speed / u_time
u_force = u_mass * u_acceleration

force1 = qreal64(magnitude=1._R_P, unit=u_force)
force2 = qreal64(magnitude=2._R_P, unit=u_force)

force3 = force1 - force2
test_passed(1) = force3%stringify(format='(F4.1)')=='-1.0 kg.m.s-2'
print "(A,L1)", '1.0 kg.m.s-2 - 2.0 kg.m.s-2 = '//force3%stringify(format='(F4.1)')//', is correct? ', test_passed(1)

force4 = force2
call force3%unset
force3 = force1 - force4
test_passed(2) = force3%stringify(format='(F4.1)')=='-1.0 kg.m.s-2'
print "(A,L1)", 'force1(float64) - force2(float32) = '//force3%stringify(format='(F4.1)')//', is correct? ', test_passed(2)

force3 = force4 - force1
test_passed(3) = force3%stringify(format='(F3.1)')=='1.0 kg.m.s-2'
print "(A,L1)", 'force1(float32) - force2(float64) = '//force3%stringify(format='(F3.1)')//', is correct? ', test_passed(3)

print "(A,L1)", new_line('a')//'Are all tests passed? ', all(test_passed)
stop
!-----------------------------------------------------------------------------------------------------------------------------------
endprogram fury_test_qreal
