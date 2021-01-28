struct S1 {
}
fn (s S1) m() string {
	return 'hi'
}

fn f<T>(v T) string {
	$for method in T.methods {
		$if method.return_type is Result {
			r := v.$method()// or {
			return r
			//~ app.$(method.name)(vars)
		}
	}
	return ''
}

s := S1{}
r := f(s)
println(r)

/*
 * S1.methods
 * S1.fields
 * m has to return string
 * 
 */
