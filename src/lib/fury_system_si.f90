!< FURY definition of *International System of Units*.
module fury_system_si
!-----------------------------------------------------------------------------------------------------------------------------------
!< FURY definition of *International System of Units*.
!-----------------------------------------------------------------------------------------------------------------------------------
use fury_uom
use penf
use stringifor
!-----------------------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------------------
implicit none
private
public :: system_si
!-----------------------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------------------
type :: system_si
  !< International System of Units.
  character(len=:), allocatable :: acronym            !< Units system acronym, e.g. "SI" for the International System.
  type(uom),        allocatable :: units(:)           !< Defined units.
  integer(I_P)                  :: units_number=0_I_P !< Number of units.
  contains
    ! public deferred methods
    ! procedure, pass(self) :: add_unit   !< Add a new unit.
    procedure, pass(self) :: free       !< Free the units system.
    procedure, pass(self) :: initialize !< Initialize the units system.
    procedure, pass(self) :: list_units !< Return the list of defined units.
endtype system_si
!-----------------------------------------------------------------------------------------------------------------------------------
contains
  elemental subroutine free(self)
  !---------------------------------------------------------------------------------------------------------------------------------
  !< Free the units system.
  !---------------------------------------------------------------------------------------------------------------------------------
  class(system_si), intent(inout) :: self !< The units system.
  !---------------------------------------------------------------------------------------------------------------------------------

  !---------------------------------------------------------------------------------------------------------------------------------
  if (allocated(self%acronym)) deallocate(self%acronym)
  if (allocated(self%units)) deallocate(self%units)
  self%units_number = 0_I_P
  !---------------------------------------------------------------------------------------------------------------------------------
  endsubroutine free

  subroutine initialize(self, acronym)
  !---------------------------------------------------------------------------------------------------------------------------------
  !< Initialize the units system.
  !<
  !< @todo Load from file.
  !---------------------------------------------------------------------------------------------------------------------------------
  class(system_si), intent(inout)         :: self    !< The units system.
  character(*),     intent(in),  optional :: acronym !< Units system acronym, e.g. "SI" for the International System.
  !---------------------------------------------------------------------------------------------------------------------------------

  !---------------------------------------------------------------------------------------------------------------------------------
  call self%free
  self%acronym = 'SI' ; if (present(acronym)) self%acronym = acronym
  self%units_number = 32
  allocate(self%units(1:self%units_number))
  ! base units
  self%units(1) = 'A = ampere [current] {ampere}'
  self%units(2) = 'cd = candela [luminosity] {candela}'
  self%units(3) = 'K = kelvin [temperature] {kelvin}'
  self%units(4) = 'kg = kilogram [mass] {kilogram}'
  self%units(5) = 'm = metre = meter [length] {metre}'
  self%units(6) = 'mol = mole [substance] {mole}'
  self%units(7) = 's = sec = second [time] {second}'
  ! units derived
  self%units(8 ) = 's [time].A [current] (C[electric_charge]) {coulomb}'
  self%units(9 ) = 'kg-1 [mass-1].m-2 [length-2].s4 [time4].A2 [current2] (F[electric_capacitance]) {farad}'
  self%units(10) = 'kg [mass].m2 [length2].s-2 [time-2].A-2 [current-2] (H[inductance]) {henry}'
  self%units(11) = 's-1 [time-1] (Hz[frequency]) {hertz}'
  self%units(12) = 'kg [mass].m2 [length2].s-2 [time-2] (J[energy]) {joule}'
  self%units(13) = 'cd [luminous_flux] (lm [luminous_flux]) {lumen}'
  self%units(14) = 'm-2 [length-2].cd [luminosity] (lx[illuminance]) {lux}'
  self%units(15) = 'm [length].s-1 [time-1]{metre.second-1}'
  self%units(16) = 'm2 [length2]{metre2}'
  self%units(17) = 'kg [mass].m [length].s-2 [time-2] (N[force]) {newton}'
  self%units(18) = 'kg [mass].m2 [length2].s-3 [time-3].A-2 [current-2]{ohm}'
  self%units(19) = 'kg [mass].m-1 [length-1].s-2 [time-2] (Pa[pressure]) {pascal}'
  self%units(20) = 'm [length].m-1 [length-1]{radian}'
  self%units(21) = 'kg-1 [mass-1].m-2 [length-2].s3 [time3].A2 [current2] (S[electric_conductance]) {siemens}'
  self%units(22) = 'm2 [length2].m-2 [length-2]{steradian}'
  self%units(23) = 'kg [mass].s-2 [time-2].A-1 [current-1] (T[magnetic_flux_density]) {tesla}'
  self%units(24) = 'kg [mass].m2 [length2].s-3 [time-3].A-1 [current-1] (V[voltage]) {volt}'
  self%units(25) = 'kg [mass].m2 [length2].s-3 [time-3] (W[power]) {watt}'
  self%units(26) = 'kg [mass].m2 [length2].s-2 [time-2].A-1 [current-1] (Wb[magnetic_flux]) {weber}'
  ! USCS units for conversions
  self%units(27) = 'in = 0.0254 * m = inch [length] {internaltion_inch}'
  self%units(28) = 'yd = 0.9144 * m = yard [length] {internaltion_yard}'
  self%units(29) = 'ft = 0.3048 * m = foot [length] {internaltion_foot}'
  self%units(30) = 'mi = 1609.34 * m = mile [length] {internaltion_mile}'
  self%units(31) = 'pound = 0.453592 * kg [mass] {internaltion_pound}'
  self%units(32) = 'oz = 0.0283495 * kg = ounce [mass] {internaltion_ounce}'
  !---------------------------------------------------------------------------------------------------------------------------------
  endsubroutine initialize

  function list_units(self, with_dimensions, with_aliases, compact_reals) result(raw)
  !---------------------------------------------------------------------------------------------------------------------------------
  !< Return the list defined units.
  !---------------------------------------------------------------------------------------------------------------------------------
  class(system_si), intent(in)           :: self            !< The unit.
  logical,          intent(in), optional :: with_dimensions !< Flag to activate dimensions printing.
  logical,          intent(in), optional :: with_aliases    !< Flag to activate alias printing.
  logical,          intent(in), optional :: compact_reals   !< Flag to activate real numbers compacting.
  character(len=:), allocatable          :: raw             !< Raw characters data.
  integer(I_P)                           :: u               !< Counter.
  !---------------------------------------------------------------------------------------------------------------------------------

  !---------------------------------------------------------------------------------------------------------------------------------
  raw = ''
  if (self%units_number>0) then
    do u=1, self%units_number
      raw = raw//new_line('a')//' '//trim(strz(n=u, nz_pad=3))//'. '//self%units(u)%name//': '//&
        self%units(u)%stringify(with_dimensions=with_dimensions, with_aliases=with_aliases, compact_reals=compact_reals)
    enddo
    raw = raw(2:)
  endif
  !---------------------------------------------------------------------------------------------------------------------------------
  endfunction list_units
endmodule fury_system_si
