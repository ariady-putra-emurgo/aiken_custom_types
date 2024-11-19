use cardano/address.{Credential}
use cardano/assets.{AssetName, Lovelace, PolicyId}

// ## Single Constructor

/// Basic custom type: https://aiken-lang.org/language-tour/custom-types#basics
pub type Single {
  Single { bytearray: ByteArray, int: Int }
}

/// Shorthand notation: https://aiken-lang.org/language-tour/custom-types#shorthand-notation
pub type SingleConstructor {
  bytearray: ByteArray,
  int: Int,
}

pub type Unit {
  Unit
}

// ## Multi Constructors

/// Multi constructors: https://aiken-lang.org/language-tour/custom-types#multiple-constructors
pub type Multi {
  NamedFields { boolean: Bool, maybe: Option<(PolicyId, AssetName, Int)> }
  NamelessFields(Bool, Option<(PolicyId, AssetName, Int)>)
  Fieldless
}

pub type Enum {
  North
  South
  East
  West
}

// ## Complex Types

pub type Backer {
  owner_pkh: Credential,
  owner_skh: Credential,
  amount: Lovelace,
}

pub type Datum {
  campaign: ByteArray,
  deadline: Int,
  goal: Lovelace,
  creator_pkh: Credential,
  creator_skh: Credential,
  backers: List<Backer>,
}
