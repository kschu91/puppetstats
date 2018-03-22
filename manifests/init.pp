class puppetstats (
  Boolean $enabled                   = true,
  String $full_qualified_module_name = $title,
) {
  if $caller_module_name == '' {
    warning('"puppetstats" should always be used within a module. Do not use is directly on your nodes.')
  }

  if $facts['puppetstats_disabled'] == undef {
    if $enabled {
      puppetstats::track($full_qualified_module_name, $caller_module_name)
    }
  }
}