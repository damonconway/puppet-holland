# holland::setup
#
# Setup config files and anything else that all backupsets will need or have access to.
#
# @summary General holland setup
#
class holland::setup {

  $config_file = $holland::config_file
  $config_options = $holland::_config_options
  $defaults = { 'path' => $config_file }

  create_ini_settings($config_options, $defaults)

}
