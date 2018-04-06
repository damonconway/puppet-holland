# holland::providers
#
# A private wrapper class for creating the providers specified in
# $holland::providers.
# 
# @summary Create providers given in holland::providers
#
class holland::providers {

  $providers = $holland::merge_providers ? {
    false   => $holland::providers,
    default => lookup('holland::providers', Optional[Hash], 'deep', undef),
  }

  if $providers {
    $providers.each |$prov,$opts| {
      holland::provider { "holland_provider ${prov}":
        *             => $opts,
        provider_name => $prov,
      }
    }
  }

}
