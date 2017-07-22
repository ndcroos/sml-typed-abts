signature LN_SCOPE =
sig
  type 'a scope

  type variable
  type symbol

  type sort
  type psort

  exception Instantiate

  val liftTraversal : (int * int -> 'a -> 'b) -> int * int -> 'a scope -> 'b scope

  (* TODO: delete? *)
  type ('m, 'p, 'a) binding_support = 
    {abstract: int * int -> symbol list * variable list -> 'a -> 'a,
     instantiate: int * int -> 'p list * 'm list -> 'a -> 'a,
     freeVariable : variable * sort -> 'm,
     freeSymbol : symbol -> 'p}

  datatype ('s, 'v, 'a) scope_view = \ of ('s list * 'v list) * 'a

  val eq : ('a * 'a -> bool) -> 'a scope * 'a scope -> bool

  val intoScope : ('m, 'p, 'a) binding_support -> (symbol, variable, 'a) scope_view -> 'a scope 
  val outScope : ('m, 'p, 'a) binding_support -> psort list * sort list -> 'a scope -> (symbol, variable, 'a) scope_view

  (* O(1) *)
  val unsafeRead : 'a scope -> (string, string, 'a) scope_view
  val unsafeReadBody : 'a scope -> 'a
  val unsafeMakeScope : (string, string, 'a) scope_view -> 'a scope
end