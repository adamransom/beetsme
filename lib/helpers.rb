class Helpers
  BASH = '/bin/bash'

  def self.exec(cmd)
    system(BASH, '-c', cmd)
  end

  def self.read_exec(cmd)
    bash cmd
  end

  private

  def self.bash(cmd)
      IO.popen([BASH, '-c', cmd]) { |io| io.read }
  end
end
