use custom/types.{NamedFields}

/// Nested patterns: https://aiken-lang.org/language-tour/custom-types#nested-patterns
test nested_patterns() {
  let asset = ("PolicyId", "NFT", 1)

  let named_fields = NamedFields { boolean: False, maybe: Some(asset) }

  let is_valid_nft_qty =
    when named_fields is {
      NamedFields { maybe: Some((_policy_id, "NFT", qty)), .. } -> qty == 1
      _ -> {
        trace @"NOT an NFT"
        False
      }
    }
  is_valid_nft_qty?
}

/// List: https://aiken-lang.org/language-tour/custom-types#list
test list() {
  let ls: List<Int> = [1, 2, 3]
  let llss = [ls, ls, ls]

  let simple =
    when ls is {
      [a, ..tail] -> {
        trace tail
        a == 1
      }
      // [_, 2, ..] -> True // redundant
      _ -> False
    }

  let complex =
    when llss is {
      // https://aiken-lang.org/language-tour/custom-types#assigning-names-to-sub-patterns
      [_head, [_, 2, ..] as ls, ..] ->
        // this `ls` shadows `let ls`
        ls == [1, 2, 3]

      // otherwise:
      _ -> False
    }

  // return
  simple && complex
}

/// Generics: https://aiken-lang.org/language-tour/custom-types#generics
type Tree<a> {
  Tip
  Node { left: Tree<a>, right: Tree<a>, value: a }
}

test generics() {
  // Tree:
  //   1
  //  / \
  // 2   3
  let tree: Tree<Int> = Node(Node(Tip, Tip, 2), Node(Tip, Tip, 3), 1)

  expect Node { value: root_value, .. } = tree
  root_value == 1
}
