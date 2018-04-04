# holland::backupset
#
# A defined type that creates a backupset with a given configuration.
#
# @summary Create a backupset
#
# @example
#   holland::backupset { 'holland_backupset default':
#     ensure                      => 'present',
#     settings                    => {
#       'holland:backup'          => {
#         'plugin'                => 'xtrabackup',
#         'after-backup-command'  => '/usr/local/bin/archive_backup',
#         'failed-backup-command' => '/usr/local/bin/notify_backup_failure',
#         'auto-purge-failures'   => true,
#         'backups-to-keep'       => 2,
#         'purge-policy'          => 'before-backup',
#         'estimated-size-factor' => '0.20',
#       },
#       'compression' => {
#         'method'    => 'gzip',
#         'options'   => "''",
#         'level'     => 1,
#       },
#       'tar'       => {
#         'exclude' => 'mysql.sock',
#       },
#     },
#   }
#
define holland::backupset(
  String $backupset_name               = $title,
  Stdlib::Absolutepath $backupsets_dir = $holland::backupsets_dir,
  Enum['absent','present'] $ensure     = 'present',
  String $file_name                    = "${backupset_name}.conf",
  Hash $settings                       = {},
) {

  $file_path = "${backupsets_dir}/${file_name}"

  $settings.each |$section,$sets| {
    $sets.each |$setting,$value| {
      ini_setting { "holland_backupset ${backupset_name}/${section}/${setting}":
        ensure  => $ensure,
        path    => $file_path,
        section => $section,
        setting => $setting,
        value   => $value,
      }
    }
  }

}
