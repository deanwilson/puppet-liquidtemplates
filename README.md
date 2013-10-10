# Liquid Templates in Puppet Function #

Liquid is a 'Ruby library for rendering safe templates which cannot
affect the security of the server they are rendered on.' This function
allows you to write your templates using Liquid -

    $ cat << 'EOC' > liquidtest/templates/test.liquid
    SELinux is {{ selinux_config_mode | upcase }} on {{ fqdn }}
    EOC

And call them from your puppet modules -

    cat << 'EOC' > liquidtest/manifests/init.pp
    class liquidtest {

      file { '/tmp/liquidtest':
        ensure  => 'file',
        content => liquid_template('liquidtest/test.liquid'),
      }

    }

using a templating engine that does not allow arbitrary ruby code to run.

More details can be found in the
[Liquid Templates in Puppet](http://www.unixdaemon.net/tools/puppet/liquid-templates-in-puppet-initial-release.html) blog post.

Note:
This function requires the liquid gem to be available on the puppetmaster. Which you are managing via puppet, right?
