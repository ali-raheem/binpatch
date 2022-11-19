module main

import json
import os

struct Patch {
  offset u64
  cleanbytes []u8
  patchbytes []u8
}
struct PatchScript{
 name string
 comment string
 patches []Patch
}

/*
commands
status patch_file infile
patch patch_file infile
unpatch patch_file infile
gen_patch cleanfile patchfile
*/
	
       
fn main() {
// p1 := Patch{100, [u8(0x41),0x41,0x12], [u8(0x45),0x45,0x13]}
 //   ps := PatchScript{"Test", "A test patchscript", [p1]}
//    pss := json.encode_pretty(ps)
  match os.args[1] {
    'status' {
      patch_file := os.read_file(os.args[2])!
      test_file := os.open(os.args[3])!
      patch_script := json.decode(PatchScript, patch_file)!
      for patch in patch_script.patches {
	test_bytes := test_file.read_bytes_at(patch.patchbytes.len, patch.offset)
	  match test_bytes {
	    patch.cleanbytes {println("CLEAN")}
	    patch.patchbytes {println("PATCHED")}
	    else {println("MISMATCH")}
	  }
	}
        }
	else {println("Unknown command!")}
  }

}
