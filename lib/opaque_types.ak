pub opaque type Class {
  i: Int,
  a: ByteArray,
  y: Bool,
}

pub fn new(i: Int, a: ByteArray, y: Bool) -> Class {
  Class(i, a, y)
}

// ## `i` setter-getter

pub fn get_i(o: Class) -> Int {
  o.i
}

pub fn set_i(o: Class, new_i: Int) -> Class {
  Class { ..o, i: new_i }
}

// ## `a` setter-getter

pub fn get_a(Class { a, .. }: Class) -> ByteArray {
  a
}

pub fn set_a(Class(i, _, y): Class, new_a: ByteArray) -> Class {
  Class(i, new_a, y)
}

// ## `y` setter-getter

pub fn get_y(Class(_, _, yes_no)) -> Bool {
  yes_no
}

pub fn set_y(Class { a, i, .. }, y: Bool) -> Class {
  Class { i, a, y }
}
