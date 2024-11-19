use aiken/cbor
use cardano/address.{Script, VerificationKey}
use custom_types.{
  Backer, Datum, Fieldless, NamedFields, NamelessFields, North, Single,
  SingleConstructor, South, Unit,
}
use opaque_types.{Class} as obj

// ## Single Constructor

test single() {
  let single = Single { bytearray: "SINGLE", int: 1 }
  let single_nameless = Single("SINGLE", 1)

  single == single_nameless
}

test single_constructor() {
  let single_constructor =
    SingleConstructor { bytearray: "SINGLE_CONSTRUCTOR", int: 11 }
  let single_constructor_nameless = SingleConstructor("SINGLE_CONSTRUCTOR", 11)

  single_constructor == single_constructor_nameless
}

test unit() {
  let unit = Unit
  and {
    cbor.serialise(unit) == cbor.serialise(Void),
    cbor.serialise(unit) != cbor.serialise(Never),
    cbor.serialise(None) == cbor.serialise(Never),
  }
}

// ## Multi Constructors

test multi() {
  let named_fields = NamedFields { boolean: True, maybe: None }
  let named_fields_nameless = NamedFields(True, None)
  let nameless_fields = NamelessFields(True, None)
  let fieldless = Fieldless

  and {
    named_fields == named_fields_nameless,
    cbor.serialise(named_fields_nameless) != cbor.serialise(nameless_fields),
    cbor.serialise(fieldless) != cbor.serialise(Void),
    when nameless_fields is {
      NamelessFields(is_true, _maybe) -> is_true
      NamedFields { .. } | Fieldless -> False
    },
  }
}

test enum() {
  let direction = North
  when direction is {
    North -> True
    South -> False
    _ -> False
  }
}

// ## Complex Types

test datum() {
  let backer_1 =
    Backer {
      owner_pkh: VerificationKey(
        #"1a000000000000000000000000000000000000000000000000000056",
      ),
      owner_skh: Script(
        #"1b000000000000000000000000000000000000000000000000000056",
      ),
      amount: 11_000_000,
    }
  let backer_2 =
    Backer(
      VerificationKey(
        #"2a000000000000000000000000000000000000000000000000000056",
      ),
      Script(#"2b000000000000000000000000000000000000000000000000000056"),
      222_000_000,
    )

  let datum =
    Datum {
      campaign: "My Campaign",
      deadline: 1928374650000,
      goal: 3_000_000_000,
      creator_pkh: VerificationKey(
        #"3a000000000000000000000000000000000000000000000000000056",
      ),
      creator_skh: VerificationKey(
        #"3b000000000000000000000000000000000000000000000000000056",
      ),
      backers: [backer_1, backer_2],
    }
  let datum_nameless =
    Datum(
      "My Campaign",
      1928374650000,
      3_000_000_000,
      VerificationKey(
        #"3a000000000000000000000000000000000000000000000000000056",
      ),
      VerificationKey(
        #"3b000000000000000000000000000000000000000000000000000056",
      ),
      [backer_1, backer_2],
    )

  let updated_datum = Datum { ..datum, campaign: "New Campaign Name" }

  and {
    datum == datum_nameless,
    datum.backers == updated_datum.backers,
  }
}

// ### Destructuring

test destructuring() {
  let backer_1 =
    Backer {
      owner_pkh: VerificationKey(
        #"1a000000000000000000000000000000000000000000000000000056",
      ),
      owner_skh: Script(
        #"1b000000000000000000000000000000000000000000000000000056",
      ),
      amount: 11_000_000,
    }
  let backer_2 =
    Backer {
      owner_pkh: VerificationKey(
        #"2a000000000000000000000000000000000000000000000000000056",
      ),
      owner_skh: Script(
        #"2b000000000000000000000000000000000000000000000000000056",
      ),
      amount: 222_000_000,
    }

  let Backer(_pkh, _skh, backer_1_amount) = backer_1
  let Backer { amount: backer_2_amount, .. } = backer_2

  backer_2_amount > backer_1_amount
}

// ## Opaque Types

test opaque_types() {
  let o: Class = obj.new(1, "Hello", True)

  let o_1 = obj.set_i(o, 2)
  let o_2 = obj.set_a(o, "World")
  let o_3 = obj.set_y(o, False)

  and {
    obj.get_i(o_1) == obj.get_i(o) + 1,
    and {
      obj.get_a(o) == "Hello",
      obj.get_a(o_2) == "World",
    },
    and {
      !obj.get_y(o_3),
      obj.get_y(o),
    },
  }
}
