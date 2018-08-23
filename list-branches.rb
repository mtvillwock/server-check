require 'rubygems'
require 'net/ssh'
require 'pry'
# http://www.heatware.net/ruby-rails/how-to-ssh-to-server-ruby-part-ii/

class ListBranches
  def initialize(environments:)
    @environments = environments
    @hostname = 'localhost'
    @username = 'username'
    @password = 'password'
    @cmd = 'ls -al'
  end

  def call
    print_branches
  end

  private

  def print_branches
    return if @environments.empty?
    @environments.each do |env|
      ssh_call
    end
  end

  def ssh_call
    begin
      ssh = Net::SSH.start(@hostname, @username, password: @password)
      res = ssh.exec!(@cmd)
      ssh.close
      puts res
    rescue
     puts "Unable to connect to #{@hostname} using #{@username}/#{@password}"
    end
  end
end

envs = [
  'development'
]

ListBranches.new(environments: envs).call
