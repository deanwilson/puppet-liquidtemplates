# Liquid Templates in Puppet Function #

Liquid is a 'Ruby library for rendering safe templates which cannot
affect the security of the server they are rendered on.' This function
allows you to write your templates using Liquid -

    $ cat << 'EOC' > liquidtest/templates/test.liquid
    SELinux is {{ selinux_config_mode | upcase }} on {{ fqdn }}
    EOC

And call them from your puppet modules -

    class liquidtest {

      file { '/tmp/liquidtest':
        ensure  => 'file',
        content => liquid_template('liquidtest/test.liquid'),
      }

    }

More details can be found in the
[Liquid Templates in Puppet](http://www.unixdaemon.net/puppet/liquid-templates-in-puppet-initial-release/) blog post.

Note:
This function requires the liquid gem to be available on the puppetmaster. Which you are managing via puppet, right?

### License ###

GPL v2.0 - [Dean Wilson](http://www.unixdaemon.net)
