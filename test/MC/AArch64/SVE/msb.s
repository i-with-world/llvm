// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d -mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

msb z0.b, p7/m, z1.b, z31.b
// CHECK-INST: msb	z0.b, p7/m, z1.b, z31.b
// CHECK-ENCODING: [0xe0,0xff,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: e0 ff 01 04 <unknown>

msb z0.h, p7/m, z1.h, z31.h
// CHECK-INST: msb	z0.h, p7/m, z1.h, z31.h
// CHECK-ENCODING: [0xe0,0xff,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: e0 ff 41 04 <unknown>

msb z0.s, p7/m, z1.s, z31.s
// CHECK-INST: msb	z0.s, p7/m, z1.s, z31.s
// CHECK-ENCODING: [0xe0,0xff,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: e0 ff 81 04 <unknown>

msb z0.d, p7/m, z1.d, z31.d
// CHECK-INST: msb	z0.d, p7/m, z1.d, z31.d
// CHECK-ENCODING: [0xe0,0xff,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: e0 ff c1 04 <unknown>
