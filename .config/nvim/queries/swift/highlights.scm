; extends

(enum_entry
   name: (simple_identifier) @declaration.other)

(enum_entry
   name: (simple_identifier)
   data_contents: (enum_type_parameters
                    name: (user_type) @other.type_name)
   (#set! "priority" 200)
)

(array_type
   (user_type
      (type_identifier) @other.type_name)
   (#set! "priority" 200)
)

(type_annotation
  (opaque_type
    "some"
    (user_type (type_identifier) @other.type_name))
  (#set! "priority" 200)
)

(switch_statement
  expr: (navigation_expression
    target: (simple_identifier) @project.properties
    suffix: (navigation_suffix
      suffix: (simple_identifier) @project.properties))
  (#set! "priority" 200)
)
 
(user_type
  (type_identifier) @type.primitive
  (#any-of? @type.primitive
  "String" "Int" "Bool"
  "View")
  (#set! "priority" 200)
)

(call_expression
  (simple_identifier) @type.swiftui
  (#any-of? @type.swiftui
  "VStack" "HStack" "Text"
  "Button")
  (#set! "priority" 200)
)
(property_declaration
    (value_binding_pattern)
    name: (pattern
    bound_identifier: (simple_identifier) @member.definition)
  (#set! "priority" 200)
)


;; cursor : #3478F6

;; @declaration.type : #89DCFB
;; @declaration.other : #69AEC8
;; @other.type_name : #D5BBFA

;; @project.properties : #89C0B3
