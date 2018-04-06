# holland::provider
#
# A defined type that creates a provider with a given configuration.
#
# @summary Create a provider
#
# @example
#   holland::provider { 'holland_provider xtrabackup':
#     ensure        => 'present',
#     provider_name => 'xtrabackup',
#   }
#
define holland::provider(
  String $provider_name               = $title,
  Stdlib::Absolutepath $providers_dir = $holland::providers_dir,
  Enum['absent','present'] $ensure     = 'present',
  String $file_name                    = "${provider_name}.conf",
  Hash $settings                       = {},
) {

  $file_path = "${providers_dir}/${file_name}"

  $settings.each |$section,$sets| {
    $sets.each |$setting,$value| {
      ini_setting { "holland_provider ${provider_name}/${section}/${setting}":
        ensure  => $ensure,
        path    => $file_path,
        section => $section,
        setting => $setting,
        value   => $value,
      }
    }
  }

}
