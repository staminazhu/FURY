!< FURY class definition of real (with float128 kind) quantity with associated unit of measure.

module fury_qreal128
!< FURY class definition of real (with float128 kind) quantity with associated unit of measure.
use, intrinsic :: iso_fortran_env, only : stderr => error_unit
use fury_uom128
use penf, RKP => R16P
use stringifor

#include "fury_qreal.inc"
endmodule fury_qreal128
