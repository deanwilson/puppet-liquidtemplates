module Puppet::Parser::Functions
  require 'liquid'

  newfunction(:liquid_template, :type => :rvalue, :doc => <<-EOD
    A Puppet function that allows you to use Liquid templates instead of plain ERB.

    Liquid templates are more restrictive in what they allow and do not permit execution of arbitary ruby code. So no calls to 'rm' on the puppetmaster.

    Does not support inline templates. On purpose.
  EOD
  ) do |files|

    raise Puppet::ParseError, 'No template file supplied to liquid_template' if files.empty?

    files.collect do |file|
      template_file = nil


      Puppet.debug "Processing #{file} with liquid_template"

      template_file = Puppet::Parser::Files.find_template(file, self.compiler.environment)
      raise Puppet::ParseError, "Could not find template '#{file}'" unless template_file

      # expose our scope to the templates content.
      exposed_vars = {}
      self.to_hash.each do |name, value|
        realname = name.gsub(/[^\w]/, "_")
        exposed_vars[realname] = value
      end

      template_content = ::Liquid::Template.parse(File.new(template_file).read)
      template_content.render(exposed_vars)

    end.join("")
  end
end
