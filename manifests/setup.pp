# holland::setup
#
# Setup config files and anything else that all backupsets will need or have access to.
#
# @summary General holland setup
#
class holland::setup {

  $config_options = $holland::merge_config_options ? {
    false   => $holland::config_options,
    default => lookup('holland::config_options', Optional[Hash], 'deep', undef),
  }

  $config_file = $holland::config_file
  $defaults    = { 'path' => $config_file }

  if $config_options {
    create_ini_settings($config_options, $defaults)
  }

}
