require "minitest/autorun"
require "socket"

describe_recipe "memcached::default" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "packages" do
    it "installs the memcached package" do
      package("memcached").must_be_installed
    end
  end

  describe "files" do
    it "creates the configuration file" do
      case node["platform_family"]
      when "rhel"
        file("/etc/sysconfig/memcached").must_exist 
      when "debian"
        file("/etc/memcached.conf").must_exist
      end
    end

    it "creates the log file" do
      if node["platform_family"] == "debian"
        file(node["memcached"]["log_file"]).must_exist
      end
    end
  end

  describe "services" do
    it "runs as a daemon" do
      service("memcached").must_be_running
    end

    it "boots on startup" do
      service("memcached").must_be_enabled
    end

    it "accepts connections" do
      s = TCPSocket.new(node["memcached"]["listen"], node["memcached"]["port"])
      s.puts("version\r\n")
      version = s.gets
      s.close

      assert(version =~ /VERSION/)
    end
  end
end
