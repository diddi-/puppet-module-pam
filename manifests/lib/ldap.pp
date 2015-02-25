class pam::lib::ldap (
  $ensure  = 'installed',
  $package = undef
) {

  if $package {
    $my_package = $package
  } else {
    case $::osfamily {
      'RedHat': {
        case $::operatingsystemmajrelease {
          '5','6','7': {
            $my_package = 'pam_ldap'
          }
          default: {
            fail("a custom PAM LDAP module package is required for ${::osfamily} release ${::operatingsystemmajrelease}")
          }
        }
      }
      'Debian': {
        case $::lsbdistid{
          'Ubuntu': {
            case $::lsbdistrelease {
              '12.04','14.04': {
                $my_package = 'libpam-ldap'
              }
              default: {
                fail("a custom PAM LDAP module package is required for ${::osfamily} release ${::operatingsystemmajrelease}")
              }
            }
          }
          default:{
            case $::operatingsystemmajrelease {
              '6': {
                $my_package = 'libpam-ldap'
              }
              default: {
                fail("a custom PAM LDAP module package is required for ${::osfamily} release ${::operatingsystemmajrelease}")
              }
            }
          }
        }
      }
      'Suse':{
        case $::lsbmajdistrelease {
          '9','10','11','12': {
            $my_package = 'pam_ldap'
          }
          default: {
            fail("a custom PAM LDAP module package is required for ${::osfamily} release ${::operatingsystemmajrelease}")
          }
        }
      }
      # 'Solaris':{
      #   # No packages for Solaris
      # }
      default:{
        fail("a custom PAM LDAP module package is required for ${::osfamily}")
      }
    }
  }

  package{$my_package:
    ensure => $ensure,
  }

}