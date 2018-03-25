define puppetstats (
  Boolean $enabled                   = true
) {
  if $caller_module_name == '' {
    warning('"puppetstats" should always be used within a module. Do not use is directly on your nodes.')
  }

  if $facts['puppetstats_disabled'] == undef {
    if $enabled {
      puppetstats::track($title, $caller_module_name)
    }
  }
}