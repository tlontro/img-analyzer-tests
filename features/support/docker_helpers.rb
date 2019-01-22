require 'mkmf'
require 'open3'

module DockerHelpers
  def self.docker_host
    if @docker_host.nil?
      host = if find_executable('docker-machine')
               `docker-machine ip default`.strip
             else
               'localhost'
             end
      @docker_host = host
    end
    @docker_host
  end

  def self.selenium_hub_port
    machine_name = ENV['DOCKER_CONTAINER'] || 'docker-selenium-healthscore-ci'
    @selenium_hub_port ||= get_port(machine_name, 4444)
  end

  def self.get_port(container_name, container_port)
    stdout_str, status = Open3.capture2("docker port #{container_name} #{container_port}")
    port = stdout_str.split(':')[1].strip!.to_i
    port
  end
end
