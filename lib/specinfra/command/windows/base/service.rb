class Specinfra::Command::Windows::Base::Service < Specinfra::Command::Windows::Base
  class << self
    def check_is_installed(service)
      Backend::PowerShell::Command.new do
        using 'find_service.ps1'
        exec "@(FindService -name '#{service}').count -gt 0"
      end
    end

    def check_has_start_mode(service, mode)
      Backend::PowerShell::Command.new do
        using 'find_service.ps1'
        exec  "'#{mode}' -match (FindService -name '#{service}').StartMode -and (FindService -name '#{service}') -ne $null"
      end
    end

    def check_is_enabled(service, level=nil)
      Backend::PowerShell::Command.new do
        using 'find_service.ps1'
        exec "(FindService -name '#{service}').StartMode -eq 'Auto'"
      end
    end

    def check_is_running(service)
      Backend::PowerShell::Command.new do
        using 'find_service.ps1'
        exec "(FindService -name '#{service}').State -eq 'Running'"
      end
    end
    def check_service_is_running_under_localsystem
      $selector = "| Where-Object { -not (($_.StartName -match 'NT AUTHORITY') -or ( $_.StartName -match 'NT SERVICE') -or ($_.StartName -match 'NetworkService' ) -or ($_.StartName -match 'LocalSystem' ))"
    end

    def check_has_property(service,property,value=nil)
      Backend::PowerShell::Command.new do
        using 'find_service.ps1'
        if value
          exec "((FindService -name '#{service}').'#{property}' -ne $null)"
        else
          exec "((FindService -name '#{service}').'#{property}' -match '#{value}')"
          # exec "((FindService -name '#{service}')| ConvertTo-Json) -replace '\\r?\\n', ' ' "
        end 
      end
    end
    
    def get_property(service, property = nil)
      Backend::PowerShell::Command.new do
        using 'find_service.ps1'
        if property 
          (exec "(FindService -name '#{service}').#{property}").stdout
        else
          (exec "((FindService -name '#{service}')| ConvertTo-Json) -replace '\\r?\\n', ' '").stdout
        end 
      end
    end
  end
end
