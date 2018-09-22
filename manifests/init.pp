define puppetstats (
  $enabled = true
) {
  if fact('puppetstats_disabled') == undef {
    if $caller_module_name == '' {
      warning('"puppetstats" should always be used within a module. Do not use is directly on your nodes.')
    }
    if $enabled {
      puppetstats::track($title, $caller_module_name)
    }
  }
}