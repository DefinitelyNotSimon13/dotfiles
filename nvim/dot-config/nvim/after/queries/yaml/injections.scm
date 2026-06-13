; extends

(block_mapping_pair
  key: (flow_node
    (plain_scalar
      (string_scalar) @_section))
  value: (block_node
    (block_mapping
      (block_mapping_pair
        key: (flow_node
          (plain_scalar
            (string_scalar) @injection.filename))
        value: (block_node
          (block_scalar) @injection.content))))
  (#eq? @_section "data")
  (#offset! @injection.content 0 1 0 0))

; (block_mapping_pair
;   key: (flow_node
;     (plain_scalar
;       (string_scalar) @_section))
;   value: (block_node
;     (block_mapping
;       (block_mapping_pair
;         key: (flow_node
;           (plain_scalar
;             (string_scalar) @_key))
;         value: (block_node
;           (block_scalar
;             (comment) @injection.language) @injection.content))))
;   (#eq? @_section "data")
;   (#gsub! @injection.language "^#%s*" "")
;   (#offset! @injection.content 1 0 0 0))
