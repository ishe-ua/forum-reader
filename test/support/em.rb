def run_em
  Thread.new { EM.run } unless EM.reactor_running?
  sleep(1) unless EM.reactor_running?
end

def wait_defers
  sleep(1) unless EM.defers_finished?
end

def stop_em
  return unless EM.reactor_running?
  wait_defers
  EM.stop if EM.reactor_running?
end
