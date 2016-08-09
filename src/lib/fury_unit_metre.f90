!< FURY definition of metre unit.
module fury_unit_metre
!-----------------------------------------------------------------------------------------------------------------------------------
!< FURY definition of metre unit.
!-----------------------------------------------------------------------------------------------------------------------------------
use fury_unit_length
use penf
!-----------------------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------------------
implicit none
private
public :: unit_metre
!-----------------------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------------------
type, extends(unit_length) :: unit_metre
  !< Definition of metre unit.
  contains
    ! public overrided methods
    procedure, pass(self) :: set !< set the unit.
endtype unit_metre

interface unit_metre
  !< Ovearloading unit_metre name with a creator function.
  module procedure creator
endinterface
!-----------------------------------------------------------------------------------------------------------------------------------
contains
  ! non type bound procedures
  function creator(scale_factor, symbol) result(unit)
  !---------------------------------------------------------------------------------------------------------------------------------
  !< Create an instance of unit.
  !---------------------------------------------------------------------------------------------------------------------------------
  real(R_P),    intent(in) :: scale_factor !< Scale factor for multiple of base unit, e.g. 1000 for kilometres.
  character(*), intent(in) :: symbol       !< Litteral symbol of the unit, e.g. "m" for metres.
  type(unit_metre)         :: unit         !< The unit.
  !---------------------------------------------------------------------------------------------------------------------------------

  !---------------------------------------------------------------------------------------------------------------------------------
  call unit%set(scale_factor=scale_factor, symbol=symbol)
  !---------------------------------------------------------------------------------------------------------------------------------
  endfunction creator

  ! public overrided methods
  subroutine set(self, scale_factor, symbol, error)
  !---------------------------------------------------------------------------------------------------------------------------------
  !< Set the unit.
  !<
  !< @todo Load from file.
  !---------------------------------------------------------------------------------------------------------------------------------
  class(unit_metre), intent(inout)         :: self         !< The unit.
  real(R_P),         intent(in),  optional :: scale_factor !< Scale factor for multiple of base unit, e.g. 1000 for kilometres.
  character(*),      intent(in),  optional :: symbol       !< Litteral symbol of the unit, e.g. "m" for metres.
  integer(I_P),      intent(out), optional :: error        !< Error code, 0 => no errors happen.
  integer(I_P)                             :: error_       !< Error code, 0 => no errors happen, local variable.
  !---------------------------------------------------------------------------------------------------------------------------------

  !---------------------------------------------------------------------------------------------------------------------------------
  error_ = 1
  self%scale_factor = 1._R_P ; if (present(scale_factor)) self%scale_factor = scale_factor
  self%symbol = 'm' ; if (present(symbol)) self%symbol = symbol
  error_ = 0
  if (present(error)) error = error_
  !---------------------------------------------------------------------------------------------------------------------------------
  endsubroutine set
endmodule fury_unit_metre
