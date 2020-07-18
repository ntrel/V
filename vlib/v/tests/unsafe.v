fn test_ptr_assign() {
    v := 5
    mut p := &v
    p++
    p += 2
    _ := v
}

fn test_ptr_infix() {
    v := 4
    mut q := &v - 1
    q = q + 3
    _ := q
    _ := v
}

struct S1 {}

[unsafe_fn]
fn (s S1) f(){}

fn test_funcs() {
    s := S1{}
    s.f()
}

fn test_c() {
    mut p := C.malloc(4)
    s := 'hope'
    C.memcpy(p, s.str, 4)
}
