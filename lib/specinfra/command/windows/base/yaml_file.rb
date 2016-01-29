class Specinfra::Command::Windows::Base::YamlFile< Specinfra::Command::Windows::Base
  class << self
    def check_run_has_resource(puppet_run_log, resource_name, resource_type)
      cmd = generate_command puppet_run_log, resource_name, resource_type, 'FindResource'
      Backend::PowerShell::Command.new do
        using 'yaml_serializer2.ps1'
        exec cmd
      end
    end
    def check_run_has_message(puppet_run_log, text, source)
      cmd = generate_command puppet_run_log, text, source, 'FindMessage'
      Backend::PowerShell::Command.new do
        using 'yaml_serializer2.ps1'
        exec cmd
      end
    end
    def check_run_has_resource_message(puppet_run_log, resource_name, resource_type, text)
      cmd = generate_command puppet_run_log, resource_name, resource_type, text, 'FindResourceEventMessage'
      Backend::PowerShell::Command.new do
        using 'yaml_serializer2.ps1'
        exec cmd
      end
    end
    private
    def generate_command item, value, attribute
     # 	"FindResourceEventMessage '#{puppet_run_log}' -name '#{resource_name}' -type '#{resource_type}' -text '#{message_text}'"
     # "FindResource -log '#{puppet_run_log}' -name '#{resource_name}' -type '#{resource_type}'"
     # "FindMessage -log '#{puppet_run_log}' -text '#{text}'" [-source '#{source}']
    end
  end
end
