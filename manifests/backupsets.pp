# holland::backupsets
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include holland::backupsets
class holland::backupsets {

  $backupsets = $holland::merge_backupsets ? {
    false   => $holland::backupsets,
    default => lookup('holland::backupsets', Optional[Hash], 'deep', undef),
  }

  if $backupsets {
    $backupsets.each |$bset,$opts| {
      holland::backupset { "holland_backupset ${bset}":
        *              => $opts,
        backupset_name => $bset,
      }
    }
  }

}
