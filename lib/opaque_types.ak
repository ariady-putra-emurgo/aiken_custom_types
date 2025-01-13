pub opaque type Class {
  i: Int,
  a: ByteArray,
  y: Bool,
}

pub fn new_obj(i: Int, a: ByteArray, y: Bool) -> Class {
  Class(i, a, y)
}

// ## `i` setter-getter

pub fn get_obj_i(o: Class) -> Int {
  o.i
}

pub fn set_obj_i(o: Class, new_i: Int) -> Class {
  Class { ..o, i: new_i }
}

// ## `a` setter-getter

pub fn get_obj_a(Class { a, .. }: Class) -> ByteArray {
  a
}

pub fn set_obj_a(Class(i, _, y): Class, new_a: ByteArray) -> Class {
  Class(i, new_a, y)
}

// ## `y` setter-getter

pub fn get_obj_y(Class(_, _, yes_no)) -> Bool {
  yes_no
}

pub fn set_obj_y(Class { a, i, .. }, y: Bool) -> Class {
  Class { i, a, y }
}

// ## Single-constructor with Single-field Opaque type

/// This behaves like an opaque type-alias
pub opaque type NewType<a> {
  field: a,
}

pub fn new_type(a) -> NewType<a> {
  NewType(a)
}

/// To compare `NewType` with a non-opaque type
pub type Constr<a> {
  field: a,
}

pub fn new_constr(a) -> Constr<a> {
  Constr(a)
}
