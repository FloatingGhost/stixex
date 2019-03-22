Nonterminals
pattern observation_expressions observation_expression_or observation_expression_and
observation_expression prop_test start_stop_qualifier within_qualifier repeated_qualifier
object_path object_type first_path_component object_path_component set_literal
primitive_literal  orderable_literal comparison_expression comparison_expression_and
set_contents.

Terminals
and_cond or_cond not_cond like matches is_subset is_superset
last start stop seconds repeats times integer float
binary boolean identifier left_bracket left_parenthesis right_bracket right_parenthesis
equal_to timestamp within followed_by less_than greater_than less_than_or_equal_to
greater_than_or_equal_to contained_in string not_equal dot colon wildcard comma
hex.

Rootsymbol pattern.

pattern -> observation_expressions : '$1'.

observation_expressions ->
    observation_expressions followed_by observation_expressions :
        {followed_by, '$1', '$3'}.

observation_expressions ->
    observation_expression_or : '$1'.

observation_expression_or ->
    observation_expression_or or_cond observation_expression_or :
        {or_cond, '$1', '$3'}.

observation_expression_or ->
    observation_expression_and : '$1'.

observation_expression_and ->
    observation_expression_and and_cond observation_expression_and :
        {and_cond, '$1', '$3'}.

observation_expression_and ->
    observation_expression : '$1'.

observation_expression ->
    left_bracket comparison_expression right_bracket : '$2'.

observation_expression ->
    left_parenthesis comparison_expression right_parenthesis : '$2'.

observation_expression ->
    observation_expression start_stop_qualifier : {'$1', '$2'}.   

observation_expression ->
    observation_expression within_qualifier : {'$1', '$2'}.

observation_expression ->
    observation_expression repeated_qualifier : {'$1', '$2'}.

comparison_expression ->
    comparison_expression or_cond comparison_expression : {or_cond, '$1', '$3'}.

comparison_expression ->
    comparison_expression_and : '$1'.

comparison_expression_and ->
    comparison_expression_and and_cond comparison_expression_and : {and_cond, '$1', '$3'}.

comparison_expression_and ->
    prop_test : '$1'.

prop_test -> object_path equal_to primitive_literal : {equal_to, '$1', '$3'}.
prop_test ->
    object_path not_cond equal_to primitive_literal : {not_cond, {equal_to, '$1', '$3'}}.
prop_test -> object_path not_equal primitive_literal : {not_cond, {equal_to, '$1', '$3'}}.
prop_test -> object_path not_cond not_equal primitive_literal : {equal_to, '$1', '$3'}.
prop_test -> object_path greater_than orderable_literal : {greater_than, '$1', '$3'}.
prop_test ->
    object_path not_cond greater_than orderable_literal : {less_than_or_equal_to, '$1', '$3'}.
prop_test -> object_path less_than orderable_literal : {less_than, '$1', '$3'}.
prop_test -> 
    object_path not_cond less_than orderable_literal : {greater_than_or_equal_to, '$1', '$3'}.
prop_test ->
    object_path greater_than_or_equal_to orderable_literal :
        {greater_than_or_equal_to, '$1', '$3'}.
prop_test ->
    object_path not_cond greater_than_or_equal_to orderable_literal :
        {less_than, '$1', '$3'}.
prop_test ->
    object_path less_than_or_equal_to orderable_literal : {less_than_or_equal_to, '$1', '$3'}.
prop_test ->
    object_path not_cond less_than_or_equal_to orderable_literal : {greater_than, '$1', '$3'}.
prop_test -> object_path contained_in set_literal : {contained_in, '$1', '$3'}.
prop_test ->
    object_path not_cond contained_in set_literal : {not_cond, {contained_in, '$1', '$3'}}.
prop_test -> object_path like string : {like, '$1', '$3'}.
prop_test -> object_path not_cond like string : {not_cond, {like, '$1', '$3'}}.
prop_test -> object_path matches string : {matches, '$1', '$3'}.
prop_test -> object_path not_cond matches string : {not_cond, {matches, '$1', '$3'}}.
prop_test -> object_path is_subset string : {is_subset, '$1', '$3'}.
prop_test ->
    object_path not_cond is_subset string : {not_cond, {is_subset, '$1', '$3'}}.
prop_test -> object_path is_superset string : {is_superset, '$1', '$3'}.
prop_test ->
    object_path not_cond is_superset string : {not_cond, {is_superset, '$1', '$3'}}.
prop_test -> left_parenthesis comparison_expression right_parenthesis : '$2'.


start_stop_qualifier -> 
    start timestamp stop timestamp : {'$2', '$4'}.

within_qualifier -> 
    within integer seconds : '$2'.

within_qualifier ->
    within float seconds : '$2'.

repeated_qualifier ->
    repeats integer times : '$2'.

object_path ->
    object_type colon first_path_component : {'$1', '$3'}.

object_path ->
    object_type colon first_path_component object_path_component : {'$1', '$3', '$4'}.

object_type ->
    identifier : '$1'.

first_path_component ->
    identifier : '$1'.

first_path_component ->
    string : '$1'.

object_path_component ->
    object_path_component object_path_component : {'$1', '$2'}.

object_path_component ->
    dot identifier : '$2'.

object_path_component ->
    dot string : '$2'.

object_path_component ->
    left_bracket integer right_bracket : '$2'. 

object_path_component ->
    left_bracket wildcard right_bracket : '$2'.

set_literal ->
    left_parenthesis right_parenthesis : [].

set_literal ->
    left_parenthesis set_contents right_parenthesis : '$2'.

set_contents ->
    primitive_literal comma set_contents : ['$1' | '$2'].

set_contents ->
    primitive_literal : '$1'.

primitive_literal -> orderable_literal : '$1'.
primitive_literal -> boolean : '$1'.

orderable_literal -> integer : '$1'.
orderable_literal -> float : '$1'.
orderable_literal -> string : '$1'.
orderable_literal -> binary : '$1'.
orderable_literal -> hex : '$1'.
orderable_literal -> timestamp : '$1'.
