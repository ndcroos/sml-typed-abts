signature ABT_LINEAR_UNIFICATION =
sig
  include ABT_PATTERN

  (* a simultaneous substitution of metavariables *)
  structure Env : DICT where type key = Abt.metavariable
  type env = Abt.abt Abt.bview Env.dict

  (* a simultaneous renaming of symbols *)
  structure Ren : DICT where type key = Abt.symbol
  type ren = Abt.symbol Ren.dict

  (* When [pat] is a pattern and [m] is a closed term without metavariables,
   * then [pat <*> m] is the judgment that [m] unifies with the pattern [pat] *)
  datatype match = <*> of Pattern.pattern * Abt.abt

  exception UnificationFailure
  val unify : match -> ren * env
end

