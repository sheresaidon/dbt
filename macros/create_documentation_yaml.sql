
{% set model_name = 'load_events' %}


{{ codegen.generate_model_yaml( model_name ) }}
-- {{ codegen.generate_model_import_ctes( {model_name} ) }}
-- {{ codegen.generate_source( {model_name} ) }}
-- {{ codegen.generate_base_model ( {model_name}  ) }}
