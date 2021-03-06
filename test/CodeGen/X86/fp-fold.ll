; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown                        | FileCheck %s --check-prefixes=ANY,STRICT
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -enable-unsafe-fp-math | FileCheck %s --check-prefixes=ANY,UNSAFE

define float @fadd_zero(float %x) {
; STRICT-LABEL: fadd_zero:
; STRICT:       # %bb.0:
; STRICT-NEXT:    xorps %xmm1, %xmm1
; STRICT-NEXT:    addss %xmm1, %xmm0
; STRICT-NEXT:    retq
;
; UNSAFE-LABEL: fadd_zero:
; UNSAFE:       # %bb.0:
; UNSAFE-NEXT:    retq
  %r = fadd float %x, 0.0
  ret float %r
}

define float @fadd_negzero(float %x) {
; ANY-LABEL: fadd_negzero:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fadd float %x, -0.0
  ret float %r
}

define float @fadd_produce_zero(float %x) {
; ANY-LABEL: fadd_produce_zero:
; ANY:       # %bb.0:
; ANY-NEXT:    xorps %xmm0, %xmm0
; ANY-NEXT:    retq
  %neg = fsub nsz float 0.0, %x
  %r = fadd nnan float %neg, %x
  ret float %r
}

define float @fadd_reassociate(float %x) {
; ANY-LABEL: fadd_reassociate:
; ANY:       # %bb.0:
; ANY-NEXT:    addss {{.*}}(%rip), %xmm0
; ANY-NEXT:    retq
  %sum = fadd float %x, 8.0
  %r = fadd reassoc nsz float %sum, 12.0
  ret float %r
}

define float @fadd_negzero_nsz(float %x) {
; ANY-LABEL: fadd_negzero_nsz:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fadd nsz float %x, -0.0
  ret float %r
}

define float @fadd_zero_nsz(float %x) {
; ANY-LABEL: fadd_zero_nsz:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fadd nsz float %x, 0.0
  ret float %r
}

define float @fsub_zero(float %x) {
; ANY-LABEL: fsub_zero:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fsub float %x, 0.0
  ret float %r
}

define float @fsub_self(float %x) {
; ANY-LABEL: fsub_self:
; ANY:       # %bb.0:
; ANY-NEXT:    xorps %xmm0, %xmm0
; ANY-NEXT:    retq
  %r = fsub nnan float %x, %x 
  ret float %r
}

define float @fsub_neg_x_y(float %x, float %y) {
; ANY-LABEL: fsub_neg_x_y:
; ANY:       # %bb.0:
; ANY-NEXT:    subss %xmm0, %xmm1
; ANY-NEXT:    movaps %xmm1, %xmm0
; ANY-NEXT:    retq
  %neg = fsub nsz float 0.0, %x
  %r = fadd nsz float %neg, %y
  ret float %r
}

define float @fsub_negzero(float %x) {
; STRICT-LABEL: fsub_negzero:
; STRICT:       # %bb.0:
; STRICT-NEXT:    xorps %xmm1, %xmm1
; STRICT-NEXT:    addss %xmm1, %xmm0
; STRICT-NEXT:    retq
;
; UNSAFE-LABEL: fsub_negzero:
; UNSAFE:       # %bb.0:
; UNSAFE-NEXT:    retq
  %r = fsub float %x, -0.0
  ret float %r
}

define float @fsub_zero_nsz_1(float %x) {
; ANY-LABEL: fsub_zero_nsz_1:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fsub nsz float %x, 0.0
  ret float %r
}

define float @fsub_zero_nsz_2(float %x) {
; ANY-LABEL: fsub_zero_nsz_2:
; ANY:       # %bb.0:
; ANY-NEXT:    xorps {{.*}}(%rip), %xmm0
; ANY-NEXT:    retq
  %r = fsub nsz float 0.0, %x
  ret float %r
}

define float @fsub_negzero_nsz(float %x) {
; ANY-LABEL: fsub_negzero_nsz:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fsub nsz float %x, -0.0
  ret float %r
}

define float @fmul_zero(float %x) {
; ANY-LABEL: fmul_zero:
; ANY:       # %bb.0:
; ANY-NEXT:    xorps %xmm0, %xmm0
; ANY-NEXT:    retq
  %r = fmul nnan nsz float %x, 0.0
  ret float %r
}

define float @fmul_one(float %x) {
; ANY-LABEL: fmul_one:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fmul float %x, 1.0
  ret float %r
}

define float @fmul_x_const_const(float %x) {
; ANY-LABEL: fmul_x_const_const:
; ANY:       # %bb.0:
; ANY-NEXT:    mulss {{.*}}(%rip), %xmm0
; ANY-NEXT:    retq
  %mul = fmul reassoc float %x, 9.0
  %r = fmul reassoc float %mul, 4.0
  ret float %r
}
